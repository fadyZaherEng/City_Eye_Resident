import 'package:city_eye/src/domain/entities/register/city_compound.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_with_close_icon_widget.dart';
import 'package:flutter/widgets.dart';

class CountriesWidget extends StatefulWidget {
  final List<CityCompound> regions;
  final CityCompound selectedRegion;
  final Function(CityCompound region) onSelectRegion;
  final Function(CityCompound region) onCloseRegion;

  const CountriesWidget({
    Key? key,
    required this.regions,
    required this.selectedRegion,
    required this.onSelectRegion,
    required this.onCloseRegion,
  }) : super(key: key);

  @override
  State<CountriesWidget> createState() => _CountriesWidgetState();
}

class _CountriesWidgetState extends State<CountriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SizedBox(
          height: 35,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.regions.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8.0,
                  ),
                  child: CustomButtonBorderWithCloseIconWidget(
                    isSelected:
                        widget.regions[index].id == widget.selectedRegion.id,
                    onTap: () {
                      widget.onSelectRegion(
                        widget.regions[index],
                      );
                    },
                    buttonTitle: widget.regions[index].name,
                    onTapClose: () {
                      widget.onCloseRegion(
                        widget.regions[index],
                      );
                    },
                    isAllItems: widget.regions[index].id == -1 ? true : false,
                  ),
                );
              }),
        ));
  }
}
