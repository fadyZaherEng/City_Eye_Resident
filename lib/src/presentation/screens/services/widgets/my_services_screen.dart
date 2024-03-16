import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/data/sources/local/singleton/services/my_service_singleton.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/usecase/get_services_index_use_case.dart';
import 'package:city_eye/src/presentation/blocs/services/my_services_bloc.dart';
import 'package:city_eye/src/presentation/screens/services/skeleton/skeleton_my_services_screen.dart';
import 'package:city_eye/src/presentation/screens/services/widgets/my_services_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyServicesScreen extends StatefulWidget {
  final Function(int) startIndex;

  const MyServicesScreen({required this.startIndex, Key? key})
      : super(key: key);

  @override
  State<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {
  final TextEditingController _myServicesSearchController =
      TextEditingController();

  MyServicesBloc get _bloc => BlocProvider.of<MyServicesBloc>(context);

  MyServiceSingleton get _myServiceSingleton => MyServiceSingleton();

  List<Offer> _offers = [];
  List<HomeService> _filteredServicesForSpecificService = [];

  List<HomeService> _myServices = [];

  @override
  void initState() {
    _bloc.add(GetOffersEvent(pageCode: "Services"));
    _myServices = _myServiceSingleton.filteredServices;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyServicesBloc, MyServicesState>(
        listener: (context, state) {
      if (state is GetMyServicesSkeletonState) {
      } else if (state is GetOffersSuccessState) {
        _offers = state.offers;
      } else if (state is GetOffersErrorState) {
        showMassageDialogWidget(
          context: context,
          text: state.errorMessage,
          icon: ImagePaths.error,
          buttonText: S.of(context).ok,
          onTap: () {},
        );
      } else if (state is GetServicesAfterFilterationForSpecificServiceState) {
        _filteredServicesForSpecificService = state.filteredServices;
      } else if (state is GetMyServicesErrorState) {
        _onGetServicesErrorState(
          state.errorMessage,
        );
      } else if (state is ClearSearchState) {
        _onChangeSearch(services: state.myServices);
      } else if (state is SearchMyServicesState) {
        _onChangeSearch(
          services: state.myServices,
        );
      } else if (state is NavigateToMyServiceDetailsState) {
        _onNavigateToServiceDetailsState(myService: state.myService);
      } else if (state is OnTapOfferNavigateToWebViewState) {
        Navigator.pushNamed(context, Routes.webContent, arguments: {
          "screenTitle": state.offer.title,
          "content": state.offer.redirectUrl,
          "isLink": true,
        });
      }
    }, builder: (context, state) {
      if (state is GetMyServicesSkeletonState) {
        return const SkeletonMyServiceScreen();
      }
      return _buildContentWidget(
        myServices: _myServiceSingleton.homeServices,
        myFilteredServices: _myServices,
        offers: _offers,
      );
    });
  }

  Widget _buildContentWidget({
    required List<HomeService> myServices,
    required List<HomeService> myFilteredServices,
    required List<Offer> offers,
  }) {
    return MyServicesContentWidget(
      myServicesSearchController: _myServicesSearchController,
      onChangeSearch: (String value) {
        _bloc.add(SearchMyServicesEvent(
          searchValue: value.trim(),
          myServices: _myServiceSingleton.filteredServices,
        ));
      },
      onClearSearch: () {
        _bloc.add(
            ClearSearchEvent(myServices: _myServiceSingleton.filteredServices));
      },
      myServices: myFilteredServices,
      offers: offers,
      onTapOffer: (Offer offer) {
        _onTapOfferEvent(offer: offer);
      },
      onTapService: (HomeService myService) {
        if (_myServiceSingleton.filteredServices.isNotEmpty) {
          _bloc.add(FilterServicesAccordingBySpecificServiceEvent(
              homeServices: myServices, homeService: myService));
        }

        _bloc.add(NavigateToMyServiceDetailsEvent(
          myService: myService,
        ));
      },
      onPullToRefresh: () {
        _handleRefresh();
      },
    );
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetOffersEvent(pageCode: "Services"));
    _myServices = _myServiceSingleton.filteredServices;
  }

  void _onGetServicesErrorState(String errorMessage) {
    showMassageDialogWidget(
      context: context,
      text: errorMessage,
      icon: ImagePaths.error,
      buttonText: S.of(context).ok,
      onTap: () {},
    );
  }

  void _onChangeSearch({required final List<HomeService> services}) {
    _myServices = services;
  }

  void _onNavigateToServiceDetailsState({required HomeService myService}) {
    Navigator.pushNamed(
      context,
      Routes.serviceDetails,
      arguments: {
        "homeServices": _filteredServicesForSpecificService,
        "homeService": myService,
        "isFromHome": false,
      },
    ).then((value) =>
        widget.startIndex(GetServicesIndexUseCase(injector())() != 0 ? 1 : 0));
  }

  void _onTapOfferEvent({required Offer offer}) {
    _bloc.add(OnTapOfferEvent(offer: offer));
  }
}
