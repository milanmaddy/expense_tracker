// import 'dart:ui';
//
// class AppColors {
//   // Light theme colors
//   static const Color bluePrimary = Color(0xFF28599B);
//   static const Color cyanAccent = Color(0xFF2BCEAF);
//   static const Color textSecondary = Color(0xFF4C4966);
//   static const Color backgroundFill = Color(0xFFF5F5F5);
//   static const Color greyDivider = Color(0xFFA2A0A8);
//   static const Color greyText = Color(0xFF7A778C);
//   static const Color purpleCategory = Color(0xFF8887C9);
//   static const Color greenSuccess = Color(0xFF2E7D32);
//   static const Color redError = Color(0xFFD32F2F);
//   static const Color amberAccent = Color(0xFFFFB300);
//   static const Color deepPink = Color(0xFFE91E63);
//   static const Color royalBlue = Color(0xFF4169E1);
//   static const Color coralVivid = Color(0xFFFF6F61);
//   static const Color limeGreen = Color(0xFF32CD32);
//   static const Color goldenYellow = Color(0xFFFFD700);
//
//   // New bright colors for light theme
//   static const Color brightRed = Color(0xFFFF1744); // Vivid Red
//   static const Color brightOrange = Color(0xFFFF5722); // Vivid Orange
//   static const Color brightYellow = Color(0xFFFFEA00); // Vivid Yellow
//   static const Color brightGreen = Color(0xFF00E676); // Vivid Green
//   static const Color brightBlue = Color(0xFF3D5AFE); // Vivid Blue
//   static const Color brightIndigo = Color(0xFF6200EA); // Vivid Indigo
//   static const Color brightViolet = Color(0xFFD81B60); // Vivid Violet (Pinkish)
//
//   // Dark theme colors
//   static const Color blueDarkPrimary = Color(0xFF5C85D6);
//   static const Color blackBackground = Color(0xFF121212);
//   static const Color darkSurface = Color(0xFF1E1E1E);
//   static const Color textDarkSecondary = Color(0xFFB0BEC5);
//   static const Color greyDarkDivider = Color(0xFF616161);
//   static const Color greyDarkText = Color(0xFF757575);
//   static const Color purpleDarkCategory = Color(0xFFA5B4FC);
//   static const Color greenDarkSuccess = Color(0xFF4CAF50);
//   static const Color redDarkError = Color(0xFFEF5350);
//   static const Color amberDarkAccent = Color(0xFFFFCA28);
//   static const Color deepPinkDark = Color(0xFFF06292);
//   static const Color royalBlueDark = Color(0xFF5C6BC0);
//   static const Color coralDarkVivid = Color(0xFFFF8A80);
//   static const Color limeDarkGreen = Color(0xFF66BB6A);
//   static const Color goldenDarkYellow = Color(0xFFFFE57F);
//
//   // New bright colors for dark theme
//   static const Color brightRedDark = Color(0xFFFF5252); // Vivid Red Dark
//   static const Color brightOrangeDark = Color(0xFFFF8A65); // Vivid Orange Dark
//   static const Color brightYellowDark = Color(0xFFFFF176); // Vivid Yellow Dark
//   static const Color brightGreenDark = Color(0xFF69F0AE); // Vivid Green Dark
//   static const Color brightBlueDark = Color(0xFF536DFE); // Vivid Blue Dark
//   static const Color brightIndigoDark = Color(0xFF7C4DFF); // Vivid Indigo Dark
//   static const Color brightVioletDark = Color(0xFFF06292); // Vivid Violet Dark
// }

import 'dart:ui';

