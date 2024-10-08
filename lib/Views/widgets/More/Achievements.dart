import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

class AchievementsWidget extends StatelessWidget {
  final String text;
  final String svgAsset;
  final Color color;

  const AchievementsWidget({
    Key? key,
    required this.text,
    required this.svgAsset,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 128,
            decoration: BoxDecoration(
              color: blue600,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -14,
            left: 98,
            child: Container(
              width: 87,
              height: 87,
              decoration: const BoxDecoration(
                color: blue500,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  svgAsset,
                  width: 35,
                  height: 35,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}