import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/event_rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RulesWidget extends StatelessWidget {
  final List<EventRules> rules;
  final bool isVisible;

  const RulesWidget({
    Key? key,
    required this.rules,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImagePaths.rules,
                      fit: BoxFit.scaleDown,
                      width: 20,
                      height: 20,
                      color: ColorSchemes.primary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      S.of(context).rules,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            letterSpacing: -0.24,
                            color: ColorSchemes.black,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ...rules.map(
                  (rule) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 9),
                              height: 1,
                              width: 8,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                rule.description,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  letterSpacing: -0.24,
                                  color: ColorSchemes.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    );
                  },
                ).toList(),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorSchemes.border,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
        )
        : const SizedBox.shrink();
  }
}
