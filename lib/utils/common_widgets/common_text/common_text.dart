import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A fully-customisable text widget that supports:
/// - plain text or TextSpan (rich)
/// - gradients
/// - stroke/outline
/// - shadows
/// - selectable or non-selectable
/// - onTap callback
/// - many TextStyle parameters exposed
class CommonText extends StatelessWidget {
  // Basic text
  final String? text;

  // Rich text (if provided, this takes precedence over plain text)
  final TextSpan? textSpan;

  // Interaction
  final VoidCallback? onTap;
  final bool selectable;
  final TextSelectionControls? selectionControls;
  final bool enableMouseCursor;
  final MouseCursor? mouseCursor;


  // Styling
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextDecoration? decoration;
  final double? height; // lineHeight factor

  // Layout
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool softWrap;

  // Effects
  final List<Shadow>? shadows;

  // Gradient text (if provided, overrides solid color for painting)
  final Gradient? gradient;

  // Stroke (outline) effect
  final Color? strokeColor;
  final double strokeWidth;

  // Background & spacing
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;

  // Accessibility & semantics
  final bool excludeFromSemantics;

  // Constructor
  const CommonText({
    super.key,
    this.text,
    this.textSpan,
    this.onTap,
    this.selectable = false,
    this.selectionControls,
    this.enableMouseCursor = true,
    this.mouseCursor,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.fontFamily,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.decoration,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.visible,
    this.softWrap = true,
    this.shadows,
    this.gradient,
    this.strokeColor,
    this.strokeWidth = 0.0,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.excludeFromSemantics = false,
  })  : assert(text != null || textSpan != null,
  'Either text or textSpan must be provided');

  TextStyle _buildTextStyle(BuildContext context) {
    final base = DefaultTextStyle.of(context).style;
    return base.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Colors.white,
      fontFamily: fontFamily,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      decoration: decoration,
      height: height,
      shadows: shadows,
    );
  }

  /// If strokeColor is provided with strokeWidth > 0, build a Paint for stroke.
  Paint? _buildStrokePaint() {
    if (strokeColor != null && strokeWidth > 0) {
      return Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = strokeColor!;
    }
    return null;
  }

  Widget _buildPlainText(BuildContext context) {
    final textStyle = _buildTextStyle(context);

    if (gradient != null) {
      final content = Text(
        text!,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        style: textStyle.copyWith(
          color: Colors.white,
          foreground: _buildStrokePaint(),
        ),
      );

      // If stroke exists, we want stroke + gradient fill. We'll stack stroke (painted)
      // and gradient-filled text above it.
      if (_buildStrokePaint() != null) {
        // Stroke using foreground Paint style is already applied in textStyle above.
        // But to ensure gradient fill appears above stroke, we draw gradient Text above.
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            // stroke text: use same text but with foreground paint set to stroke
            Text(
              text!,
              textAlign: textAlign,

              maxLines: maxLines,
              overflow: overflow,
              softWrap: softWrap,

              style: textStyle.copyWith(
                color: Colors.transparent,
                foreground: _buildStrokePaint(),
              ),
            ),
            // gradient text
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (rect) => gradient!.createShader(
                Rect.fromLTWH(0, 0, rect.width, rect.height),
              ),
              child: Text(
                text!,
                textAlign: textAlign,
                maxLines: maxLines,
                overflow: overflow,
                softWrap: softWrap,
                style: textStyle.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      }

      // No stroke — simple gradient text
      return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (rect) => gradient!.createShader(
          Rect.fromLTWH(0, 0, rect.width, rect.height),
        ),
        child: Text(
          text!,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
          style: textStyle.copyWith(color: Colors.white),
        ),
      );
    }

    // No gradient: handle stroke (outline) with stack + foreground paint
    if (_buildStrokePaint() != null) {
      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          // stroke
          Text(
            text!,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,

            softWrap: softWrap,
            style: textStyle.copyWith(
              fontFamily: "Poppins",
              color: Colors.transparent,
              foreground: _buildStrokePaint(),
            ),
          ),
          // fill
          Text(
            text!,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
            style: textStyle,
          ),
        ],
      );
    }

    // Simple text (no gradient, no stroke)
    return Text(
      text!,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: textStyle,
    );
  }

  Widget _buildRichText(BuildContext context) {
    final base = _buildTextStyle(context);
    // Merge base style into span if it doesn't define them
    final mergedSpan = _mergeBaseIntoTextSpan(textSpan!, base);

    if (gradient != null) {
      return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (rect) => gradient!.createShader(
          Rect.fromLTWH(0, 0, rect.width, rect.height),
        ),
        child: RichText(
          text: mergedSpan,
          textAlign: textAlign ?? TextAlign.start,
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
        ),
      );
    }

    return RichText(
      text: mergedSpan,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  TextSpan _mergeBaseIntoTextSpan(TextSpan span, TextStyle baseStyle) {
    final mergedStyle = baseStyle.merge(span.style);
    // recursively merge for children
    return TextSpan(
      text: span.text,
      style: mergedStyle,
      recognizer: span.recognizer,
      children: span.children
          ?.map((child) => child is TextSpan ? _mergeBaseIntoTextSpan(child, baseStyle) : child)
          .toList(),
    );
  }

  Widget _wrapInteraction(Widget child) {
    Widget w = child;

    if (onTap != null) {
      w = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: w,
      );
    }

    if (enableMouseCursor) {
      final cursor = mouseCursor ?? SystemMouseCursors.click;
      w = MouseRegion(cursor: onTap != null ? cursor : SystemMouseCursors.basic, child: w);
    }

    if (selectable) {
      // For selectable text we need SelectableText.rich for rich or SelectableText for plain
      if (textSpan != null) {
        return SelectableText.rich(
          textSpan!,
          textAlign: textAlign ?? TextAlign.start,
          maxLines: maxLines,
          showCursor: false,
          toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
          selectionControls: selectionControls,
        );
      } else {
        return SelectableText(
          text ?? '',
          textAlign: textAlign ?? TextAlign.start,
          maxLines: maxLines,
          toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
          selectionControls: selectionControls,
        );
      }
    }

    return w;
  }

  @override
  Widget build(BuildContext context) {
    final content = textSpan != null ? _buildRichText(context) : _buildPlainText(context);

    final decorated = Container(
      margin: margin,
      padding: padding,
      color: backgroundColor,
      child: content,
    );

    // Wrap interaction if any (tap/selectable)
    final interacted = _wrapInteraction(decorated);

    if (excludeFromSemantics) {
      return ExcludeSemantics(child: interacted);
    }

    return interacted;
  }
}
