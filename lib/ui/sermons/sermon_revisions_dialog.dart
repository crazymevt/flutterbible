import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../app/sermon_providers.dart';
import '../../data/fts_text.dart';
import '../../data/user_store.dart';

/// Lists a sermon's saved revisions and lets the user save the current state as
/// a new revision, delete revisions, or restore one.
///
/// Restoring does not write the sermon here — it pops with the chosen revision
/// so the open editor can apply the restore and reload its document in one
/// place (avoiding the stale-editor problem this whole feature guards against).
class SermonRevisionsDialog extends ConsumerWidget {
  final String sermonId;
  final String currentTitle;
  final String? currentSeries;
  final String currentContent;

  const SermonRevisionsDialog({
    super.key,
    required this.sermonId,
    required this.currentTitle,
    this.currentSeries,
    required this.currentContent,
  });

  /// Shows the dialog. Resolves to the [SermonRevision] the user chose to
  /// restore, or `null` if they just closed it.
  static Future<SermonRevision?> show(
    BuildContext context, {
    required String sermonId,
    required String currentTitle,
    String? currentSeries,
    required String currentContent,
  }) {
    return showDialog<SermonRevision?>(
      context: context,
      builder: (_) => SermonRevisionsDialog(
        sermonId: sermonId,
        currentTitle: currentTitle,
        currentSeries: currentSeries,
        currentContent: currentContent,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revisionsAsync = ref.watch(sermonRevisionsProvider(sermonId));

    return AlertDialog(
      title: const Text('Revision History'),
      content: SizedBox(
        width: 460,
        height: 460,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.bookmark_add_outlined),
                label: const Text('Save current version'),
                onPressed: () => _saveCurrent(context, ref),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: revisionsAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (revisions) {
                  if (revisions.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No revisions yet.\n\nSave a version to keep a '
                          'restore point, or one will be created automatically '
                          'if an edit from another device overwrites your work.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: revisions.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) =>
                        _RevisionTile(revision: revisions[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Future<void> _saveCurrent(BuildContext context, WidgetRef ref) async {
    // Returns the (possibly empty) trimmed label on Save, or null on Cancel.
    final label = await showDialog<String?>(
      context: context,
      builder: (_) => const _SaveRevisionDialog(),
    );
    if (label == null) return; // cancelled

    await ref.read(sermonRevisionActionProvider).saveRevision(
          sermonId: sermonId,
          title: currentTitle,
          series: currentSeries,
          content: currentContent,
          label: label.isEmpty ? null : label,
          kind: RevisionKind.manual,
        );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Revision saved')),
      );
    }
  }
}

/// Optional-label prompt for saving a revision. A [StatefulWidget] so its
/// controller is disposed in [State.dispose] — i.e. after the route is fully
/// removed — rather than the instant `showDialog` returns, which races the
/// dismiss animation and throws "TextEditingController used after disposed"
/// (see _NewSermonDialog in sermons_panel.dart). Pops with the trimmed label on
/// Save, or null on Cancel.
class _SaveRevisionDialog extends StatefulWidget {
  const _SaveRevisionDialog();

  @override
  State<_SaveRevisionDialog> createState() => _SaveRevisionDialogState();
}

class _SaveRevisionDialogState extends State<_SaveRevisionDialog> {
  final _labelController = TextEditingController();

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Revision'),
      content: TextField(
        controller: _labelController,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Label (optional)',
          hintText: 'e.g. First draft',
        ),
        onSubmitted: (_) =>
            Navigator.of(context).pop(_labelController.text.trim()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () =>
              Navigator.of(context).pop(_labelController.text.trim()),
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _RevisionTile extends ConsumerWidget {
  final SermonRevision revision;

  const _RevisionTile({required this.revision});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final when = DateFormat('MMM d, y · h:mm a').format(
      DateTime.fromMillisecondsSinceEpoch(revision.createdAt).toLocal(),
    );
    final preview = deltaToPlainText(revision.content).trim();
    final snippet =
        preview.length > 120 ? '${preview.substring(0, 120)}…' : preview;

    final (icon, kindLabel) = switch (revision.kind) {
      RevisionKind.conflict => (
          Icons.warning_amber_rounded,
          'Backup — overwritten by another device',
        ),
      RevisionKind.restore => (
          Icons.history,
          'Snapshot before a restore',
        ),
      _ => (Icons.bookmark_outline, 'Saved manually'),
    };

    return ListTile(
      leading: Icon(icon),
      title: Text(revision.label?.isNotEmpty == true
          ? '${revision.label} · $when'
          : when),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(kindLabel, style: Theme.of(context).textTheme.bodySmall),
          if (snippet.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                snippet,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
      isThreeLine: snippet.isNotEmpty,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => _confirmRestore(context),
            child: const Text('Restore'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete revision',
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmRestore(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore this revision?'),
        content: const Text(
          'The current version will be saved as a revision first, so you can '
          'undo this.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      // Pop the whole revisions dialog with this revision so the editor applies
      // the restore and reloads.
      Navigator.of(context).pop(revision);
    }
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete this revision?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref
          .read(sermonRevisionActionProvider)
          .deleteRevision(revision.id);
    }
  }
}
