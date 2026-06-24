/// Parser and typed model for a SWORD module `.conf` file.
///
/// A SWORD module is described by a small INI-like `.conf` file living in the
/// distribution's `mods.d/` directory. The conf drives everything about how the
/// binary data files are read, so it is the first thing any SWORD importer must
/// understand. Example:
///
/// ```
/// [KJV]
/// DataPath=./modules/texts/ztext/kjv/
/// ModDrv=zText
/// SourceType=OSIS
/// CompressType=ZIP
/// BlockType=BOOK
/// Encoding=UTF-8
/// Lang=en
/// Versification=KJV
/// GlobalOptionFilter=OSISStrongs
/// GlobalOptionFilter=OSISFootnotes
/// Description=King James Version (1769)
/// About=\
/// This is the King James Version.\par\
/// Public domain.
/// ```
///
/// This parser is pure Dart (no IO) and takes the already-decoded conf text, so
/// it is trivially unit-testable. It preserves every raw key/value pair
/// (including repeated keys such as `GlobalOptionFilter`) and layers typed
/// convenience getters on top for the fields that drive importer dispatch.
library;

/// The module driver, declared by the conf's `ModDrv` key. Determines the
/// on-disk data layout and which content type the module holds.
enum SwordModDrv {
  // Bible text.
  rawText,
  rawText4,
  zText,
  zText4,
  // Commentaries.
  rawCom,
  rawCom4,
  zCom,
  zCom4,
  // Lexicons / dictionaries.
  rawLD,
  rawLD4,
  zLD,
  // General books (tree-structured).
  rawGenBook,
  // Anything we don't recognise.
  unknown;

  /// True for the compressed Bible/commentary/dictionary drivers (`z*`), whose
  /// data is stored as zlib/bzip2/lzss blocks rather than flat records.
  bool get isCompressed => switch (this) {
        zText || zText4 || zCom || zCom4 || zLD => true,
        _ => false,
      };

  /// True for Bible-text drivers (`zText`/`RawText`).
  bool get isBible => switch (this) {
        rawText || rawText4 || zText || zText4 => true,
        _ => false,
      };

  /// True for commentary drivers (`zCom`/`RawCom`).
  bool get isCommentary => switch (this) {
        rawCom || rawCom4 || zCom || zCom4 => true,
        _ => false,
      };

  /// True for lexicon/dictionary drivers (`zLD`/`RawLD`).
  bool get isDictionary => switch (this) {
        rawLD || rawLD4 || zLD => true,
        _ => false,
      };
}

/// The markup used inside each entry, declared by the conf's `SourceType` key.
/// Defaults to [plaintext] when unspecified.
enum SwordSourceType { osis, gbf, thml, tei, plaintext }

/// The compression applied to a `z*` driver's data blocks, declared by the
/// conf's `CompressType` key. Absent for the uncompressed `Raw*` drivers.
enum SwordCompressType { zip, lzss, bzip2, xz }

/// A parsed SWORD module `.conf` file.
class SwordConfig {
  /// The module's internal name, taken from the `[Name]` section header
  /// (e.g. `KJV`). This is the canonical identifier used across a SWORD
  /// installation, not the human-readable [description].
  final String name;

  /// Every key/value pair from the conf, keyed by the raw conf key. Repeated
  /// keys (e.g. `GlobalOptionFilter`, `Feature`, `History_*`) accumulate into
  /// the value list in file order. Keys are stored verbatim (case-sensitive,
  /// as SWORD treats them).
  final Map<String, List<String>> raw;

  const SwordConfig({required this.name, required this.raw});

  /// The first value declared for [key], or null if absent.
  String? value(String key) {
    final list = raw[key];
    return (list == null || list.isEmpty) ? null : list.first;
  }

  /// Every value declared for [key], in file order (empty if absent).
  List<String> values(String key) => raw[key] ?? const [];

  /// Relative path (from the distribution root) to the module's data, e.g.
  /// `./modules/texts/ztext/kjv/`. For `z*`/`Raw*` Bible drivers this is the
  /// directory holding the `ot`/`nt` data files; for dictionaries/genbooks it
  /// is a file-basename prefix.
  String? get dataPath => value('DataPath');

  /// The module driver. Returns [SwordModDrv.unknown] for missing or
  /// unrecognised `ModDrv` values.
  SwordModDrv get modDrv {
    switch (value('ModDrv')?.toLowerCase()) {
      case 'rawtext':
        return SwordModDrv.rawText;
      case 'rawtext4':
        return SwordModDrv.rawText4;
      case 'ztext':
        return SwordModDrv.zText;
      case 'ztext4':
        return SwordModDrv.zText4;
      case 'rawcom':
        return SwordModDrv.rawCom;
      case 'rawcom4':
        return SwordModDrv.rawCom4;
      case 'zcom':
        return SwordModDrv.zCom;
      case 'zcom4':
        return SwordModDrv.zCom4;
      case 'rawld':
        return SwordModDrv.rawLD;
      case 'rawld4':
        return SwordModDrv.rawLD4;
      case 'zld':
        return SwordModDrv.zLD;
      case 'rawgenbook':
        return SwordModDrv.rawGenBook;
      default:
        return SwordModDrv.unknown;
    }
  }

  /// The per-entry markup. Defaults to [SwordSourceType.plaintext] when the
  /// conf omits `SourceType`.
  SwordSourceType get sourceType {
    switch (value('SourceType')?.toLowerCase()) {
      case 'osis':
        return SwordSourceType.osis;
      case 'gbf':
        return SwordSourceType.gbf;
      case 'thml':
        return SwordSourceType.thml;
      case 'tei':
        return SwordSourceType.tei;
      default:
        return SwordSourceType.plaintext;
    }
  }

