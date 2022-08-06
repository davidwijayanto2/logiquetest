import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class Shimmer extends StatelessWidget {
  final double width;
  final double height;
  final SkeletonStyle skeletonStyle;
  final Color color;
  final double radius;
  const Shimmer({
    required this.width,
    this.height = 12,
    this.skeletonStyle = SkeletonStyle.text,
    this.color = Colors.grey,
    this.radius = 4,
  });
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      style: skeletonStyle,
      textColor: color,
      borderRadius: BorderRadius.circular(radius),
      height: height,
      width: width,
    );
  }
}
