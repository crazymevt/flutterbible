import 'package:flutter/material.dart';

/// Shared colour vocabulary for tags. Tags store a `colorHex` string
/// (`#RRGGBB`); these helpers turn that into legible chip styling that works
/// in both light and dark themes.

/// A named swatch users can pick from. [hex] is the canonical stored form
/// (upper-case `#RRGGBB`).
class TagSwatch {
  final String name;
  final String hex;
  const TagSwatch(this.name, this.hex);

  Color get color => tagColorFromHex(hex)!;
}

/// The fixed palette offered in the picker. Kept small and Material-derived so
/// tints stay readable against `surface` in either brightness.
const List<TagSwatch> kTagPalette = [
  TagSwatch('Red', '#E53935'),
  TagSwatch('Orange', '#FB8C00'),
  TagSwatch('Amber', '#F9A825'),
  TagSwatch('Green', '#43A047'),
  TagSwatch('Teal', '#00897B'),
  TagSwatch('Blue', '#1E88E5'),
  TagSwatch('Indigo', '#3949AB'),
  TagSwatch('Purple', '#8E24AA'),
  TagSwatch('Pink', '#D81B60'),
];

/// Parse a stored `colorHex` (`#RRGGBB` or `RRGGBB`) into a [Color].
/// Returns null for null/empty/malformed values so callers fall back to the
/// neutral chip style.
Color? tagColorFromHex(String? hex) {
  if (hex == null || hex.isEmpty) return null;
  var h = hex.replaceFirst('#', '').trim();
  if (h.length == 6) h = 'FF$h';
  if (h.length != 8) return null;
  final value = int.tryParse(h, radix: 16);
  return value == null ? null : Color(value);
}

/// Normalise a stored `colorHex` to the canonical `#RRGGBB` upper-case form so
/// two spellings of the same colour compare equal (used for filtering).
/// Returns null for null/empty/malformed values.
String? normalizeTagHex(String? hex) {
  if (hex == null) return null;
  final h = hex.replaceAll('#', '').trim().toUpperCase();
  if (h.length != 6 || int.tryParse(h, radix: 16) == null) return null;
  return '#$h';
}

/// A row of tappable colour swatches for assigning a tag's colour, plus a
/// leading "no colour" option. [selectedHex] is highlighted; tapping a swatch
/// calls [onSelected] with its hex, or null for the no-colour option.
class TagSwatchRow extends StatelessWidget {
  final String? selectedHex;
  final ValueChanged<String?> onSelected;

  const TagSwatchRow({
    super.key,
    required this.selectedHex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final selected = normalizeTagHex(selectedHex);

    Widget swatch({
      required Color color,
      required bool isSelected,
      required VoidCallback onTap,
      required String tooltip,
      IconData? icon,
      Color? iconColor,
    }) {
      return Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? scheme.onSurface : scheme.outlineVariant,
                width: isSelected ? 2.5 : 1,
              ),
            ),
            child: icon != null
                ? Icon(icon, size: 18, color: iconColor)
                : (isSelected
                    ? const Icon(Icons.check, size: 18, color: Colors.white)
                    : null),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        swatch(
          color: scheme.surfaceContainerHighest,
          isSelected: selected == null,
          onTap: () => onSelected(null),
          tooltip: 'No colour',
          icon: selected == null ? Icons.check : Icons.block,
          iconColor: scheme.onSurfaceVariant,
        ),
        for (final s in kTagPalette)
          swatch(
            color: s.color,
            isSelected: selected == s.hex,
            onTap: () => onSelected(s.hex),
            tooltip: s.name,
          ),
      ],
    );
  }
}

/// Resolved chip colours for a tag with the given (optional) [colorHex].
class TagChipStyle {
  final Color background;
  final Color foreground;
  final Color border;
  const TagChipStyle({
    required this.background,
    required this.foreground,
    required this.border,
  });
}

/// Chip styling for a tag colour. When [colorHex] is null/invalid, returns the
/// neutral surface style so uncoloured tags look as they did before.
TagChipStyle tagChipStyle(BuildContext context, String? colorHex) {
  final scheme = Theme.of(context).colorScheme;
  final base = tagColorFromHex(colorHex);
  if (base == null) {
    return TagChipStyle(
      background: scheme.surfaceContainerHighest,
      foreground: scheme.onSurface,
      border: Colors.transparent,
    );
  }
  return TagChipStyle(
    background: Color.alphaBlend(base.withValues(alpha: 0.20), scheme.surface),
    foreground: scheme.onSurface,
    border: base.withValues(alpha: 0.6),
  );
}
