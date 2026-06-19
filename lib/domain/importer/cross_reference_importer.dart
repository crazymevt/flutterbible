import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:study_bible/data/content_store.dart';


class CrossReferenceImporter {
  final ContentStore store;

  CrossReferenceImporter(this.store);

  Future<void> importIfEmpty() async {
    // Check if we already imported cross references
    final countRow = await store.customSelect('SELECT COUNT(*) as c FROM cross_references').getSingle();
    if (countRow.read<int>('c') > 0) {
      return; // Already populated
    }

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/cross_references.sqlite');
    
    // Copy from assets to temp file
    final byteData = await rootBundle.load('assets/cross_references.sqlite');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());

    final db = sqlite.sqlite3.open(tempFile.path);
    final results = db.select('SELECT * FROM cross_references');

    await store.batch((batch) {
      for (final row in results) {
        batch.insert(
          store.crossReferences,
          CrossReferencesCompanion.insert(
            sourceBookName: row['sourceBookName'] as String,
            sourceChapter: row['sourceChapter'] as int,
            sourceVerse: row['sourceVerse'] as int,
            targetBookName: row['targetBookName'] as String,
            targetChapter: row['targetChapter'] as int,
            targetVerse: row['targetVerse'] as int,
          ),
        );
      }
    });

    db.dispose();
    try {
      await tempFile.delete();
    } catch (_) {
      // Ignore if it couldn't be deleted
    }
  }
}
