import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/color_const.dart' show AppColors;

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final Widget? leadingIcon;
  final Widget? trailingIcon;  // NEW: Trailing icon option
  final bool isOutlined;
  final bool isLoading;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? fontSize;  // NEW: Quick font size override
  final FontWeight? fontWeight;  // NEW: Quick font weight override

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.leadingIcon,
    this.trailingIcon,  // NEW
    this.isOutlined = false,
    this.isLoading = false,
    this.height = 60,
    this.borderRadius = 16,  // Increased from 12 to match text fields
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.fontSize,  // NEW
    this.fontWeight,  // NEW
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filledBg = widget.backgroundColor ??
        (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary);
    final effectiveBg = widget.isOutlined ? Colors.transparent : filledBg;
    final effectiveFg = widget.textColor ??
        (widget.isOutlined
            ? (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary)
            : Colors.white);

    final effectiveTextStyle = widget.textStyle ??
        GoogleFonts.outfit(
          fontSize: widget.fontSize ?? 18,  // Slightly reduced default from 20
          fontWeight: widget.fontWeight ?? FontWeight.w600,
          color: effectiveFg,
        );

    final bool disabled = widget.isLoading || widget.onTap == null;

    return GestureDetector(
      onTapDown: disabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: disabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: disabled ? null : () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          opacity: disabled ? 0.6 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            height: widget.height,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: widget.isOutlined
                  ? null
                  : LinearGradient(
                colors: disabled
                    ? [filledBg.withOpacity(0.6), filledBg.withOpacity(0.6)]
                    : [filledBg, filledBg.withOpacity(0.85)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: widget.isOutlined
                  ? Border.all(
                color: disabled ? filledBg.withOpacity(0.4) : filledBg,
                width: 2,
              )
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.isLoading ? null : widget.onTap,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                splashColor: effectiveFg.withOpacity(0.2),
                highlightColor: effectiveFg.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: widget.isLoading
                      ? Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
                      ),
                    ),
                  )
                      : Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.leadingIcon != null) ...[
                        IconTheme(
                          data: IconThemeData(
                            color: effectiveFg,
                            size: 22,
                          ),
                          child: widget.leadingIcon!,
                        ),
                        const SizedBox(width: 12),
                      ],
                      Flexible(
                        child: Text(
                          widget.text,
                          style: effectiveTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (widget.trailingIcon != null) ...[
                        const SizedBox(width: 12),
                        IconTheme(
                          data: IconThemeData(
                            color: effectiveFg,
                            size: 22,
                          ),
                          child: widget.trailingIcon!,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// BONUS: Icon Button variant for your app
class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isOutlined;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 48,
    this.backgroundColor,
    this.iconColor,
    this.isOutlined = false,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filledBg = widget.backgroundColor ??
        (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary);
    final effectiveBg = widget.isOutlined ? Colors.transparent : filledBg;
    final effectiveIconColor = widget.iconColor ??
        (widget.isOutlined ? filledBg : Colors.white);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            gradient: widget.isOutlined
                ? null
                : LinearGradient(
              colors: [filledBg, filledBg.withOpacity(0.85)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: widget.isOutlined
                ? Border.all(color: filledBg, width: 2)
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(14),
              splashColor: effectiveIconColor.withOpacity(0.2),
              child: Icon(
                widget.icon,
                color: effectiveIconColor,
                size: widget.size * 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}