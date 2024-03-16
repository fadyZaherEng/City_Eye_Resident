import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/support/support_service.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/support_item_widget.dart';
import 'package:flutter/material.dart';

class SupportItemsWidget extends StatelessWidget {
  final List<HomeSupport> items;
  final Function(HomeSupport) onTap;

  const SupportItemsWidget(
      {Key? key, this.items = const [], required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((element) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  child: SupportItemWidget(
                      item: element,
                      onTap: (element) {
                        onTap(element);
                      }),
                ))
            .toList(),
      ),
    );
  }
}
