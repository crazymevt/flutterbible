# TODO

Running list of known issues and follow-ups.

## Bugs

- [x] **Right-click dictionary lookup returns multiple words instead of the
  exact word.** Right-clicking (or long-pressing) a word in the reader to "Look
  up in Dictionary" showed every entry containing the term as a substring.
  - Fixed: `dictionarySearchQueryProvider` now carries an `exact` flag; the
    reader lookups request an exact (case-insensitive) headword match and show
    "No definitions found" when there's no exact headword (no substring
    fallback). The free-text search box keeps its substring behaviour.

## Enhancements

- [x] **Start TTS (read-aloud) from the selected verse, not the chapter
  beginning.** When a verse is selected, read-aloud now begins at the first
  selected verse instead of restarting from verse 1.
  - Fixed: `TtsController.toggle` forwards a `fromVerse` to `start`; the read
    aloud sheet seeds it from the lowest `selectedVersesProvider` entry (0 when
    nothing is selected) and shows "Starts at verse N" while idle. Pause/resume
    still continues where it left off.

- [ ] **Prompt existing users to rebuild the search index after the
  markup-stripping fix.** Verse search indexing was changed to strip MyBible
  markup (release 26.6.24+1), but already-installed Bibles keep their old
  polluted index until the user rebuilds it. We need to tell users to do this
  and make it one tap.
  - Surface a clear, friendly note at the **top of the "What's New" dialog**
    recommending a rebuild, with an inline action button that runs
    `ContentStore.rebuildSearchIndex()` (today it's buried in
    Settings → "Rebuild search index", `lib/ui/settings/settings_screen.dart`).
  - Consider only showing the note for users upgrading *into* this version (not
    fresh installs, which already index cleanly), and marking it done once the
    rebuild has been run so it doesn't nag.
  - Changelog renders from `assets/changelog.json`
    (`scripts/update_version.dart`); the dialog lives near the app's
    "What's New" / version display.

- [ ] **Auto check for updates.** Automatically check for updates and display
  a message indicating that a new version is available, along with a link to the
  latest releases page.

## Research

- [ ] **Investigate importing SWORD modules.** SWORD is the CrossWire module
  format used by many open Bible apps — a large library of translations,
  commentaries, and dictionaries. Scope out what it would take to import them:
  the on-disk module layout (conf + compressed `ztext`/`zld`/`zcom` data),
  the compression/encoding (LZSS/zlib, versification), and how it maps onto our
  existing `verses`/`commentary`/`dictionary` tables. We already import OSIS
  XML, and many SWORD modules are OSIS-encoded internally, so the existing
  `OsisImporter` (now milestone-aware) may be reusable for the text once a
  module is unpacked.
