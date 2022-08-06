import 'package:flutter/material.dart';
import 'package:logique_techtest/components/rounded_container.dart';
import 'package:logique_techtest/components/shimmer.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class ShimmerUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      border: true,
      borderWidth: 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Flexible(
            child: Shimmer(
              skeletonStyle: SkeletonStyle.box,
              radius: 10,
              width: 125,
              height: 125,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Shimmer(width: 70),
        ],
      ),
    );
  }
}
