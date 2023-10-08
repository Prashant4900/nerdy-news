import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:shimmer/shimmer.dart';

(Color baseColor, Color highLightColor) getShimmerColor(BuildContext context) {
  final brightness = Theme.of(context).brightness;

  Color baseColor;
  Color highLightColor;

  if (brightness == Brightness.light) {
    baseColor = Colors.grey[300]!;
    highLightColor = Colors.grey[100]!;
  } else {
    baseColor = Colors.white10;
    highLightColor = Colors.white24;
  }
  return (baseColor, highLightColor);
}

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: getShimmerColor(context).$1,
      highlightColor: getShimmerColor(context).$2,
      child: Container(
        color: const Color(0xFFF2F2F2),
        height: 200,
        width: double.infinity,
      ),
    );
  }
}

class NewsListShimmerWidget extends StatelessWidget {
  const NewsListShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: getShimmerColor(context).$1,
      highlightColor: getShimmerColor(context).$2,
      child: const Padding(
        padding: allPadding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediumSkeletonNewsCard(),
            verticalMargin16,
            SmallSkeletonNewsCard(),
            verticalMargin16,
            SmallSkeletonNewsCard(),
          ],
        ),
      ),
    );
  }
}

class SmallSkeletonNewsCard extends StatelessWidget {
  const SmallSkeletonNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        verticalMargin4,
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        verticalMargin4,
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        verticalMargin12,
        Row(
          children: [
            const CircleAvatar(radius: 8),
            horizontalMargin8,
            Container(
              height: 15,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MediumSkeletonNewsCard extends StatelessWidget {
  const MediumSkeletonNewsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        verticalMargin12,
        Row(
          children: [
            const CircleAvatar(radius: 8),
            horizontalMargin8,
            Container(
              height: 15,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        verticalMargin12,
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        verticalMargin8,
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        verticalMargin8,
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        verticalMargin8,
        Container(
          height: 15,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
