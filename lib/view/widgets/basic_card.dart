import 'package:flutter/material.dart';
import 'package:app_mobile/view/theme/app_theme.dart';

class BasicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double borderRadius;
  final List<BoxShadow>? shadow;
  final double? maxHeight;
  final double? maxWidth;
  final double? height;
  final double? width;

  const BasicCard({
    Key? key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius = AppBorderRadius.medium,
    this.shadow,
    this.maxHeight,
    this.maxWidth,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? double.infinity,
        maxWidth: maxWidth ?? double.infinity,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadow ?? AppShadow.card,
      ),
      child: Padding(
        padding: padding ?? AppSpacing.all(context, 18),
        child: child,
      ),
    );
  }
}