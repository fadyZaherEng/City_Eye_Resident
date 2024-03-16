import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonCommentsScreen extends StatelessWidget {
  const SkeletonCommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
              itemCount: 50,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Row(
                    textDirection:
                        _isUser(index) ? TextDirection.ltr : TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: _isUser(index)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          const SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: 24,
                              height: 24,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 40,
                              height: 12,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: ColorSchemes.commentBackground,
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(25),
                                bottomStart: _isUser(index)
                                    ? Radius.circular(25)
                                    : Radius.circular(0),
                                bottomEnd: Radius.circular(25),
                                topEnd: _isUser(index)
                                    ? Radius.circular(0)
                                    : Radius.circular(25)),
                          ),
                          child: Center(
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                width: 100,
                                height: 12,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isUser(int index) {
    return index % 2 == 0;
  }
}
