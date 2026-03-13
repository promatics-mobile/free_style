import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../generated/assets.dart';
import '../../common_constants.dart';
import '../common_image/common_image.dart';

/// ::::: Common Text FormField :::::
class CommonTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? counterText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final bool? filled;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final AutovalidateMode? autoValidateMode;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enableShadow;

  CommonTextFormField({
    super.key,
    this.label,
    this.hint,
    this.counterText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.textInputAction,
    this.fillColor,
    this.filled,
    this.enableShadow = false,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatter,
    this.autoValidateMode,
    this.onTap,
    this.readOnly = false,
  });

  @override
  State<CommonTextFormField> createState() => _CommonTextFieldState();
}
class _CommonTextFieldState extends State<CommonTextFormField> {
  bool _obscureText = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    debugPrint("Label: ${widget.label} :::: ${widget.isPassword}");

    _obscureText = widget.isPassword;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = _focusNode.hasFocus ? CommonColors.themeColor : Colors.grey;
    final hintColor = _focusNode.hasFocus ? CommonColors.themeColor : Colors.grey;
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      inputFormatters: widget.inputFormatter,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      autovalidateMode: widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
      style: TextStyle(color: CommonColors.themeColor,fontSize: size(context).width * numD04),
      onTapOutside: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
      },

      decoration: InputDecoration(
        hintText: widget.hint,
        counterText: widget.counterText,
        labelStyle: TextStyle(color: hintColor),
        hintStyle: TextStyle(color: Colors.grey,fontSize: size(context).width * numD04),
        filled: widget.filled ?? false,
        fillColor: widget.fillColor ?? Colors.white,
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: BoxConstraints(
          maxWidth: size(context).width*numD13,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: CommonImage(
            imagePath: _obscureText
                ? Assets.iconsIcEyeDisabled
                : Assets.iconsIcEyeEnabled,
            width: size(context).width * numD05,
            color: CommonColors.buttonColor,
            isNetwork: false,
          ),

          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : widget.suffixIcon,
        contentPadding:
        widget.contentPadding ??
            EdgeInsets.symmetric(
              horizontal: size(context).width * numD03,
              vertical: size(context).width * numD02,
            ),
        disabledBorder: widget.borderRadius !=null ? OutlineInputBorder(borderRadius: widget.borderRadius! ): InputBorder.none,
        border: widget.borderRadius !=null ? OutlineInputBorder(borderRadius: widget.borderRadius! ): InputBorder.none,
        enabledBorder: widget.borderRadius !=null ? OutlineInputBorder(borderRadius: widget.borderRadius! ): InputBorder.none,
        focusedBorder: widget.borderRadius !=null ? OutlineInputBorder(borderRadius: widget.borderRadius! ): InputBorder.none,
        errorBorder: widget.borderRadius !=null ? OutlineInputBorder(borderRadius: widget.borderRadius! ): InputBorder.none,
      ),
    );
  }
}