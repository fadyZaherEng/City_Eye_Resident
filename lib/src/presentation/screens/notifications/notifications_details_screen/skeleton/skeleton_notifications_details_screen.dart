import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonNotificationDetailsScreen extends StatelessWidget {
  const SkeletonNotificationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(children: [
          SizedBox(
            width: 12,
          ),
          SkeletonLine(
            style: SkeletonLineStyle(height: 10, width: 100),
          ),
          Expanded(
            child: SizedBox(
              width: 10,
            ),
          ),
          SkeletonLine(
            style: SkeletonLineStyle(height: 10, width: 50),
          ),
          SizedBox(
            width: 12,
          ),
        ]),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 160, // Set your desired image height
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10, // Set your desired image height
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10, // Set your desired image height
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10, // Set your desired image height
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10, // Set your desired image height
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10, // Set your desired image height
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
