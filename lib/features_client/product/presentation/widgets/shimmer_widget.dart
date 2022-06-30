import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget.rectangle(
      {Key? key,
      this.shapeBorder = const RoundedRectangleBorder(),
      required this.width,
      required this.height,
      required this.color,
      this.child})
      : super(key: key);
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final Color color;
  final Widget? child;

  const ShimmerWidget.circular(
      {Key? key,
      required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder(),
      required this.color,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          shape: shapeBorder,
          color: color,
        ),
        child: child ?? Container(),
      ),
    );
  }
}
