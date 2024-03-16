import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/usecase/get_services_index_use_case.dart';
import 'package:city_eye/src/presentation/blocs/service_details/service_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/service_details/widgets/service_details_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceDetailsScreen extends BaseStatefulWidget {
  final List<HomeService> homeServices;
  final HomeService homeService;
  final bool isFromHome;

  const ServiceDetailsScreen({
    Key? key,
    required this.homeServices,
    required this.homeService,
    this.isFromHome = false,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends BaseState<ServiceDetailsScreen> {
  ServiceDetailsBloc get _bloc => BlocProvider.of<ServiceDetailsBloc>(context);

  @override
  void initState() {
    _bloc.add(GetServiceDetailsEvent());
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ServiceDetailsBloc, ServiceDetailsState>(
        listener: (context, state) {
      if (state is GetServiceDetailsLoadingState) {
        _onGetServiceDetailsLoadingState();
      } else if (state is GetServiceDetailsSuccessState) {
        //_onGetServiceDetailsSuccessState(serviceDetails: state.serviceDetails);
      } else if (state is GetServiceDetailsErrorState) {
        _onGetServiceDetailsErrorState(errorMessage: state.errorMessage);
      } else if (state is NavigateToServiceScreenState) {
        _onNavigateToServiceState(
            parentServiceName: state.parentServiceName,
            homeService: state.homeService);
      }
    }, builder: (context, state) {
      return ServiceDetailsContentWidget(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        title: widget.homeService.name,
        serviceDetails: widget.homeServices,
        onTapService: (HomeService homeService) {
          _bloc.add(NavigateToServiceScreenEvent(
            parentServiceName: widget.homeService.name,
            homeService: homeService,
          ));
        },
      );
    });
  }

  void _onGetServiceDetailsLoadingState() {}

  void _onGetServiceDetailsErrorState({
    required String errorMessage,
  }) {
    showMassageDialogWidget(
      context: context,
      text: errorMessage,
      icon: ImagePaths.error,
      buttonText: S.of(context).ok,
      onTap: () {},
    );
  }

  void _onNavigateToServiceState({
    required HomeService homeService, required String parentServiceName,
  }) {
    Navigator.pushNamed(
      context,
      Routes.serviceDetailsCart,
      arguments: {
        "parentServiceName": parentServiceName,
        'serviceDetailsCart': homeService,
        "isFromHome": widget.isFromHome,
      },
    ).then((value) {
      if (GetServicesIndexUseCase(injector())() != 0) {
        Navigator.pop(context);
      }
    });
  }
}
