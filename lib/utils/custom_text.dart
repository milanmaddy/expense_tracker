import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutfitText extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? backgroundColor;
  final int? maxLines;
  final double? fontSize, height, wordSpacing, letterSpacing;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;
  final List<Shadow>? shadows;
  const OutfitText({
    super.key,
    required this.text,
    this.color,
    this.backgroundColor,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.textAlign,
    this.wordSpacing,
    this.letterSpacing,
    this.textOverflow,
    this.textDecoration,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.outfit(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
        decoration: textDecoration,
        backgroundColor: backgroundColor,
        shadows: shadows
      ),
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}