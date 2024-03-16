import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/presentation/widgets/card_widget.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyServicesContentWidget extends StatefulWidget {
  final TextEditingController myServicesSearchController;
  final void Function(String value) onChangeSearch;
  final Function() onClearSearch;
  final Function(HomeService myServices) onTapService;
  final List<HomeService> myServices;
  final List<Offer> offers;
  final Function() onPullToRefresh;
  final Function(Offer offer) onTapOffer;

  const MyServicesContentWidget({
    Key? key,
    required this.myServicesSearchController,
    required this.onChangeSearch,
    required this.onClearSearch,
    required this.myServices,
    required this.offers,
    required this.onTapService,
    required this.onPullToRefresh,
    required this.onTapOffer,
  }) : super(key: key);

  @override
  State<MyServicesContentWidget> createState() =>
      _MyServicesContentWidgetState();
}

class _MyServicesContentWidgetState extends State<MyServicesContentWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.onPullToRefresh();
      },
      child: SingleChildScrollView(
        physics: null,
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Visibility(
              visible: widget.offers.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SliderWidget(
                  height: 125,
                  offers: widget.offers,
                  onTap: (offer) {
                    widget.onTapOffer(offer);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    SearchTextFieldWidget(
                      controller: widget.myServicesSearchController,
                      onChange: (value) {
                        widget.onChangeSearch(
                          value,
                        );
                      },
                      searchText: S.of(context).searchWhatYouNeed,
                      onClear: widget.onClearSearch,
                    ),
                    widget.myServices.isNotEmpty
                        ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 327,
                            childAspectRatio: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 13,
                            mainAxisExtent: 150,
                          ),
                          itemCount: widget.myServices.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return GestureDetector(
                              onTap: () {
                                widget.onTapService(
                                  widget.myServices[index],
                                );
                              },
                              child: SizedBox(
                                child: CardWidget(
                                  widget: CircularIcon(
                                    boxShadows: const [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 15,
                                        spreadRadius: 0,
                                        color:
                                            Color.fromRGBO(23, 43, 77, 0.16),
                                      ),
                                    ],
                                    isNetworkImage: widget
                                            .myServices[index].logo.isNotEmpty
                                        ? true
                                        : false,
                                    imagePath: widget
                                            .myServices[index].logo.isNotEmpty
                                        ? widget.myServices[index].logo
                                        : ImagePaths.frame,
                                    backgroundColor:
                                        ColorSchemes.iconBackGround,
                                    iconSize: 48,
                                    iconColor: ColorSchemes.primary,
                                  ),
                                  title: widget.myServices[index].name,
                                  subtitle:
                                      "${S.of(context).byWithSpase}: ${widget.myServices[index].name}",
                                ),
                              ),
                            );
                          },
                        )
                        : Column(
                            children: [
                              const SizedBox(height: 64),
                              CustomEmptyListWidget(
                                  imagePath: ImagePaths.noServices,
                                  text: S.of(context).noServiceFound,
                                  onRefresh: () {
                                    widget.onPullToRefresh();
                                  }),
                            ],
                          ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
