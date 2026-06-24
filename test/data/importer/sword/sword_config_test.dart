import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/importer/sword/sword_config.dart';

void main() {
  group('SwordConfig.parse', () {
    test('parses the section name and basic key/value pairs', () {
      const conf = '''
[KJV]
DataPath=./modules/texts/ztext/kjv/
ModDrv=zText
SourceType=OSIS
CompressType=ZIP
BlockType=BOOK
Encoding=UTF-8
Lang=en
Versification=KJV
Description=King James Version (1769)
''';
      final c = SwordConfig.parse(conf);

      expect(c.name, 'KJV');
      expect(c.dataPath, './modules/texts/ztext/kjv/');
      expect(c.modDrv, SwordModDrv.zText);
      expect(c.sourceType, SwordSourceType.osis);
      expect(c.compressType, SwordCompressType.zip);
      expect(c.blockType, 'BOOK');
      expect(c.isUtf8, isTrue);
      expect(c.lang, 'en');
      expect(c.versification, 'KJV');
      expect(c.description, 'King James Version (1769)');
    });

    test('ModDrv flags classify the content type', () {
      SwordModDrv drv(String v) =>
          SwordConfig.parse('[M]\nModDrv=$v').modDrv;

      expect(drv('zText').isBible, isTrue);
      expect(drv('RawText').isBible, isTrue);
      expect(drv('zText').isCompressed, isTrue);
      expect(drv('RawText').isCompressed, isFalse);

      expect(drv('zCom').isCommentary, isTrue);
      expect(drv('zLD').isDictionary, isTrue);
      expect(drv('RawLD').isDictionary, isTrue);
      expect(drv('RawLD').isCompressed, isFalse);

      expect(drv('RawGenBook'), SwordModDrv.rawGenBook);
      expect(drv('NoSuchDriver'), SwordModDrv.unknown);
    });

    test('ModDrv parsing is case-insensitive', () {
      expect(SwordConfig.parse('[M]\nModDrv=ZTEXT').modDrv, SwordModDrv.zText);
      expect(SwordConfig.parse('[M]\nModDrv=ztext4').modDrv, SwordModDrv.zText4);
    });

    test('applies SWORD defaults for omitted keys', () {
      final c = SwordConfig.parse('[M]\nModDrv=RawText');
      expect(c.sourceType, SwordSourceType.plaintext);
      expect(c.versification, 'KJV');
      expect(c.encoding, 'Latin-1');
      expect(c.isUtf8, isFalse);
      expect(c.compressType, isNull);
      expect(c.about, isNull);
    });

    test('collects repeated keys in file order', () {
      const conf = '''
[KJV]
ModDrv=zText
GlobalOptionFilter=OSISStrongs
GlobalOptionFilter=OSISMorph
GlobalOptionFilter=OSISFootnotes
''';
      final c = SwordConfig.parse(conf);
      expect(c.globalOptionFilters,
          ['OSISStrongs', 'OSISMorph', 'OSISFootnotes']);
      expect(c.value('GlobalOptionFilter'), 'OSISStrongs');
    });

    test('joins trailing-backslash continuation lines', () {
      const conf = '''
[KJV]
ModDrv=zText
About=\\
This is the King James Version.\\par\\
Public domain.
''';
      final c = SwordConfig.parse(conf);
      expect(c.about, 'This is the King James Version.\\parPublic domain.');
    });

    test('ignores comments and blank lines', () {
      const conf = '''
# leading comment
[KJV]

ModDrv=zText
# inline comment
Lang=en
''';
      final c = SwordConfig.parse(conf);
      expect(c.name, 'KJV');
      expect(c.modDrv, SwordModDrv.zText);
      expect(c.lang, 'en');
    });

    test('handles Windows CRLF line endings', () {
      const conf = '[KJV]\r\nModDrv=zText\r\nLang=en\r\n';
      final c = SwordConfig.parse(conf);
      expect(c.name, 'KJV');
      expect(c.modDrv, SwordModDrv.zText);
      expect(c.lang, 'en');
    });

    test('keeps the value when it contains an = sign', () {
      final c = SwordConfig.parse('[M]\nDistributionLicense=a=b=c');
      expect(c.value('DistributionLicense'), 'a=b=c');
    });
  });

  group('SwordConfig.isFreelyDistributable', () {
    SwordConfig withLicense(String? license) => SwordConfig.parse(
          '[M]\nModDrv=zText'
          '${license == null ? '' : '\nDistributionLicense=$license'}',
        );

    test('recognises licenses that grant redistribution', () {
      const granted = [
        'Public Domain',
        'Creative Commons: BY-SA 4.0',
        'GNU General Public License',
        'GNU Free Documentation License (GFDL)',
        'Copyrighted; Free non-commercial distribution',
        'Copyrighted; Permission to distribute granted to CrossWire',
        'General public license for distribution for any purpose',
      ];
      for (final lic in granted) {
        expect(withLicense(lic).isFreelyDistributable, isTrue, reason: lic);
      }
    });

    test('fails closed for bare/absent/unknown licenses', () {
      expect(withLicense('Copyrighted').isFreelyDistributable, isFalse);
      expect(withLicense('All rights reserved').isFreelyDistributable, isFalse);
      expect(withLicense('').isFreelyDistributable, isFalse);
      expect(withLicense(null).isFreelyDistributable, isFalse);
    });
  });

  group('SwordConfig copyright getters', () {
    test('expose DistributionLicense / Copyright / ShortCopyright', () {
      final c = SwordConfig.parse(
        '[M]\n'
        'DistributionLicense=Public Domain\n'
        'Copyright=Copyright 1769, public domain.\n'
        'ShortCopyright=Public domain.',
      );
      expect(c.distributionLicense, 'Public Domain');
      expect(c.copyright, 'Copyright 1769, public domain.');
      expect(c.shortCopyright, 'Public domain.');
    });

    test('return null when absent', () {
      final c = SwordConfig.parse('[M]\nModDrv=zText');
      expect(c.distributionLicense, isNull);
      expect(c.copyright, isNull);
      expect(c.shortCopyright, isNull);
    });
  });
}
