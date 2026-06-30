class VerseSegment {
  final String text;
  final bool isItalic;
  final bool isJesusWords;
  final bool isParagraphBreak;
  final bool isLineBreak;
  final String? strongs;
  final bool isFootnote;
  final String? footnoteText;

  /// The marker the source module uses for this footnote (e.g. "1" from a
  /// `<f>[1]</f>` reference). When present the reader shows it as the inline
  /// superscript instead of a generic symbol; null falls back to `*†‡§`.
  final String? footnoteLabel;

  const VerseSegment({
    this.text = '',
    this.isItalic = false,
    this.isJesusWords = false,
    this.isParagraphBreak = false,
    this.isLineBreak = false,
    this.strongs,
    this.isFootnote = false,
    this.footnoteText,
    this.footnoteLabel,
  });

  Map<String, dynamic> toJson() {
    return {
      if (text.isNotEmpty) 'text': text,
      if (isItalic) 'i': isItalic,
      if (isJesusWords) 'j': isJesusWords,
      if (isParagraphBreak) 'pb': isParagraphBreak,
      if (isLineBreak) 'br': isLineBreak,
      if (strongs != null) 's': strongs,
      if (isFootnote) 'f': isFootnote,
      if (footnoteText != null) 'ft': footnoteText,
      if (footnoteLabel != null) 'fl': footnoteLabel,
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
      isFootnote: json['f'] as bool? ?? false,
      footnoteText: json['ft'] as String?,
      footnoteLabel: json['fl'] as String?,
    );
  }
}
