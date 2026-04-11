import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double borderRadius;
  final BoxShadow? shadow;
  final int maxHeight;
  final int maxWidth;
  final int height;
  final int width;

  const BasicCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor = Colors.white,
    this.borderRadius = 12.0,
    this.shadow, 
    this.maxHeight = 300,
    this.maxWidth = 400,
    this.height = 200,
    this.width = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.toDouble(),
      width: width.toDouble(),
      constraints: BoxConstraints(
          maxHeight: maxHeight.toDouble(),
          maxWidth: maxWidth.toDouble(),
        ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadow != null ? [shadow!] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}