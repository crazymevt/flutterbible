import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;
import '../app/version.dart';
import 'logging.dart';
import 'importer/sword/sword_config.dart';

enum ModuleType { bible, commentary, dictionary, subheadings, devotional }

class Ph4Module {
  final String url;
  final String abbr;
  final String title;
  final String author;
  final String infoUrl;
  final bool isPartial;
  final ModuleType type;

  Ph4Module({
    required this.url,
    required this.abbr,
    required this.title,
    required this.author,
    required this.infoUrl,
    required this.isPartial,
    required this.type,
  });
}

class OsisLanguage {
  final String code;
  final String name;

  OsisLanguage(this.code, this.name);
}

class OsisTranslation {
  final String name;
  final String title;
  final String downloadUrl;
  final String infoUrl;
  final int size;
  final String basename;

  OsisTranslation({
    required this.name,
    required this.title,
    required this.downloadUrl,
    required this.infoUrl,
    required this.size,
    required this.basename,
  });
}

class CrosswireModule {
  final SwordConfig config;
  final String repoDomain;
  final String repoPath;

  CrosswireModule({
    required this.config,
    required this.repoDomain,
    required this.repoPath,
  });
}

class ContentManagerApi {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {'User-Agent': 'Mozilla/5.0 (StudyBible Flutter/$appVersion)'},
      responseType: ResponseType.plain,
    ),
  );

  static const _osisLanguageNames = {
    "af": "Afrikaans",
    "ar": "Arabic",
    "bg": "Bulgarian",
    "ch": "Chamorro",
    "cs": "Czech",
    "da": "Danish",
    "de": "German",
    "en": "English",
    "es": "Spanish",
    "eu": "Basque",
    "fi": "Finnish",
    "fr": "French",
    "gd": "Scottish Gaelic",
    "he": "Hebrew",
    "hr": "Croatian",
    "ht": "Haitian Creole",
    "hu": "Hungarian",
    "it": "Italian",
    "ko": "Korean",
    "la": "Latin",
    "lv": "Latvian",
    "mi": "Maori",
    "no": "Norwegian",
    "pl": "Polish",
    "pt": "Portuguese",
    "ro": "Romanian",
    "ru": "Russian",
    "sq": "Albanian",
    "sv": "Swedish",
    "sw": "Swahili",
    "th": "Thai",
    "tl": "Tagalog",
    "tr": "Turkish",
    "vi": "Vietnamese",
    "zh": "Chinese",
  };

  /// Scrape ph4.org for MyBible modules
  Future<List<Ph4Module>> fetchPh4Modules() async {
    try {
      final response = await _dio.get('https://www.ph4.org/b4_1.php?l=en');
      final document = html_parser.parse(response.data);
      final rows = document.querySelectorAll('tr');

      final List<Ph4Module> modules = [];

      for (final row in rows) {
        final dlLink = row.querySelector('a[href*="_dl.php"]');
        if (dlLink == null) continue;

        final url = dlLink.attributes['href'];
        if (url == null) continue;

        final abbrMatch = RegExp(r'[?&]a=([^&]+)').firstMatch(url);
        final abbr = abbrMatch?.group(1);

        final titleDiv = row.querySelector('td.bqr div.btl');
        final titleRaw = titleDiv?.text ?? '';
        final title = titleRaw.replaceAll(RegExp(r'^★\s*'), ''); // remove star

        final authorLink = row.querySelector('td.bqr a.map');
        final author = authorLink?.text ?? '';

        final isPartial = dlLink.classes.contains('circle_d2');

        if (url.isNotEmpty && abbr != null && title.isNotEmpty) {
          final fullUrl = url.startsWith('http')
              ? url
              : 'https://www.ph4.org/$url';
          
          final infoUrl = 'https://www.ph4.org/b4_1.php?l=en';

          final lowerAbbr = abbr.toLowerCase();
          ModuleType type = ModuleType.bible;
          if (fullUrl.contains('commentaries') ||
              lowerAbbr.endsWith('.commentary')) {
            type = ModuleType.commentary;
          } else if (fullUrl.contains('dictionaries') ||
              lowerAbbr.endsWith('.dictionary')) {
            type = ModuleType.dictionary;
          } else if (fullUrl.contains('subheadings') ||
              lowerAbbr.endsWith('.subheadings')) {
            type = ModuleType.subheadings;
          } else if (fullUrl.contains('devotions') ||
              lowerAbbr.endsWith('.devotions')) {
            type = ModuleType.devotional;
          }

          modules.add(
            Ph4Module(
              url: fullUrl,
              abbr: abbr,
              title: title,
              author: author,
              infoUrl: infoUrl,
              isPartial: isPartial,
              type: type,
            ),
          );
        }
      }
      return modules;
    } catch (e, stack) {
      logError(e, stack, context: 'ContentManagerApi.fetchPh4Modules');
      rethrow;
    }
  }

  /// List available OSIS languages from GitHub
  Future<List<OsisLanguage>> fetchOsisLanguages() async {
    try {
      final response = await _dio.get(
        'https://api.github.com/repos/gratis-bible/bible/contents',
        options: Options(headers: {'Accept': 'application/vnd.github+json'}),
      );
      final List<dynamic> data = jsonDecode(response.data.toString());

      final List<OsisLanguage> languages = [];
      for (final item in data) {
        if (item['type'] == 'dir') {
          final code = item['name'] as String;
          final name = _osisLanguageNames[code] ?? code.toUpperCase();
          languages.add(OsisLanguage(code, name));
        }
      }
      languages.sort((a, b) => a.name.compareTo(b.name));
      return languages;
    } catch (e, stack) {
      logError(e, stack, context: 'ContentManagerApi.fetchOsisLanguages');
      rethrow;
    }
  }

  String _osisEdnBasename(String filename) {
    return filename
        .replaceAll(RegExp(r'\.xml$', caseSensitive: false), '')
        .replaceAll(RegExp(r'[^A-Za-z0-9._ -]'), '_')
        .trim();
  }

  /// List OSIS translations for a given language
  Future<List<OsisTranslation>> fetchOsisTranslations(String langCode) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/repos/gratis-bible/bible/contents/$langCode',
        options: Options(headers: {'Accept': 'application/vnd.github+json'}),
      );
      final List<dynamic> data = jsonDecode(response.data.toString());

      final List<OsisTranslation> translations = [];
      for (final item in data) {
        final name = item['name'] as String;
        if (item['type'] == 'file' && name.toLowerCase().endsWith('.xml')) {
          final title = name.replaceAll(
            RegExp(r'\.xml$', caseSensitive: false),
            '',
          );
          translations.add(
            OsisTranslation(
              name: name,
              title: title,
              downloadUrl: item['download_url'] as String,
              infoUrl: item['html_url'] as String,
              size: item['size'] as int,
              basename: _osisEdnBasename(name),
            ),
          );
        }
      }
      translations.sort((a, b) => a.title.compareTo(b.title));
      return translations;
    } catch (e, stack) {
      logError(e, stack,
          context: 'ContentManagerApi.fetchOsisTranslations($langCode)');
      rethrow;
    }
  }

  /// Download a file with progress tracking
  Future<void> downloadFile(
    String url,
    String targetPath, {
    void Function(int, int)? onReceiveProgress,
  }) async {
    final dioDownload = Dio(
      BaseOptions(headers: {'User-Agent': 'Mozilla/5.0 (StudyBible Flutter/$appVersion)'}),
    );
    await dioDownload.download(
      url,
      targetPath,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Fetch CrossWire modules from the main repository
  Future<List<CrosswireModule>> fetchCrosswireModules() async {
    try {
      final response = await _dio.get('https://crosswire.org/ftpmirror/pub/sword/masterRepoList.conf');
      final lines = response.data.toString().split('\n');
      
      String repoDomain = 'crosswire.org';
      String repoPath = '/ftpmirror/pub/sword/raw';

      // Parse the primary CrossWire repo
      for (final line in lines) {
        if (line.contains('HTTPSPackagePreference=CrossWire|')) {
          final parts = line.split('=')[2].split('|');
          if (parts.length >= 3) {
            repoDomain = parts[1];
            repoPath = parts[2];
            break;
          }
        }
      }

      final modsUrl = 'https://$repoDomain$repoPath/mods.d.tar.gz';
      final modsResponse = await _dio.get(
        modsUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final bytes = modsResponse.data as List<int>;
      final archive = TarDecoder().decodeBytes(GZipDecoder().decodeBytes(bytes));

      final List<CrosswireModule> modules = [];

      for (final file in archive) {
        if (file.isFile && file.name.toLowerCase().endsWith('.conf')) {
          final content = utf8.decode(file.content as List<int>, allowMalformed: true);
          final config = SwordConfig.parse(content);

          // Skip if locked
          if (config.value('CipherKey') != null) {
            continue;
          }

          modules.add(CrosswireModule(
            config: config,
            repoDomain: repoDomain,
            repoPath: repoPath,
          ));
        }
      }

      modules.sort((a, b) => a.config.name.compareTo(b.config.name));
      return modules;
    } catch (e, stack) {
      logError(e, stack, context: 'ContentManagerApi.fetchCrosswireModules');
      rethrow;
    }
  }
}
