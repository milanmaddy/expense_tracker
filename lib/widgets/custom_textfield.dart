import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teen_tigada/utils/color_const.dart';

// TextStyle _defaultTextStyle(bool isDarkMode) => GoogleFonts.outfit(
//   color: isDarkMode ? AppColors.textDarkSecondary : AppColors.textSecondary,
//   fontWeight: FontWeight.w500,
//   fontSize: 16,
//   height: 1.4,
// );
//
// TextStyle _defaultLabelStyle(bool isDarkMode) => GoogleFonts.outfit(
//   color: isDarkMode
//       ? AppColors.greyDarkText.withOpacity(0.75)
//       : AppColors.greyText.withOpacity(0.75),
//   fontWeight: FontWeight.w600,
//   fontSize: 14,
// );
//
// TextStyle _floatingLabelStyle(bool isDarkMode) => GoogleFonts.outfit(
//   color: isDarkMode ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
//   fontWeight: FontWeight.w600,
//   fontSize: 12,
// );
//
// // Rounded border without border line
// OutlineInputBorder _outlineBorder(Color color, {double width = 0}) =>
//     OutlineInputBorder(
//       borderRadius: BorderRadius.circular(16),
//       borderSide: BorderSide(color: color, width: width),
//     );
//
// class CustomTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final TextStyle? textStyle;
//   final String? labelText;
//   final String? hintText;
//   final TextStyle? hintStyle;
//   final String? prefixSvgAsset;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final FormFieldValidator<String>? validator;
//   final bool readOnly;
//   final bool filled;
//   final Color? fillColor;  // NEW: Custom fill color
//   final ValueChanged<String>? onChanged;
//   final ValueChanged<String>? onFieldSubmitted;
//   final InputBorder? border;
//   final InputBorder? disabledBorder;
//   final InputBorder? errorBorder;
//   final Color? errorColor;
//   final FocusNode? focusNode;
//   final TextInputAction? textInputAction;
//   final int? maxLength;
//   final int? maxLines;
//   final Widget? suffixIcon;
//
//   const CustomTextField({
//     super.key,
//     required this.controller,
//     this.textStyle,
//     this.labelText,
//     this.hintText,
//     this.hintStyle,
//     this.prefixSvgAsset,
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//     this.validator,
//     this.readOnly = false,
//     this.filled = true,
//     this.fillColor,  // NEW
//     this.onChanged,
//     this.onFieldSubmitted,
//     this.border,
//     this.disabledBorder,
//     this.errorBorder,
//     this.errorColor,
//     this.focusNode,
//     this.textInputAction,
//     this.maxLength,
//     this.maxLines = 1,
//     this.suffixIcon,
//   });
//
//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   late FocusNode _focusNode;
//   bool _isFocused = false;
//   bool _obscureText = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _obscureText = widget.obscureText;
//     _focusNode = widget.focusNode ?? FocusNode();
//     _focusNode.addListener(_onFocusChange);
//   }
//
//   @override
//   void dispose() {
//     if (widget.focusNode == null) {
//       _focusNode.dispose();
//     }
//     super.dispose();
//   }
//
//   void _onFocusChange() {
//     setState(() {
//       _isFocused = _focusNode.hasFocus;
//     });
//   }
//
//   void _toggleObscureText() {
//     setState(() => _obscureText = !_obscureText);
//   }
//
//   InputDecoration _buildDecoration(BuildContext context, bool isDarkMode) {
//     final defaultFillColor = isDarkMode
//         ? AppColors.blackBackground.withOpacity(0.3)
//         : AppColors.backgroundFill;
//     final baseFillColor = widget.fillColor ?? defaultFillColor;  // Use custom or default
//
//     final primaryBorderColor =
//     isDarkMode ? AppColors.blueDarkPrimary : AppColors.bluePrimary;
//     final errorBorderColor =
//     isDarkMode ? AppColors.redDarkError : AppColors.redError;
//
//     return InputDecoration(
//       filled: widget.filled,
//       fillColor: widget.filled ? baseFillColor : null,
//       labelText: widget.labelText,
//       labelStyle: _defaultLabelStyle(isDarkMode),
//       floatingLabelStyle: _floatingLabelStyle(isDarkMode),
//       hintText: widget.hintText,
//       hintStyle: widget.hintStyle ??
//           GoogleFonts.outfit(
//             fontSize: 15,
//             fontWeight: FontWeight.w400,
//             color: isDarkMode
//                 ? Colors.white.withOpacity(0.4)
//                 : Colors.grey.shade500,
//           ),
//       contentPadding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 16,
//       ),
//       prefixIcon: widget.prefixSvgAsset != null &&
//           widget.prefixSvgAsset!.isNotEmpty
//           ? Padding(
//         padding: const EdgeInsets.only(left: 16, right: 12),
//         child: SvgPicture.asset(
//           widget.prefixSvgAsset!,
//           width: 20,
//           height: 20,
//           colorFilter: ColorFilter.mode(
//             _isFocused
//                 ? primaryBorderColor
//                 : (isDarkMode
//                 ? AppColors.greyDarkText
//                 : AppColors.greyText),
//             BlendMode.srcIn,
//           ),
//         ),
//       )
//           : null,
//       prefixIconConstraints: const BoxConstraints(minWidth: 48),
//       // suffixIcon: widget.suffixIcon,
//       suffixIcon: widget.obscureText
//           ? IconButton(
//         icon: Icon(
//           _obscureText
//               ? Icons.visibility_off_outlined
//               : Icons.visibility_outlined,
//           color: isDarkMode
//               ? Colors.white.withOpacity(0.4)
//               : Colors.grey.shade500,
//           size: 20,
//         ),
//         onPressed: _toggleObscureText,
//       )
//           : widget.suffixIcon,
//       suffixIconConstraints: const BoxConstraints(minWidth: 48),
//       border: widget.border ?? _outlineBorder(Colors.transparent),
//       enabledBorder: _outlineBorder(Colors.transparent),
//       focusedBorder: _outlineBorder(primaryBorderColor, width: 2),
//       errorBorder: widget.errorBorder ?? _outlineBorder(errorBorderColor, width: 2),
//       focusedErrorBorder:
//       widget.errorBorder ?? _outlineBorder(errorBorderColor, width: 2),
//       disabledBorder: widget.disabledBorder ?? _outlineBorder(Colors.transparent),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return TextFormField(
//       controller: widget.controller,
//       obscureText: widget.obscureText,
//       keyboardType: widget.keyboardType,
//       validator: widget.validator,
//       readOnly: widget.readOnly,
//       onChanged: widget.onChanged,
//       onFieldSubmitted: widget.onFieldSubmitted,
//       maxLength: widget.maxLength,
//       focusNode: _focusNode,
//       maxLines: widget.maxLines,
//       textInputAction: widget.textInputAction,
//       style: widget.textStyle ?? _defaultTextStyle(isDarkMode),
//       decoration: _buildDecoration(context, isDarkMode),
//       cursorColor:
//       isDarkMode ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
//     );
//   }
// }
//
// class CustomPasswordField extends StatefulWidget {
//   final TextEditingController controller;
//   final String? labelText;
//   final String? hintText;
//   final String? prefixSvgAsset;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onChanged;
//   final ValueChanged<String>? onFieldSubmitted;
//   final bool readOnly;
//   final bool filled;
//   final Color? fillColor;  // NEW: Custom fill color
//   final InputBorder? border;
//   final InputBorder? disabledBorder;
//   final InputBorder? errorBorder;
//   final Color? errorColor;
//   final FocusNode? focusNode;
//   final TextInputAction? textInputAction;
//   final int? maxLength;
//   final TextInputType keyboardType;
//
//   const CustomPasswordField({
//     super.key,
//     required this.controller,
//     this.labelText,
//     this.hintText,
//     this.prefixSvgAsset,
//     this.validator,
//     this.onChanged,
//     this.onFieldSubmitted,
//     this.readOnly = false,
//     this.filled = true,
//     this.fillColor,  // NEW
//     this.border,
//     this.disabledBorder,
//     this.errorBorder,
//     this.errorColor,
//     this.focusNode,
//     this.textInputAction,
//     this.maxLength,
//     this.keyboardType = TextInputType.visiblePassword,
//   });
//
//   @override
//   State<CustomPasswordField> createState() => _CustomPasswordFieldState();
// }
//
// class _CustomPasswordFieldState extends State<CustomPasswordField> {
//   late bool _hidden;
//   late FocusNode _focusNode;
//   bool _isFocused = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _hidden = true;
//     _focusNode = widget.focusNode ?? FocusNode();
//     _focusNode.addListener(_onFocusChange);
//   }
//
//   @override
//   void dispose() {
//     if (widget.focusNode == null) {
//       _focusNode.dispose();
//     }
//     super.dispose();
//   }
//
//   void _onFocusChange() {
//     setState(() {
//       _isFocused = _focusNode.hasFocus;
//     });
//   }
//
//   void _toggle() {
//     setState(() {
//       _hidden = !_hidden;
//     });
//   }
//
//   InputDecoration _buildDecoration(BuildContext context, bool isDarkMode) {
//     final defaultFillColor = isDarkMode
//         ? AppColors.darkSurface.withOpacity(0.8)
//         : Colors.white;
//     final baseFillColor = widget.fillColor ?? defaultFillColor;  // Use custom or default
//
//     final primaryBorderColor =
//     isDarkMode ? AppColors.blueDarkPrimary : AppColors.bluePrimary;
//     final errorBorderColor =
//     isDarkMode ? AppColors.redDarkError : AppColors.redError;
//
//     return InputDecoration(
//       filled: widget.filled,
//       fillColor: widget.filled ? baseFillColor : null,
//       labelText: widget.labelText,
//       labelStyle: _defaultLabelStyle(isDarkMode),
//       floatingLabelStyle: _floatingLabelStyle(isDarkMode),
//       hintText: widget.hintText,
//       hintStyle: GoogleFonts.outfit(
//         fontSize: 15,
//         fontWeight: FontWeight.w400,
//         color: isDarkMode
//             ? Colors.white.withOpacity(0.4)
//             : Colors.grey.shade500,
//       ),
//       contentPadding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 16,
//       ),
//       prefixIcon: widget.prefixSvgAsset != null &&
//           widget.prefixSvgAsset!.isNotEmpty
//           ? Padding(
//         padding: const EdgeInsets.only(left: 16, right: 12),
//         child: SvgPicture.asset(
//           widget.prefixSvgAsset!,
//           width: 20,
//           height: 20,
//           colorFilter: ColorFilter.mode(
//             _isFocused
//                 ? primaryBorderColor
//                 : (isDarkMode
//                 ? AppColors.greyDarkText
//                 : AppColors.greyText),
//             BlendMode.srcIn,
//           ),
//         ),
//       )
//           : null,
//       prefixIconConstraints: const BoxConstraints(minWidth: 48),
//       suffixIcon: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: _toggle,
//           borderRadius: BorderRadius.circular(24),
//           splashColor: primaryBorderColor.withOpacity(0.2),
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Icon(
//               _hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//               size: 22,
//               color: _isFocused
//                   ? primaryBorderColor
//                   : (isDarkMode
//                   ? AppColors.greyDarkText
//                   : AppColors.greyText),
//             ),
//           ),
//         ),
//       ),
//       suffixIconConstraints: const BoxConstraints(minWidth: 48),
//       border: widget.border ?? _outlineBorder(Colors.transparent),
//       enabledBorder: _outlineBorder(Colors.transparent),
//       focusedBorder: _outlineBorder(primaryBorderColor, width: 2),
//       errorBorder: widget.errorBorder ?? _outlineBorder(errorBorderColor, width: 2),
//       focusedErrorBorder:
//       widget.errorBorder ?? _outlineBorder(errorBorderColor, width: 2),
//       disabledBorder: widget.disabledBorder ?? _outlineBorder(Colors.transparent),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return TextFormField(
//       controller: widget.controller,
//       obscureText: _hidden,
//       keyboardType: widget.keyboardType,
//       validator: widget.validator,
//       readOnly: widget.readOnly,
//       onChanged: widget.onChanged,
//       onFieldSubmitted: widget.onFieldSubmitted,
//       maxLength: widget.maxLength,
//       focusNode: _focusNode,
//       textInputAction: widget.textInputAction,
//       style: _defaultTextStyle(isDarkMode),
//       decoration: _buildDecoration(context, isDarkMode),
//       cursorColor:
//       isDarkMode ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
//     );
//   }
// }

import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  // ────── Existing properties (unchanged) ──────
  final String hintText;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final String? errorText;
  final String? helperText;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool autofocus;
  final bool showCursor;
  final TextAlign textAlign;
  final BoxConstraints? iconConstraints; // optional icon size control

  const CustomTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.labelStyle,
    this.floatingLabelStyle,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.errorText,
    this.helperText,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.contentPadding,
    this.borderRadius = 10,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.textStyle,
    this.hintStyle,
    this.autofocus = false,
    this.showCursor = true,
    this.textAlign = TextAlign.start,
    this.iconConstraints,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    widget.focusNode?.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.focusNode?.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    if (widget.focusNode?.hasFocus ?? false) {
      _animationController.forward();
      setState(() => _isFocused = true);
    } else {
      _animationController.reverse();
      setState(() => _isFocused = false);
    }
  }

  void _toggleObscureText() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    // ────── Theme detection ──────
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ────── Colours from your palette ──────
    final primaryColor = isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary;
    final textColor = isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;
    final hintColor = isDark ? AppColors.greyDarkText : AppColors.greyText;
    final errorColor = isDark ? AppColors.redDarkError : AppColors.redError;

    // Fill colour – use the passed value or a subtle tint of the primary
    final fill = widget.fillColor ??
        primaryColor.withOpacity(isDark ? 0.1 : 0.06);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: TextFormField(
            controller: widget.controller,
            textAlign: widget.textAlign,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            onTap: widget.onTap,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            obscureText: _obscureText,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autofocus,
            showCursor: widget.showCursor,

            // ────── Text style (Outfit) ──────
            style: widget.textStyle ??
                GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),

            decoration: InputDecoration(
              // ────── Label & floating label ──────
              labelText: widget.labelText,
              labelStyle: widget.labelStyle ??
                  GoogleFonts.outfit(
                    fontSize: 15,
                    color: hintColor,
                    fontWeight: FontWeight.w500,
                  ),
              floatingLabelStyle: widget.floatingLabelStyle ??
                  GoogleFonts.outfit(
                    fontSize: 15,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),

              // ────── Hint ──────
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  GoogleFonts.outfit(
                    fontSize: 15,
                    color: hintColor,
                    fontWeight: FontWeight.w500,
                  ),

              // ────── Icons ──────
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: widget.iconConstraints,
              suffixIcon: widget.obscureText
                  ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: hintColor,
                  size: 20,
                ),
                onPressed: _toggleObscureText,
              )
                  : widget.suffixIcon,
              suffixIconConstraints: widget.iconConstraints,

              // ────── Misc ──────
              prefixText: widget.prefixText,
              suffixText: widget.suffixText,
              errorText: widget.errorText,
              helperText: widget.helperText,
              filled: true,
              fillColor: fill,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

              // ────── Borders ──────
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.transparent,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? primaryColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? errorColor,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? errorColor,
                  width: 2,
                ),
              ),
              disabledBorder: InputBorder.none,

              // ────── Error / Helper styles (Outfit) ──────
              errorStyle: GoogleFonts.outfit(
                fontSize: 12,
                color: errorColor,
                fontWeight: FontWeight.w500,
              ),
              helperStyle: GoogleFonts.outfit(
                fontSize: 12,
                color: hintColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}