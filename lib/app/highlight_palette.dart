/// The canonical highlight colours the reader offers.
///
/// Single source of truth for everything that needs the palette — the verse
/// action bar swatches, the highlights panel filter, and the "Full Palette"
/// achievement that rewards using them all. Adding or removing a colour here
/// updates all of them, including the achievement threshold, so the reward can
/// never drift out of reach of the colours actually on offer.
const highlightPalette = <({String hex, String name})>[
  (hex: '#FBE083', name: 'Yellow'),
  (hex: '#98E2C6', name: 'Green'),
  (hex: '#B5E2FA', name: 'Blue'),
  (hex: '#F4A8C4', name: 'Pink'),
];

/// Normalises a stored `colorHex` for comparison: upper-case, no leading `#`
/// and no surrounding whitespace, so palette membership survives any legacy or
/// cross-device formatting differences.
String normalizeHighlightHex(String hex) =>
    hex.replaceAll('#', '').trim().toUpperCase();