  /// The block compression for `z*` drivers, or null if absent/unrecognised.
  SwordCompressType? get compressType {
    switch (value('CompressType')?.toLowerCase()) {
      case 'zip':
        return SwordCompressType.zip;
      case 'lzss':
        return SwordCompressType.lzss;
      case 'bzip2':
        return SwordCompressType.bzip2;
      case 'xz':
        return SwordCompressType.xz;
      default:
        return null;
    }
  }

  /// The compression-block granularity for `zText`/`zCom` (`BOOK`, `CHAPTER`,
  /// or `VERSE`), upper-cased. Null when absent.
  String? get blockType => value('BlockType')?.toUpperCase();

  /// The versification scheme name (e.g. `KJV`, `Synodal`, `LXX`). SWORD
  /// defaults to `KJV` when `Versification` is omitted.
  String get versification => value('Versification') ?? 'KJV';

  /// The character encoding of the module data. SWORD defaults to `Latin-1`
  /// when `Encoding` is omitted.
  String get encoding => value('Encoding') ?? 'Latin-1';

  /// True when the module data is UTF-8 encoded.
  bool get isUtf8 => encoding.toLowerCase().replaceAll('-', '') == 'utf8';

  /// The language code (`Lang`), e.g. `en`. Null when absent.
  String? get lang => value('Lang');

  /// Short one-line module description (`Description`). Null when absent.
  String? get description => value('Description');

  /// Long free-text "about" blurb (`About`). May contain RTF-ish `\par`
  /// markers and span multiple conf lines (joined during parsing). Null when
  /// absent.
  String? get about => value('About');

  /// The `GlobalOptionFilter` values, which name the inline features present
  /// (e.g. `OSISStrongs`, `OSISFootnotes`, `OSISMorph`).
  List<String> get globalOptionFilters => values('GlobalOptionFilter');

  /// The redistribution terms (`DistributionLicense`). Null when absent.
  String? get distributionLicense => value('DistributionLicense');

  /// The full copyright notice (`Copyright`). Null when absent.
  String? get copyright => value('Copyright');

  /// The short one-line copyright (`ShortCopyright`). Null when absent.
  String? get shortCopyright => value('ShortCopyright');

  /// Whether the module's stated [distributionLicense] grants redistribution,
  /// so we may legally download and re-host it.
  ///
  /// `DistributionLicense` is a free-text field, but CrossWire uses a small set
  /// of canonical phrasings. We recognise only the ones that explicitly permit
  /// distribution (public domain, Creative Commons, the GNU licenses, and the
  /// "Free .../Permission … to distribute" copyrighted grants). A bare
  /// `Copyrighted`, an unrecognised phrasing, or an absent license is treated
  /// as NOT freely distributable — fail closed rather than re-host content we
  /// have no clear right to.
  bool get isFreelyDistributable {
    final lic = distributionLicense?.toLowerCase().trim();
    if (lic == null || lic.isEmpty) return false;
    const grants = [
      'public domain',
      'creative commons',
      'general public license',
      'free documentation license',
      'gpl',
      'gfdl',
      'free non-commercial',
      'free for non-commercial',
      'permission to distribute',
      'permission granted to distribute',
      'distribution for any purpose',
      'distribution granted',
    ];
    return grants.any(lic.contains);
  }

  /// Parse SWORD conf [text] (already decoded to a String) into a config.
  ///
  /// Handles `#` comments, the `[Name]` section header, repeated keys, and
  /// trailing-backslash line continuation (a `\` as the last character of a
  /// line joins it to the next, e.g. multi-line `About=` blocks).
  static SwordConfig parse(String text) {
    // Normalise line endings so trailing-backslash detection is reliable.
    final normalised = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    final rawLines = normalised.split('\n');

    // Fold continuation lines: a line ending in '\' is joined to the next, with
    // the backslash dropped. Comment/blank lines are not continuation sources.
    final logicalLines = <String>[];
    final buffer = StringBuffer();
    var continuing = false;
    for (final line in rawLines) {
      if (!continuing) {
        final trimmedStart = line.trimLeft();
        if (trimmedStart.isEmpty || trimmedStart.startsWith('#')) {
          // Skip blanks and comments outright; they can't be continued.
          continue;
        }
      }
      if (line.endsWith('\\')) {
        buffer.write(line.substring(0, line.length - 1));
        continuing = true;
      } else {
        buffer.write(line);
        logicalLines.add(buffer.toString());
        buffer.clear();
        continuing = false;
      }
    }
    if (buffer.isNotEmpty) logicalLines.add(buffer.toString());

    String name = '';
    final raw = <String, List<String>>{};
    for (final line in logicalLines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty || trimmed.startsWith('#')) continue;

      if (trimmed.startsWith('[') && trimmed.endsWith(']')) {
        name = trimmed.substring(1, trimmed.length - 1).trim();
        continue;
      }

      final eq = trimmed.indexOf('=');
      if (eq < 0) continue; // Not a key/value line; ignore.
      final key = trimmed.substring(0, eq).trim();
      final value = trimmed.substring(eq + 1).trim();
      if (key.isEmpty) continue;
      raw.putIfAbsent(key, () => <String>[]).add(value);
    }

    return SwordConfig(name: name, raw: raw);
  }
}
