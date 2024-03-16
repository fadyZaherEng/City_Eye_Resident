import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/usecase/get_support_index_use_case.dart';
import 'package:city_eye/src/presentation/blocs/support/support_bloc.dart';
import 'package:city_eye/src/presentation/screens/support/skeleton/skeleton_support_services_widget.dart';
import 'package:city_eye/src/presentation/screens/support/widgets/support_services_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportWidget extends BaseStatefulWidget {
  final List<HomeSupport> supports;
  final Function(int) startIndex;

  const SupportWidget({
    Key? key,
    required this.supports,
    required this.startIndex,
  }) : super(key: key);

  @override
  BaseState<SupportWidget> baseCreateState() => _SupportWidgetState();
}

class _SupportWidgetState extends BaseState<SupportWidget> {
  SupportBloc get _bloc => BlocProvider.of<SupportBloc>(context);

  final TextEditingController _searchController = TextEditingController();

  List<HomeSupport> _supportServices = [];
  List<HomeSupport> _supportServicesForDetails = [];
  List<Offer> _offers = [];

  @override
  void initState() {
    _bloc.add(GetOffersDataEvent(request: OffersRequest(pageCode: "Support")));
    _supportServices = widget.supports;
    _bloc.supportServices = _supportServices;
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<SupportBloc, SupportState>(
      listener: (context, state) {
        if (state is ShowLoadingSupportState) {
          showLoading();
        } else if (state is HideLoadingSupportState) {
          hideLoading();
        } else if (state is GetSupportServicesErrorState) {
        } else if (state is NavigateToSupportServiceDetailsScreenState) {
          _navigateToSupportDetailsScreen(state.supportService);
        } else if (state is SearchSupportServicesSuccessState) {
          _supportServices = state.searchedSupportServices;
          _supportServicesForDetails = state.supportServices;
        } else if (state is SearchSupportServicesNotFoundState) {
          _supportServices = state.searchedSupportServices;
        } else if (state is ResetSupportServicesState) {
          _supportServices = List<HomeSupport>.of(state.supportServices);
        } else if (state is ResetSearchTextSupportServicesState) {
          _searchController.text = "";
        } else if (state is GetOffersDataSuccessState) {
          _offers = state.offers;
        } else if (state is GetOffersDataFailedState) {
          showMassageDialogWidget(
            context: context,
            text: state.message,
            icon: ImagePaths.error,
            buttonText: S.of(context).ok,
            onTap: () {
              Navigator.pop(context);
            },
          );
        } else if (state is OnTapOfferNavigateToWebViewState) {
          Navigator.pushNamed(context, Routes.webContent, arguments: {
            "screenTitle": state.offer.title,
            "content": state.offer.redirectUrl,
            "isLink": true,
          });
        }
      },
      builder: (context, state) {
        if (state is ShowSkeletonState) {
          return const SkeletonSupportServicesWidget();
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Visibility(
                visible: _offers.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: SliderWidget(
                    height: 125,
                    offers: _offers,
                    onTap: (offer) {
                      _onTapOfferEvent(offer: offer);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SearchTextFieldWidget(
                  controller: _searchController,
                  onChange: (value) {
                    _supportServiceSearchEvent(value, _supportServices);
                  },
                  searchText: S.of(context).searchWhatYouNeed,
                  onClear: () {
                    _searchController.clear();
                    _supportServiceSearchEvent("", _supportServices);
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SupportServicesWidget(
                supportServices: _supportServices,
                onTap: (supportService) {
                  _navigateToSupportDetailsScreenEvent(supportService);
                },
                onPullToRefresh: _handleRefresh,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetOffersDataEvent(request: OffersRequest(pageCode: "Support")));
  }

  void _supportServiceSearchEvent(
      String value, List<HomeSupport> supportServices) {
    _bloc.add(
      SearchSupportServicesEvent(
        searchText: value,
        supportServices: _bloc.supportServices,
      ),
    );
  }

  void _navigateToSupportDetailsScreenEvent(HomeSupport supportService) {
    return _bloc.add(
      NavigateToSupportServiceDetailsScreenEvent(
        supportService: supportService,
      ),
    );
  }

  void _navigateToSupportDetailsScreen(HomeSupport supportService) {
    Navigator.pushNamed(context, Routes.supportDetails, arguments: {
      "supportServices": _supportServicesForDetails.isNotEmpty
          ? _supportServicesForDetails
          : _bloc.supportServices,
      "selectedSupportService": supportService,
      "isFromSupportScreen": true,
    }).then((_) {
      _bloc.add(ResetSupportServicesEvent());
      _bloc.add(ResetSearchTextSupportServicesEvent());
      widget.startIndex(int.parse(GetSupportIndexUseCase(injector())()[1]) == 1 ? 1 : 0);
    });
  }

  void _onTapOfferEvent({required Offer offer}) {
    _bloc.add(OnTapOfferEvent(offer: offer));
  }
}
