class AudioBible {
  final String name;
  final Map<String, Map<String, Map<String, String>>> urlMappings;
  // urlMappings format: Book -> Chapter -> VoiceActor -> URL

  AudioBible({required this.name, required this.urlMappings});

  factory AudioBible.fromJson(String name, Map<String, dynamic> json) {
    final Map<String, Map<String, Map<String, String>>> mappings = {};
    
    // The JSON is like: { "Berean Standard Bible": { "Jude": { "1": { "gilbert": "url", ... } } } }
    // Or just { "Jude": { "1": { "gilbert": "url" } } } depending on how it was converted
    
    // bsb.json structure starts with {"Berean Standard Bible": ... }
    // Let's extract the nested map
    Map<String, dynamic> rootMap = json;
    if (json.keys.length == 1) {
      rootMap = json[json.keys.first] as Map<String, dynamic>;
    }

    rootMap.forEach((bookName, chapterMap) {
      if (chapterMap is Map) {
        mappings[bookName] = {};
        chapterMap.forEach((chapter, voiceMap) {
          if (voiceMap is Map) {
            mappings[bookName]![chapter.toString()] = {};
            voiceMap.forEach((voice, url) {
              mappings[bookName]![chapter.toString()]![voice.toString()] = url.toString();
            });
          }
        });
      }
    });

    return AudioBible(name: name, urlMappings: mappings);
  }

  /// Returns a map of voice actor -> url for a given book and chapter.
  Map<String, String>? getAudioForChapter(String book, int chapter) {
    return urlMappings[book]?[chapter.toString()];
  }
}
