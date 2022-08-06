import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color borderColor;
  final border;
  final double borderWidth;
  const RoundedContainer({
    Key? key,
    required this.child,
    this.radius = 8,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.width,
    this.height,
    this.border = false,
    this.borderColor = Colors.grey,
    this.borderWidth = 1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border:
            border ? Border.all(width: borderWidth, color: borderColor) : null,
      ),
      child: child,
    );
  }
}
