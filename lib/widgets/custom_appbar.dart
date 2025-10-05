import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:teen_tigada/utils/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool useGradient;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackPressed,
    this.actions,
    this.showBackButton = true,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return Container(
        decoration: useGradient
            ? BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: isDark
                ? [AppColors.blackBackground, AppColors.blueDarkPrimary]
                : [AppColors.royalBlue, AppColors.bluePrimary],
          ),
        )
            : null,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                if (showBackButton)
                  Material(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: onBackPressed ?? () => Get.back(),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                if (showBackButton) const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutfitText(
                        text: title,
                        fontSize: isSmall ? 22 : 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        OutfitText(
                          text: subtitle!,
                          fontSize: isSmall ? 13 : 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ],
                    ],
                  ),
                ),
                if (actions != null) ...actions!,
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(subtitle != null ? 100 : 80);
}