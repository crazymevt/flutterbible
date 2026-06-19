class VerseSegment {
  final String text;
  final bool isItalic;
  final bool isJesusWords;
  final bool isParagraphBreak;
  final bool isLineBreak;
  final String? strongs;

  const VerseSegment({
    this.text = '',
    this.isItalic = false,
    this.isJesusWords = false,
    this.isParagraphBreak = false,
    this.isLineBreak = false,
    this.strongs,
  });

  Map<String, dynamic> toJson() {
    return {
      if (text.isNotEmpty) 'text': text,
      if (isItalic) 'i': isItalic,
      if (isJesusWords) 'j': isJesusWords,
      if (isParagraphBreak) 'pb': isParagraphBreak,
      if (isLineBreak) 'br': isLineBreak,
      if (strongs != null) 's': strongs,
    };
  }

  factory VerseSegment.fromJson(Map<String, dynamic> json) {
    return VerseSegment(
      text: json['text'] as String? ?? '',
      isItalic: json['i'] as bool? ?? false,
      isJesusWords: json['j'] as bool? ?? false,
      isParagraphBreak: json['pb'] as bool? ?? false,
      isLineBreak: json['br'] as bool? ?? false,
      strongs: json['s'] as String?,
    );
  }
}
