import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_payment_methods_bottom_sheet.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:city_eye/src/domain/entities/payment/payment_request_payment_methods.dart';
import 'package:city_eye/src/domain/entities/settings/compound_currency.dart';
import 'package:city_eye/src/presentation/blocs/payment/payment_bloc.dart';
import 'package:city_eye/src/presentation/screens/payment/widgets/payment_skeleton_screen.dart';
import 'package:city_eye/src/presentation/screens/payment/widgets/pyments_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends BaseStatefulWidget {
  const PaymentScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _PaymentScreenState();
}

class _PaymentScreenState extends BaseState<PaymentScreen>
    with WidgetsBindingObserver {
  PaymentBloc get _bloc => BlocProvider.of<PaymentBloc>(context);
  List<Payment> _payments = [];
  final TextEditingController _searchController = TextEditingController();
  CompoundCurrency _currency = const CompoundCurrency();

  @override
  void initState() {
    // _bloc.add(GetCompoundConfigurationEvent());
    _bloc.add(GetPaymentsEvent());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _bloc.add(GetPaymentsEvent());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentPayNowLoadingState) {
          showLoading();
        } else {
          hideLoading();
        }
        if (state is GetCompoundConfigurationState) {
          _currency = state.compoundConfiguration.compoundSetting.currency;
        } else if (state is GetPaymentsSuccessState) {
          _payments = state.payments;
          if (_searchController.text.isNotEmpty) {
            _paymentSearchEvent(_searchController.text);
          }
        } else if (state is GetPaymentsErrorState) {
          _showMessageDialog(
            text: state.errorMessage,
            icon: ImagePaths.error,
            onTap: () => _paymentBackEvent(),
          );
        } else if (state is PaymentBackState) {
          Navigator.pop(context);
        } else if (state is PaymentSearchState) {
          _payments = state.payments;
        } else if (state is PaymentPayNowSuccessState) {
          _onPaymentPayNowSuccessState(link: state.link);
        } else if (state is PaymentPayNowErrorState) {
          _showMessageDialog(
            text: state.errorMessage,
            icon: ImagePaths.error,
            onTap: () => _paymentBackEvent(),
          );
        } else if (state is PaymentDetailsState) {
          Navigator.pushNamed(context, Routes.paymentDetails, arguments: {
            "paymentId": state.payment.id,
          });
        } else if (state is ShowPaymentMethodsBottomSheetState) {
          _showPaymentMethodsBottomSheet(state.payment);
        } else if (state is OnSelectedPaymentMethodState) {
          _payments = state.payments;
          _onPayClicked(state.payment, state.paymentMethod);
        }
      },
      builder: (context, state) {
        // if (state is GetPaymentsLoadingState) {
        //   return const PaymentSkeletonScreen();
        // } else {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBodyWidget(state),
        );
        // }
      },
    );
  }

  AppBar _buildAppBar() {
    return buildAppBarWidget(context,
        title: S.of(context).payment,
        isHaveBackButton: true, onBackButtonPressed: () {
      _paymentBackEvent();
    });
  }

  void _paymentBackEvent() => _bloc.add(PaymentBackEvent());

  Widget _buildBodyWidget(PaymentState state) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchTextFieldWidget(
              controller: _searchController,
              searchText: S.of(context).searchWhatYouNeed,
              onChange: (value) => _paymentSearchEvent(value),
              onClear: () => _paymentSearchEvent('')),
        ),
        state is GetPaymentsLoadingState
            ? const PaymentSkeletonScreen()
            : _payments.isNotEmpty
                ? PaymentsWidget(
                    payments: _payments,
                    compoundCurrency: _currency,
                    onTapPayNowAction: (Payment payment) {
                      _showPaymentMethodsBottomSheetEvent(payment);
                    },
                    onPullToRefresh: () {
                      _handleRefresh();
                    },
                    onPaymentCardTap: (Payment payment) {
                      _onTapPaymentCard(payment);
                    },
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: CustomEmptyListWidget(
                            imagePath: ImagePaths.dollars,
                            text: S.of(context).noPaymentsRightNow,
                            onRefresh: () {
                              _handleRefresh();
                            }),
                      ),
                    ),
                  ),
      ],
    );
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetPaymentsEvent());
  }

  void _paymentSearchEvent(String value) {
    _bloc.add(PaymentSearchEvent(value: value.trim()));
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

  void _onTapPaymentCard(Payment payment) {
    _bloc.add(PaymentDetailsEvent(payment: payment));
  }

  void _showPaymentMethodsBottomSheetEvent(Payment payment) {
    _bloc.add(ShowPaymentMethodsBottomSheetEvent(
      payment: payment,
    ));
  }

  void _showPaymentMethodsBottomSheet(Payment payment) {
    showPaymentMethodBottomSheet(
      context: context,
      height: 400,
      paymentMethod: payment.paymentRequestPaymentMethods,
      onPaymentMethodSelected: (paymentMethod) {
        _bloc.add(OnSelectedPaymentMethodEvent(
          payment: payment,
          paymentMethod: paymentMethod,
        ));
        Navigator.pop(context);
      },
    );
  }

  void _onPayClicked(
      Payment payment, PaymentRequestPaymentMethods paymentMethod) {
    _bloc.add(PaymentPayNowEvent(
      payment: payment,
    ));
  }
}
