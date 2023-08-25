import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// A button that represents a color in a palette.
class ColorPaletteButton extends StatelessWidget {
  /// Function to execute when the button is tapped.
  final Function onTap;

  /// The color of the button.
  final Color color;

  /// Determines if the button is currently selected.
  final bool isSelected;

  /// Creates a color palette button.
  const ColorPaletteButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 10.0),
        width: 40,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.black26),
        ),
        child: isSelected ? const Icon(Iconsax.tick_circle) : Container(),
      ),
      onTap: () => onTap(),
    );
  }
}
