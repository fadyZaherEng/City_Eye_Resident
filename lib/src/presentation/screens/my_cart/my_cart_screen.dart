import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/usecase/set_services_index_use_case.dart';
import 'package:city_eye/src/presentation/blocs/my_cart/my_cart_bloc.dart';
import 'package:city_eye/src/presentation/screens/my_cart/skeleton/my_cart_skeleton.dart';
import 'package:city_eye/src/presentation/screens/my_cart/widgets/my_cart_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartScreen extends BaseStatefulWidget {
  final String parentServiceName;
  final List<ServiceDetailsCart> servicesDetailsCart;
  final HomeService serviceDetails;
  final bool isFromHome;

  const MyCartScreen(
      {required this.parentServiceName,
      required this.servicesDetailsCart,
      required this.serviceDetails,
      this.isFromHome = false,
      super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _MyCartScreenState();
}

class _MyCartScreenState extends BaseState<MyCartScreen> {
  MyCartBloc get _bloc => BlocProvider.of<MyCartBloc>(context);

  List<ServiceDetailsCart> _servicesDetailsCart = [];
  HomeService _serviceDetails = const HomeService();

  @override
  void initState() {
    _bloc.add(GetCompoundConfigurationEvent());
    _servicesDetailsCart = widget.servicesDetailsCart;
    _serviceDetails = widget.serviceDetails;
    super.initState();
  }

  String _compoundCurrency = '';

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<MyCartBloc, MyCartState>(
      listener: (context, state) async {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is CompoundConfigurationSuccessState) {
          _compoundCurrency =
              state.compoundConfiguration.compoundSetting.currency.code;
        } else if (state is CompoundConfigurationFailedState) {
        } else if (state is MyCartApplyCouponSuccessState) {
          showSnackBar(
              context: context,
              message: state.message,
              color: ColorSchemes.snackBarSuccess,
              icon: ImagePaths.success);
        } else if (state is MyCartApplyCouponFailedState) {
          showSnackBar(
              context: context,
              message: state.errorMessage,
              color: ColorSchemes.snackBarError,
              icon: ImagePaths.error);
        } else if (state is MyCartCheckNowSuccessState) {
          showSnackBar(
              context: context,
              message: state.message,
              color: ColorSchemes.snackBarSuccess,
              icon: ImagePaths.success);
          await SetServicesIndexUseCase(injector())(1).then((value) {
            if (widget.isFromHome) {
              _navigateToServicesScreen();
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          });
        } else if (state is MyCartCheckNowFailedState) {
          showSnackBar(
              context: context,
              message: state.errorMessage,
              color: ColorSchemes.snackBarError,
              icon: ImagePaths.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppBarWidget(
            context,
            title: S.of(context).myCart,
            isHaveBackButton: true,
            onBackButtonPressed: () {
              Navigator.pop(context);
            },
          ),
          body: MyCartWidget(
            parentServiceName: widget.parentServiceName,
            compoundCurrency: _compoundCurrency,
            servicesDetailsCart: _servicesDetailsCart,
            serviceDetails: _serviceDetails,
            onApplyButtonPressed: (value) {
              _bloc.add(ApplyCouponClickEvent(couponCode: value));
            },
            onCheckNowButtonPressed: () {
              _bloc.add(CheckNowClickEvent(
                  servicesDetailsCart: _servicesDetailsCart));
            },
          ),
        );
      },
    );
  }

  void _navigateToServicesScreen() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false,
        arguments: {
          "selectIndex": 3,
        });
  }
}
