import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/payments_key.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_payment_methods_bottom_sheet.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:city_eye/src/domain/entities/payment/payment_request_payment_methods.dart';
import 'package:city_eye/src/presentation/blocs/payment_details/payment_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/payment_details/skeleton/payment_details_widget_skeleton.dart';
import 'package:city_eye/src/presentation/screens/payment_details/widgets/payment_details_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDetailsScreen extends BaseStatefulWidget {
  final int paymentId;

  const PaymentDetailsScreen({required this.paymentId, super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends BaseState<PaymentDetailsScreen>
    with WidgetsBindingObserver {
  PaymentDetailsBloc get _bloc => BlocProvider.of<PaymentDetailsBloc>(context);

  Payment _payment = const Payment();

  @override
  void initState() {
    _bloc.add(GetPaymentDetailsEvent(paymentId: widget.paymentId));
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _bloc.add(GetPaymentDetailsEvent(paymentId: widget.paymentId));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<PaymentDetailsBloc, PaymentDetailsState>(
      listener: (context, state) {
        if (state is PaymentPayNowLoadingState) {
          showLoading();
        } else {
          hideLoading();
        }
        if (state is GetPaymentDetailsSuccessState) {
          _payment = state.payment;
        } else if (state is GetPaymentDetailsErrorState) {
          _showMassageDialogWidget(
            state.errorMessage,
            ImagePaths.error,
            () {
              _popBack();
              _popBack();
            },
          );
        } else if (state is ShowPaymentMethodsBottomSheetState) {
          _showPaymentMethodsBottomSheet();
        } else if (state is OnSelectedPaymentMethodState) {
          _payment = state.payment;
          _onPayClicked(state.paymentMethod);
        } else if (state is PaymentPayNowSuccessState) {
          _onPaymentPayNowSuccessState(link: state.link);
        } else if (state is PaymentPayNowErrorState) {
          _showMessageDialog(
            text: state.errorMessage,
            icon: ImagePaths.error,
            onTap: () => _popBack(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          floatingActionButton: state is ShowSkeletonState
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _payment.paymentStatus.code == PaymentsKey.needPayment
                      ? CustomButtonWidget(
                          width: double.infinity,
                          onTap: () {
                            _showPaymentMethodsBottomSheetEvent();
                          },
                          text: S.of(context).pay,
                          backgroundColor: F.isNiceTouch
                              ? ColorSchemes.ghadeerDarkBlue
                              : ColorSchemes.primary,
                        )
                      : null,
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: state is ShowSkeletonState
              ? _buildSkeletonWidget()
              : _buildBodyWidget(_payment),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return buildAppBarWidget(
      context,
      title: S.of(context).invoiceDetails,
      isHaveBackButton: true,
      backgroundColor: ColorSchemes.primary,
      textColor: ColorSchemes.white,
      onBackButtonPressed: () {
        _popBack();
      },
    );
  }

  Widget _buildBodyWidget(Payment payment) {
    return PaymentDetailsWidget(payment: payment);
  }

  Widget _buildSkeletonWidget() {
    return const PaymentDetailsWidgetSkeleton();
  }

  void _showMassageDialogWidget(
    String message,
    String icon,
    Function() onTap,
  ) {
    showMassageDialogWidget(
      context: context,
      text: message,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () {
        onTap();
      },
    );
  }

  void _popBack() {
    Navigator.pop(context);
  }

  void _onPayClicked(PaymentRequestPaymentMethods paymentMethod) {
    _bloc.add(PayClickedEvent(payment: _payment, paymentMethod: paymentMethod));
  }

  void _showPaymentMethodsBottomSheetEvent() {
    _bloc.add(ShowPaymentMethodsBottomSheetEvent(
      paymentMethods: _payment.paymentRequestPaymentMethods,
    ));
  }

  void _showPaymentMethodsBottomSheet() {
    showPaymentMethodBottomSheet(
      context: context,
      height: 400,
      paymentMethod: _payment.paymentRequestPaymentMethods,
      onPaymentMethodSelected: (paymentMethod) {
        _bloc.add(OnSelectedPaymentMethodEvent(
          payment: _payment,
          paymentMethod: paymentMethod,
        ));
        _popBack();
      },
    );
  }

  void _showMessageDialog({
    required String text,
    required String icon,
    required Function() onTap,
  }) {
    showMassageDialogWidget(
        context: context,
        text: text,
        icon: icon,
        buttonText: S.of(context).ok,
        onTap: onTap);
  }

  void _onPaymentPayNowSuccessState({
    required String link,
  }) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