// class AppColors {
//   // Light theme colors
//   static const Color bluePrimary = Color(0xFF28599B);
//   static const Color cyanAccent = Color(0xFF2BCEAF);
//   static const Color textSecondary = Color(0xFF4C4966);
//   static const Color backgroundFill = Color(0xFFF5F5F5);
//   static const Color greyDivider = Color(0xFFA2A0A8);
//   static const Color greyText = Color(0xFF7A778C);
//   static const Color purpleCategory = Color(0xFF8887C9);
//   static const Color greenSuccess = Color(0xFF2E7D32);
//   static const Color redError = Color(0xFFD32F2F);
//   static const Color amberAccent = Color(0xFFFFB300);
//   static const Color deepPink = Color(0xFFE91E63);
//   static const Color royalBlue = Color(0xFF4169E1);
//   static const Color coralVivid = Color(0xFFFF6F61);
//   static const Color limeGreen = Color(0xFF32CD32);
//   static const Color goldenYellow = Color(0xFFFFD700);
//
//   // New bright colors for light theme - UPDATED with deeper shades
//   static const Color brightRed = Color(0xFFFF1744); // Vivid Red
//   static const Color brightOrange = Color(0xFFFF5722); // Vivid Orange
//   static const Color brightYellow = Color(0xFFFF8F00); // Deeper Amber/Orange-Yellow (was 0xFFFFEA00)
//   static const Color brightGreen = Color(0xFF0bda51); // Deeper Forest Green (was 0xFF00E676)
//   static const Color brightBlue = Color(0xFF3D5AFE); // Vivid Blue
//   static const Color brightIndigo = Color(0xFF6200EA); // Vivid Indigo
//   static const Color brightViolet = Color(0xFFD81B60); // Vivid Violet (Pinkish)
//
//   // Dark theme colors
//   static const Color blueDarkPrimary = Color(0xFF5C85D6);
//   static const Color blackBackground = Color(0xFF121212);
//   static const Color darkSurface = Color(0xFF1E1E1E);
//   static const Color textDarkSecondary = Color(0xFFB0BEC5);
//   static const Color greyDarkDivider = Color(0xFF616161);
//   static const Color greyDarkText = Color(0xFF757575);
//   static const Color purpleDarkCategory = Color(0xFFA5B4FC);
//   static const Color greenDarkSuccess = Color(0xFF4CAF50);
//   static const Color redDarkError = Color(0xFFEF5350);
//   static const Color amberDarkAccent = Color(0xFFFFCA28);
//   static const Color deepPinkDark = Color(0xFFF06292);
//   static const Color royalBlueDark = Color(0xFF5C6BC0);
//   static const Color coralDarkVivid = Color(0xFFFF8A80);
//   static const Color limeDarkGreen = Color(0xFF66BB6A);
//   static const Color goldenDarkYellow = Color(0xFFFFE57F);
//
//   // New bright colors for dark theme - UPDATED to complement the light theme changes
//   static const Color brightRedDark = Color(0xFFFF5252); // Vivid Red Dark
//   static const Color brightOrangeDark = Color(0xFFFF8A65); // Vivid Orange Dark
//   static const Color brightYellowDark = Color(0xFFFFB74D); // Softer Orange-Yellow for dark mode
//   static const Color brightGreenDark = Color(0xFF66BB6A); // Softer Green for dark mode
//   static const Color brightBlueDark = Color(0xFF536DFE); // Vivid Blue Dark
//   static const Color brightIndigoDark = Color(0xFF7C4DFF); // Vivid Indigo Dark
//   static const Color brightVioletDark = Color(0xFFF06292); // Vivid Violet Dark
// }

class AppColors {
  // Light theme colors - Updated with Royal Blue primary
  static const Color bluePrimary = Color(0xFF4169E1); // Royal Blue
  static const Color cyanAccent = Color(0xFF2BCEAF);
  static const Color textSecondary = Color(0xFF4C4966);
  static const Color backgroundFill = Color(0xFFF8F9FF); // Slightly blue-tinted background
  static const Color greyDivider = Color(0xFFA2A0A8);
  static const Color greyText = Color(0xFF7A778C);
  static const Color purpleCategory = Color(0xFF8887C9);
  static const Color greenSuccess = Color(0xFF2E7D32);
  static const Color redError = Color(0xFFD32F2F);
  static const Color amberAccent = Color(0xFFFFB300);
  static const Color deepPink = Color(0xFFE91E63);
  static const Color royalBlue = Color(0xFF4169E1);
  static const Color coralVivid = Color(0xFFFF6F61);
  static const Color limeGreen = Color(0xFF32CD32);
  static const Color goldenYellow = Color(0xFFFFD700);
  // New bright colors for light theme
  static const Color brightRed = Color(0xFFFF1744);
  static const Color brightOrange = Color(0xFFFF5722);
  static const Color brightYellow = Color(0xFFFF8F00);
  static const Color brightGreen = Color(0xFF0bda51);
  static const Color brightBlue = Color(0xFF3D5AFE);
  static const Color brightIndigo = Color(0xFF6200EA);
  static const Color brightViolet = Color(0xFFD81B60);
  // More bright colors for light theme
  static const Color brightCyan = Color(0xFF00BCD4);
  static const Color brightTeal = Color(0xFF009688);
  static const Color brightLime = Color(0xFFCDDC39);
  static const Color brightAmber = Color(0xFFFFC107);
  static const Color brightBrown = Color(0xFF795548);
  static const Color brightBlueGrey = Color(0xFF607D8B);
  static const Color brightPink = Color(0xFFFF4081);
  static const Color brightDeepOrange = Color(0xFFFF5722);
  static const Color brightLightGreen = Color(0xFF8BC34A);
  static const Color brightSteel = Color(0xFF4682B4); // Steel blue


