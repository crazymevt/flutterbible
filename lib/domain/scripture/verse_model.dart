class VerseModel {
  final int bookId;
  final int chapter;
  final int verse;
  final List<VerseSegment> segments;

  const VerseModel({
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.segments,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    return VerseModel(
      bookId: json['bookId'] as int,
      chapter: json['chapter'] as int,
      verse: json['verse'] as int,
      segments: (json['segments'] as List)
          .map((s) => VerseSegment.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'bookId': bookId,
    'chapter': chapter,
    'verse': verse,
    'segments': segments.map((s) => s.toJson()).toList(),
  };
}

class VerseSegment {
  final String text;
  final String? strongs;
  final List<String> attrs; // e.g. "jesus_words", "italics"

  const VerseSegment({required this.text, this.strongs, this.attrs = const []});

  factory VerseSegment.fromJson(Map<String, dynamic> json) {
    return VerseSegment(
      text: json['text'] as String,
      strongs: json['strongs'] as String?,
      attrs: (json['attrs'] as List?)?.map((e) => e as String).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    if (strongs != null) 'strongs': strongs,
    if (attrs.isNotEmpty) 'attrs': attrs,
  };
}
