import 'package:study_bible/data/content_manager_api.dart';

void main() async {
  final api = ContentManagerApi();
  final modules = await api.fetchPh4Modules();
  for (final m in modules) {
    if (m.title.toLowerCase().contains('king james') || m.abbr.toLowerCase() == 'kjv') {
      print('Found: ${m.abbr} | ${m.title}');
    }
  }
}