  // Dark theme colors - Updated with Royal Blue primary
  static const Color blueDarkPrimary = Color(0xFF6495ED); // Lighter Royal Blue for dark theme
  static const Color blackBackground = Color(0xFF0A0B1E); // Deep blue-black
  static const Color darkSurface = Color(0xFF1A1B2E); // Dark blue surface
  static const Color textDarkSecondary = Color(0xFFE6E8FF); // Light blue-white text
  static const Color greyDarkDivider = Color(0xFF4A4E6B);
  static const Color greyDarkText = Color(0xFF8B90B5);
  static const Color purpleDarkCategory = Color(0xFFA5B4FC);
  static const Color greenDarkSuccess = Color(0xFF4CAF50);
  static const Color redDarkError = Color(0xFFEF5350);
  static const Color amberDarkAccent = Color(0xFFFFCA28);
  static const Color deepPinkDark = Color(0xFFF06292);
  static const Color royalBlueDark = Color(0xFF6495ED);
  static const Color coralDarkVivid = Color(0xFFFF8A80);
  static const Color limeDarkGreen = Color(0xFF66BB6A);
  static const Color goldenDarkYellow = Color(0xFFFFE57F);
  // New bright colors for dark theme
  static const Color brightRedDark = Color(0xFFFF5252);
  static const Color brightOrangeDark = Color(0xFFFF8A65);
  static const Color brightYellowDark = Color(0xFFFFB74D);
  static const Color brightGreenDark = Color(0xFF66BB6A);
  static const Color brightBlueDark = Color(0xFF536DFE);
  static const Color brightIndigoDark = Color(0xFF7C4DFF);
  static const Color brightVioletDark = Color(0xFFF06292);
  // More bright colors for dark theme
  static const Color brightCyanDark = Color(0xFF26C6DA);
  static const Color brightTealDark = Color(0xFF26A69A);
  static const Color brightLimeDark = Color(0xFFD4E157);
  static const Color brightAmberDark = Color(0xFFFFD54F);
  static const Color brightBrownDark = Color(0xFFBCAAA4);
  static const Color brightBlueGreyDark = Color(0xFF90A4AE);
  static const Color brightPinkDark = Color(0xFFF48FB1);
  static const Color brightDeepOrangeDark = Color(0xFFFF8A65);
  static const Color brightLightGreenDark = Color(0xFFAED581);
  static const Color brightSteelDark = Color(0xFF5B9BD5);

  static const List<Map<String, Color>> colorPalette = [
    {'light': AppColors.brightRed, 'dark': AppColors.brightRedDark},
    {'light': AppColors.brightOrange, 'dark': AppColors.brightOrangeDark},
    {'light': AppColors.brightYellow, 'dark': AppColors.brightYellowDark},
    {'light': AppColors.brightGreen, 'dark': AppColors.brightGreenDark},
    {'light': AppColors.brightBlue, 'dark': AppColors.brightBlueDark},
    {'light': AppColors.brightIndigo, 'dark': AppColors.brightIndigoDark},
    {'light': AppColors.brightViolet, 'dark': AppColors.brightVioletDark},
    {'light': AppColors.purpleCategory, 'dark': AppColors.purpleDarkCategory},
    {'light': AppColors.cyanAccent, 'dark': AppColors.limeDarkGreen},
    {'light': AppColors.deepPink, 'dark': AppColors.deepPinkDark},
    {'light': AppColors.brightCyan, 'dark': AppColors.brightCyanDark},
    {'light': AppColors.brightTeal, 'dark': AppColors.brightTealDark},
    {'light': AppColors.brightLime, 'dark': AppColors.brightLimeDark},
    {'light': AppColors.brightAmber, 'dark': AppColors.brightAmberDark},
    {'light': AppColors.brightBrown, 'dark': AppColors.brightBrownDark},
    {'light': AppColors.brightBlueGrey, 'dark': AppColors.brightBlueGreyDark},
    {'light': AppColors.brightPink, 'dark': AppColors.brightPinkDark},
    {'light': AppColors.brightDeepOrange, 'dark': AppColors.brightDeepOrangeDark},
    {'light': AppColors.brightLightGreen, 'dark': AppColors.brightLightGreenDark},
    {'light': AppColors.brightSteel, 'dark': AppColors.brightSteelDark},

  ];

  static Color getRandomColor(bool isDarkTheme, int index) {
    final colorIndex = index % colorPalette.length;
    return isDarkTheme
        ? colorPalette[colorIndex]['dark']!
        : colorPalette[colorIndex]['light']!;
  }
}