import 'package:flutter/material.dart';
import 'package:app_mobile/view/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double borderRadius;
  final List<BoxShadow>? shadow;
  final double? height;
  final double? width;
  final double maxWidth;

  const AppCard({
    Key? key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius = AppBorderRadius.medium,
    this.shadow,
    this.height,
    this.width,
    this.maxWidth = 540,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: BoxConstraints(maxWidth: AppSpacing.scaleWidth(context, maxWidth)),
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
