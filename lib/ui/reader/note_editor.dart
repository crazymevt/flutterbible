import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../app/user_providers.dart';
import '../../app/reader_state.dart';

class NoteEditorDialog extends ConsumerStatefulWidget {
  final int? verse;

  const NoteEditorDialog({super.key, this.verse});

  @override
  ConsumerState<NoteEditorDialog> createState() => _NoteEditorDialogState();
}

class _NoteEditorDialogState extends ConsumerState<NoteEditorDialog> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExistingNote();
  }

  Future<void> _loadExistingNote() async {
    final store = ref.read(userStoreProvider);
    final bookName = ref.read(selectedBookNameProvider);
    final chapter = ref.read(selectedChapterProvider);

    final query = store.select(store.notes)
      ..where(
        (n) =>
            (n.bookName.equals(bookName)) &
            (n.chapter.equals(chapter)) &
            (n.deleted.equals(false)),
      );

    if (widget.verse != null) {
      query.where((n) => n.verse.equals(widget.verse!));
    } else {
      query.where((n) => n.verse.isNull());
    }

    final existing = await query.getSingleOrNull();
    if (existing != null && mounted) {
      _controller.text = existing.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.verse != null
            ? 'Note for Verse ${widget.verse}'
            : 'Chapter Note',
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: 8,
        decoration: const InputDecoration(
          hintText: 'Enter markdown note...',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        FilledButton(
          onPressed: () async {
            if (_controller.text.isNotEmpty) {
              await ref
                  .read(noteActionProvider)
                  .saveNote(widget.verse, _controller.text);
            }
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('SAVE'),
        ),
      ],
    );
  }
}
