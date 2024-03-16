import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/settings/compound_currency.dart';
import 'package:city_eye/src/presentation/screens/events/details/widgets/text_with_icon_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class EventDetailsInformationWidget extends StatelessWidget {
  final HomeEventItem? myEvent;
  final CompoundCurrency currency;
  final Function() onLocationAddressTap;

  const EventDetailsInformationWidget({
    this.myEvent,
    required this.currency,
    required this.onLocationAddressTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            myEvent!.title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  letterSpacing: -0.24,
                  color: ColorSchemes.black,
                ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWithIconWidget(
                text: convertTimestampToDateFormat(myEvent!.startDate),
                imagePath: ImagePaths.calender,
              ),
              const SizedBox(
                width: 10,
              ),
              TextWithIconWidget(
                text: _getName(context),
                imagePath: ImagePaths.persons,
              ),
              const SizedBox(
                width: 10,
              ),
              Visibility(
                visible: myEvent!.isPaid,
                child: CustomButtonWidget(
                  onTap: () {},
                  text: "${myEvent!.memberPrice} ${currency.code} / ${S.of(context).person}",
                  height: 30,
                  backgroundColor: Colors.white,
                  textColor: ColorSchemes.primary,
                  fontWeight: Constants.fontWeightRegular,
                  borderColor: ColorSchemes.primary,
                  buttonBorderRadius: 8,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              TextWithIconWidget(
                text: S.of(context).eventDate,
                imagePath: ImagePaths.calendarEvents,
              ),
              const SizedBox(
                width: 24,
              ),
              Container(
                height: 30,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: ColorSchemes.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    convertTimestampToDateFormat(myEvent!.endDate),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          letterSpacing: -0.24,
                          color: ColorSchemes.black,
                        ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: (){
              onLocationAddressTap();
            },
            child: TextWithIconWidget(
              text: myEvent!.locationAddress,
              imagePath: ImagePaths.locations,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            myEvent!.description,
            maxLines: 3,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  letterSpacing: -0.24,
                  color: ColorSchemes.black,
                ),
          ),
        ],
      ),
    );
  }

  String _getName(BuildContext context) {
    if(myEvent!.memberCount > 1) return "${myEvent!.memberCount} ${S.of(context).people}" ;
    return "${myEvent!.memberCount} ${S.of(context).person}" ;  }
}
