import 'package:flutter/material.dart';
import 'package:app_mobile/view/theme/app_theme.dart';

class AppSpacer extends StatelessWidget {
  final double? width;
  final double? height;

  const AppSpacer({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null ? AppSpacing.scaleWidth(context, width!) : null,
      height: height != null ? AppSpacing.scaleHeight(context, height!) : null,
    );
  }
}
