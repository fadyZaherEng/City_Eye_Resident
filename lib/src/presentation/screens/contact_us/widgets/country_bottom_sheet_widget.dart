import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/domain/entities/contact_us/country.dart';
import 'package:city_eye/src/presentation/widgets/custom_radio_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:flutter/material.dart';


class CountryBottomSheetWidget extends StatefulWidget {
  final List<Country> countries;
  final Country selectedCountry;
  final Function(Country) onCountrySelected;
  final ScrollPhysics? scrollPhysics;

  const CountryBottomSheetWidget({
    Key? key,
    required this.countries,
    required this.selectedCountry,
    required this.onCountrySelected,
    this.scrollPhysics,
  }) : super(key: key);

  @override
  State<CountryBottomSheetWidget> createState() =>
      _CountryBottomSheetWidgetState();
}

class _CountryBottomSheetWidgetState extends State<CountryBottomSheetWidget> {
  TextEditingController controller = TextEditingController();
  List<Country> _filteredCountries = [];

  @override
  void initState() {
    _filteredCountries = widget.countries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16,),
        SearchTextFieldWidget(
          controller: controller,
          onChange: (value) {
            _filteredCountries = widget.countries
                .where((element) =>
                    element.name.toLowerCase().contains(value.toLowerCase()))
                .toList();
            setState(() {});
          },
          searchText: S.of(context).search,
          onClear: () {
            controller.clear();
            _filteredCountries = widget.countries;
            setState(() {});
          },
        ),
        const SizedBox(height: 16,),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: widget.scrollPhysics,
            itemCount: _filteredCountries.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () =>
                        widget.onCountrySelected(_filteredCountries[index]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.network(
                              _filteredCountries[index].name,
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  ImagePaths.flagPlaceHolder,
                                  fit: BoxFit.fill,
                                  width: 24,
                                  height: 24,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            _filteredCountries[index].name,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: Constants.fontWeightRegular,
                                      letterSpacing: -0.24,
                                      color: widget.selectedCountry.code ==
                                              _filteredCountries[index].code
                                          ? ColorSchemes.primary
                                          : ColorSchemes.gray,
                                    ),
                          ),
                          const Expanded(child: SizedBox()),
                          CustomRadioButtonWidget(
                            isSelected: widget.selectedCountry.code ==
                                _filteredCountries[index].code,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 0.6,
                    width: double.infinity,
                    color: ColorSchemes.border,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
