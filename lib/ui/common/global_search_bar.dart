import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../app/search_providers.dart';
import '../../app/app_state.dart';
import '../../app/content_providers.dart';
import '../../app/user_providers.dart';
import '../../domain/search/reference_parser.dart';
import '../../app/reader_state.dart';

class GlobalSearchBar extends ConsumerStatefulWidget {
  const GlobalSearchBar({super.key});

  @override
  ConsumerState<GlobalSearchBar> createState() => _GlobalSearchBarState();
}

class _GlobalSearchBarState extends ConsumerState<GlobalSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitSearch(String value) {
    if (value.isNotEmpty) {
      ref.read(globalSearchQueryProvider.notifier).setQuery(value);
      ref.read(activeToolProvider.notifier).openTool(ActiveTool.search);
      
      final currentModule = ref.read(appModuleProvider);
      if (currentModule != AppModule.reader) {
        ref.read(appModuleProvider.notifier).setModule(AppModule.reader);
      } else {
        // We are already in the reader. 
        // If there's an endDrawer (i.e. on mobile), open it so the user can see results.
        final scaffold = Scaffold.maybeOf(context);
        if (scaffold != null && scaffold.hasEndDrawer) {
          scaffold.openEndDrawer();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      textEditingController: _controller,
      focusNode: _focusNode,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final text = textEditingValue.text;
        if (text.trim().isEmpty) {
          return const Iterable<String>.empty();
        }

        // A leading `#` is a tag search; suggest matching tag names instead of
        // content words or references.
        if (text.trimLeft().startsWith('#')) {
          final term = text.trim().substring(1).toLowerCase();
          if (term.isEmpty) return const Iterable<String>.empty();
          final safeTerm = term.replaceAll("'", "''");
          try {
            final rows = await ref.read(userStoreProvider).customSelect(
              "SELECT DISTINCT name FROM tags WHERE deleted = 0 "
              "AND LOWER(name) LIKE ? ORDER BY name LIMIT 15",
              variables: [drift.Variable.withString('$safeTerm%')],
            ).get();
            return rows.map((row) => '#${row.read<String>('name')}');
          } catch (e) {
            return const Iterable<String>.empty();
          }
        }

        final contentStore = ref.read(contentStoreProvider);
        final List<String> results = [];
        final currentModule = ref.read(appModuleProvider);
        if (currentModule == AppModule.reader && text.isNotEmpty) {
          results.add('Find on page: $text');
        }

        try {
          final activeVersions = ref.read(activeVersionsProvider);
          if (activeVersions.isNotEmpty) {
            final books = await ref.read(booksForVersionProvider(activeVersions.first).future);
            final parsed = ReferenceParser.parse(text, books);
            if (parsed != null) {
              String titleStr = parsed.book.name;
              if (parsed.chapter > 0) titleStr += ' ${parsed.chapter}';
              if (parsed.verse != null) titleStr += ':${parsed.verse}';
              results.add('Go to: $titleStr');
            }
          }
        } catch (e) {
          debugPrint('Failed to build "go to reference" suggestion: $e');
        }

        final words = text.split(RegExp(r'\s+'));
        final lastWord = words.last.toLowerCase();
        
        if (lastWord.length >= 2) {
          // Escape single quotes for SQL
          final safeWord = lastWord.replaceAll("'", "''");
          try {
            // Only suggest real word-like terms. The FTS index includes raw
            // commentary HTML, so the vocab is polluted with markup and junk
            // tokens (e.g. embedded ids); restrict to alphabetic terms of a
            // sane length so those don't surface as autocomplete suggestions.
            final rows = await contentStore.customSelect(
              "SELECT term FROM content_vocab WHERE term LIKE ? "
              "AND term NOT GLOB '*[^a-z]*' AND length(term) BETWEEN 2 AND 18 "
              "ORDER BY cnt DESC LIMIT 15",
              variables: [drift.Variable.withString('$safeWord%')],
            ).get();
            results.addAll(rows.map((row) => row.read<String>('term')));
          } catch (e) {
            // ignore
          }
        }
        return results;
      },
      onSelected: (String selection) async {
        if (selection.startsWith('Find on page: ')) {
          final query = selection.replaceFirst('Find on page: ', '');
          ref.read(findInPageQueryProvider.notifier).set(query);
          _focusNode.unfocus();
          _controller.clear();
          return;
        }

        if (selection.startsWith('Go to: ')) {
          final refStr = selection.replaceFirst('Go to: ', '');
          final activeVersions = ref.read(activeVersionsProvider);
          if (activeVersions.isNotEmpty) {
            final books = await ref.read(booksForVersionProvider(activeVersions.first).future);
            final parsed = ReferenceParser.parse(refStr, books);
            
            if (parsed != null) {
              ref.read(selectedBookNameProvider.notifier).set(parsed.book.name);
              ref.read(selectedChapterProvider.notifier).set(parsed.chapter);
              if (parsed.verse != null) {
                ref.read(targetVerseToScrollProvider.notifier).set(parsed.verse!);
                ref.read(selectedVersesProvider.notifier).clear();
                ref.read(selectedVersesProvider.notifier).toggle(parsed.verse!);
              }
              ref
                  .read(navigationControllerProvider)
                  .recordHistory(verse: parsed.verse);
              ref.read(appModuleProvider.notifier).setModule(AppModule.reader);
              _focusNode.unfocus();
              _controller.clear();
              return;
            }
          }
        }

        final currentText = _controller.text;
        final parts = currentText.trimRight().split(RegExp(r'\s+'));
        if (parts.isNotEmpty) {
          parts.removeLast();
        }
        parts.add(selection);
        final newText = '${parts.join(' ')} ';
        _controller.text = newText;
        _controller.selection = TextSelection.collapsed(offset: newText.length);
        
        // Automatically submit the search
        _submitSearch(newText);
      },
      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Search entire library...',
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            // The search icon lives inside the field (rather than as a fixed
            // sibling in the title Row) so the title pill can never overflow
            // when AppBar actions squeeze it on narrow screens.
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 0),
          ),
          onSubmitted: (value) {
            _submitSearch(value);
          },
        );
      },
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250, maxWidth: 350),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  final isGoto = option.startsWith('Go to: ');
                  final isFind = option.startsWith('Find on page: ');
                  final isTag = option.startsWith('#');
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      isGoto
                          ? Icons.menu_book
                          : (isFind
                              ? Icons.find_in_page
                              : (isTag ? Icons.label : Icons.search)),
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      option,
                      style: TextStyle(
                        fontWeight: (isGoto || isFind) ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
