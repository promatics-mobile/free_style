import 'package:flutter/material.dart';

import '../../common_constants.dart';


/// A reusable image widget that supports:
/// - Network and asset images
/// - Placeholder & error handling
/// - Shape (circle, rounded, rectangle)
/// - Border & borderRadius
/// - Tap callback
/// - Custom BoxFit
class CommonImage extends StatelessWidget {
  final String imagePath;
  final bool isNetwork;

  final double? width;
  final double? height;
  final BoxFit fit;

  final double borderRadius;
  final BoxShape shape;

  final Color? backgroundColor;
  final BoxBorder? border;

  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? color;

  final VoidCallback? onTap;

  const CommonImage({
    super.key,
    required this.imagePath,
    this.isNetwork = true,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.shape = BoxShape.rectangle,
    this.backgroundColor,
    this.border,
    this.placeholder,
    this.errorWidget,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (isNetwork) {
      debugPrint("Path: $imagePath");
      imageWidget = Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        color: color,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ??
              Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
        },errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Center(
              child: Icon(
                Icons.account_circle_rounded,
                color: CommonColors.secondaryLightColor,
                size: (width != null && width!.isFinite) ? width :  size(context).width*numD06,
              ),
            );
      },

      );
    } else {
      imageWidget = Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Center(
                child: Icon(Icons.image_not_supported, size: width ?? size(context).width*numD1),
              );
        },
      );
    }

    // Shape & decoration
    Widget decorated = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? BorderRadius.circular(borderRadius)
            : null,
        border: border,
      ),
      clipBehavior: Clip.hardEdge,
      child: ClipRRect(
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: imageWidget),
    );

    if (onTap != null) {
      decorated = GestureDetector(onTap: onTap, child: decorated);
    }

    return decorated;
  }
}
