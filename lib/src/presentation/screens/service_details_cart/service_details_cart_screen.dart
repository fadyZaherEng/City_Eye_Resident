import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/open_daynamic_questions_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/set_services_index_use_case.dart';
import 'package:city_eye/src/presentation/blocs/service_details_cart/service_details_cart_bloc.dart';
import 'package:city_eye/src/presentation/screens/service_details_cart/skeleton/skeleton_service_details_cart.dart';
import 'package:city_eye/src/presentation/screens/service_details_cart/widgets/service_details_cart_footer.dart';
import 'package:city_eye/src/presentation/screens/service_details_cart/widgets/services_details_cart_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceDetailsCartScreen extends BaseStatefulWidget {
  final String parentServiceName;
  final HomeService serviceDetails;
  final bool isFromHome;

  const ServiceDetailsCartScreen({
    Key? key,
    required this.parentServiceName,
    required this.serviceDetails,
    this.isFromHome = false,
  }) : super(key: key);

  @override
  BaseState<ServiceDetailsCartScreen> baseCreateState() =>
      _ServiceDetailsCartScreenState();
}

class _ServiceDetailsCartScreenState
    extends BaseState<ServiceDetailsCartScreen> {
  ServiceDetailsCartBloc get _bloc =>
      BlocProvider.of<ServiceDetailsCartBloc>(context);

  List<ServiceDetailsCart> _servicesDetailsCart = [];
  double _totalPrice = 0;
  CompoundConfiguration _compoundConfiguration = const CompoundConfiguration();

  @override
  void initState() {
    super.initState();
    _getServiceDetailsCartEvent();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ServiceDetailsCartBloc, ServiceDetailsCartState>(
      listener: (context, state) async {
        if (state is NavigateBackState) {
          Navigator.pop(context);
        } else if (state is GetServiceDetailsCartSuccessState) {
          _servicesDetailsCart = state.servicesDetailsCart;
          _compoundConfiguration = state.compoundConfiguration;
        } else if (state is GetServiceDetailsCartErrorState) {
          _showMessageDialog(
            state.errorMessage,
            ImagePaths.error,
          );
        } else if (state is ChangeServiceState) {
          _servicesDetailsCart = state.servicesDetailsCart;
          _getTotalPriceEvent();
        } else if (state is AddServiceCountState) {
          _servicesDetailsCart = state.servicesDetailsCart;
          _getTotalPriceEvent();
        } else if (state is MinusServiceCountState) {
          _servicesDetailsCart = state.servicesDetailsCart;
          _getTotalPriceEvent();
        } else if (state is GetTotalPriceState) {
          _totalPrice = state.totalPrice;
        } else if (state is ShowAreYouSureDialogState) {
          _showActionDialog();
        } else if (state is OpenDynamicBottomSheetState) {
          _onOpenDynamicBottomSheetState(
              questions: state.questions,
              serviceDetailsCart: state.serviceDetailsCart,
              isEdit: state.isEdit);
        } else if (state is LoadingContinueServiceDetailsCart) {
          showLoading();
        } else if (state is SuccessContinueServiceDetailsCart) {
          hideLoading();
          _showMessageDialog(state.message, ImagePaths.success,
              backFromScreen: true);
        } else if (state is ErrorContinueServiceDetailsCart) {
          hideLoading();
          _showMessageDialog(
            state.errorMessage,
            ImagePaths.error,
          );
        } else if (state is NavigateToCartScreenState) {
          hideLoading();
          _navigateToCartScreen(
              servicesDetailsCart: state.servicesDetailsCart,
              serviceDetails: state.serviceDetails);
        } else if (state is ResetServicesDetailsCartState) {
          await SetServicesIndexUseCase(injector())(1);
          if (widget.isFromHome) {
            _navigateToServicesScreen();
          } else {
            _navigateBackEvent();
          }
        } else if (state is AddServiceCountErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            _isThereItemInCartEvent(_totalPrice);
            return Future.value(false);
          },
          child: Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: widget.serviceDetails.name,
              isHaveBackButton: true,
              onBackButtonPressed: () {
                _isThereItemInCartEvent(_totalPrice);
              },
            ),
            body: state is ShowSkeletonState
                ? const SkeletonServiceDetailsCart()
                : Column(
                    children: [
                      ServicesDetailsCartWidget(
                        openQuestions: (serviceDetailsCart) {
                          if (serviceDetailsCart.isSelected) {
                            _bloc.add(
                              OpenDynamicQuestionBottomSheetEvent(
                                questions:
                                    serviceDetailsCart.servicePackageQuestions,
                                serviceDetailsCart: serviceDetailsCart,
                              ),
                            );
                          }
                        },
                        currency:
                            _compoundConfiguration.compoundSetting.currency,
                        servicesDetailsCart: _servicesDetailsCart,
                        onServiceDetailsCartChanged: (serviceDetailsCart) {
                          _bloc.add(
                            ChangeServiceStateEvent(
                              servicesDetailsCart: _servicesDetailsCart,
                              selectedServiceDetailsCart: serviceDetailsCart,
                            ),
                          );
                        },
                        onAddTab: (serviceDetailsCart) {
                          if (serviceDetailsCart.isSelected) {
                            _bloc.add(AddServiceCountEvent(
                              servicesDetailsCart: _servicesDetailsCart,
                              selectedServiceDetailsCart: serviceDetailsCart,
                            ));
                          } else {
                            _bloc.add(
                              ChangeServiceStateEvent(
                                servicesDetailsCart: _servicesDetailsCart,
                                selectedServiceDetailsCart: serviceDetailsCart,
                              ),
                            );
                          }
                        },
                        onMinusTab: (serviceDetailsCart) {
                          if (serviceDetailsCart.isSelected &&
                              serviceDetailsCart.quantity > 0) {
                            _bloc.add(MinusServiceCountEvent(
                              servicesDetailsCart: _servicesDetailsCart,
                              selectedServiceDetailsCart: serviceDetailsCart,
                            ));
                          }
                        },
                      ),
                      ServiceDetailsCartFooter(
                        totalPrice: _totalPrice,
                        currency: _compoundConfiguration
                            .compoundSetting.currency.code,
                        onContinueTap: () {
                          _bloc.add(ContinueServiceDetailsCartEvent(
                              servicesDetailsCart: _servicesDetailsCart,
                              serviceDetails: widget.serviceDetails));
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  void _isThereItemInCartEvent(double totalPrice) {
    _bloc.add(CheckIsThereItemInCartEvent(
      totalPrice: totalPrice,
    ));
  }

  void _getServiceDetailsCartEvent() {
    _bloc.add(
      GetServiceDetailsCartEvent(serviceId: widget.serviceDetails.id),
    );
  }

  void _getTotalPriceEvent() {
    _bloc.add(
      GetTotalPriceEvent(servicesDetailsCart: _servicesDetailsCart),
    );
  }

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
  }

  void _showMessageDialog(String text, String icon,
      {bool backFromScreen = false}) {
    showMassageDialogWidget(
        context: context,
        icon: icon,
        text: text,
        onTap: () {
          _navigateBackEvent();
          if (backFromScreen) {
            _bloc.add(ResetServicesDetailsCart());
          }
        },
        buttonText: S.of(context).ok);
  }

  void _showActionDialog() {
    showActionDialogWidget(
      context: context,
      icon: ImagePaths.warning,
      text: S
          .of(context)
          .returningToThePreviousScreenWillResetYourCurrentProgressAreYouSureYouWantToProceed,
      primaryText: S.of(context).no,
      primaryAction: () {
        _navigateBackEvent();
      },
      secondaryText: S.of(context).yes,
      secondaryAction: () {
        _navigateBackEvent();
        _navigateBackEvent();
      },
    );
  }

  void _onOpenDynamicBottomSheetState({
    required List<PageField> questions,
    required ServiceDetailsCart serviceDetailsCart,
    required bool isEdit,
  }) {
    openDynamicQuestionsBottomSheet(
      context: context,
      height: 400,
      questions: questions.map((e) => e.deepClone()).toList(),
      onOkPresses: (List<PageField> pageFields) {
        Navigator.pop(context);
        serviceDetailsCart = serviceDetailsCart.copyWith(
          servicePackageQuestions: pageFields,
        );
        for (int i = 0; i < _servicesDetailsCart.length; i++) {
          if (_servicesDetailsCart[i].id == serviceDetailsCart.id) {
            _servicesDetailsCart[i] = serviceDetailsCart;
          }
        }
        if (!isEdit) {
          _bloc.add(
            AddServiceCountEvent(
              servicesDetailsCart: _servicesDetailsCart,
              selectedServiceDetailsCart: serviceDetailsCart,
            ),
          );
        }
      },
    ).then((value) => _bloc.add(ResetServiceDetailsCartEvent()));
  }

  void _navigateToServicesScreen() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false,
        arguments: {
          "selectIndex": 3,
        });
  }

  void _navigateToCartScreen(
      {required List<ServiceDetailsCart> servicesDetailsCart,
      required HomeService serviceDetails}) {
    Navigator.pushNamed(context, Routes.myCart, arguments: {
      "parentServiceName": widget.parentServiceName,
      "servicesDetailsCart": servicesDetailsCart,
      "serviceDetails": serviceDetails,
      "isFromHome": widget.isFromHome,
    });
  }
}
