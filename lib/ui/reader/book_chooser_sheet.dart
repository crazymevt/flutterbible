import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/content_providers.dart';
import '../../app/reader_state.dart';

class BookChooserSheet extends ConsumerStatefulWidget {
  const BookChooserSheet({super.key});

  @override
  ConsumerState<BookChooserSheet> createState() => _BookChooserSheetState();
}

class _BookChooserSheetState extends ConsumerState<BookChooserSheet> {
  int? selectedBookId;
  String? selectedBookName;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                if (selectedBookId != null)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        selectedBookId = null;
                        selectedBookName = null;
                      });
                    },
                  ),
                Expanded(
                  child: Text(
                    selectedBookName ?? 'Select Book',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: selectedBookId != null
                        ? TextAlign.left
                        : TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: selectedBookId == null
                  ? _buildBookList()
                  : _buildChapterGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookList() {
    final activeVersions = ref.watch(activeVersionsProvider);
    if (activeVersions.isEmpty) return const SizedBox.shrink();

    final booksAsync = ref.watch(booksForVersionProvider(activeVersions.first));

    return booksAsync.when(
      data: (books) {
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return ListTile(
              title: Text(book.name),
              onTap: () {
                setState(() {
                  selectedBookId = book.id;
                  selectedBookName = book.name;
                });
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildChapterGrid() {
    final chaptersAsync = ref.watch(chapterCountProvider(selectedBookId!));

    return chaptersAsync.when(
      data: (count) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: count,
          itemBuilder: (context, index) {
            final chapter = index + 1;
            return InkWell(
              onTap: () {
                ref
                    .read(selectedBookNameProvider.notifier)
                    .set(selectedBookName!);
                ref.read(selectedChapterProvider.notifier).set(chapter);
                ref.read(navigationControllerProvider).recordHistory();
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$chapter',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
