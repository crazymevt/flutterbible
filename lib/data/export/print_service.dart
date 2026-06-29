import 'dart:typed_data';
import 'package:printing/printing.dart';

/// Sends already-rendered PDF [bytes] to the platform's print/preview sheet.
///
/// This is the single cross-platform print entry point reused by every
/// printable content type (sermons, notes/journals, the reader). The
/// `printing` package abstracts the platform difference: AirPrint on iOS, the
/// Android print framework, the native print dialog on macOS/Windows/Linux,
/// and the browser print sheet on web. So "print" is the same code everywhere —
/// only the UI affordance that triggers it differs per screen.
class PrintService {
  /// Opens the system print sheet for [bytes]. [documentName] becomes the
  /// suggested job / file name (no extension). Completes when the sheet is
  /// dismissed — callers don't need to know whether the user actually printed.
  static Future<void> printPdf(Uint8List bytes, {String documentName = 'StudyBible'}) {
    return Printing.layoutPdf(
      onLayout: (format) async => bytes,
      name: documentName,
    );
  }
}
