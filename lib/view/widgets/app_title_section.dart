import 'package:flutter/material.dart';
import 'package:app_mobile/view/theme/app_theme.dart';
import 'app_spacer.dart';

class AppTitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  const AppTitle({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: AppTypography.heading(context),
    );
  }
}

class AppSection extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;

  const AppSection({
    Key? key,
    required this.children,
    this.spacing = 16,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spacedChildren = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(AppSpacer(height: spacing));
      }
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: spacedChildren,
    );
  }
}
