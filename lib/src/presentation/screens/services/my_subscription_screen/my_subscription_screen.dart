import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/services/my_subscription.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/usecase/get_services_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_services_index_use_case.dart';
import 'package:city_eye/src/presentation/blocs/services/my_subscriptions/my_subscriptions_bloc.dart';
import 'package:city_eye/src/presentation/screens/services/my_subscription_screen/skeleton/skeleton_my_subscription_item_widget.dart';
import 'package:city_eye/src/presentation/screens/services/my_subscription_screen/widgets/my_subscription_item_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:city_eye/src/presentation/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySubscriptionScreen extends StatefulWidget {
  const MySubscriptionScreen({super.key});

  @override
  State<MySubscriptionScreen> createState() => _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends State<MySubscriptionScreen> {
  MySubscriptionsBloc get _bloc =>
      BlocProvider.of<MySubscriptionsBloc>(context);

  List<MySubscription> _mySubscription = [];
  CompoundConfiguration _compoundConfiguration = const CompoundConfiguration();

  Color borderColor = ColorSchemes.primary;
  var itemCount = 0;
  var _key;
  Timer? _timer;
  var scrollToId = 0;

  @override
  void initState() {
    scrollToId = GetServicesIndexUseCase(injector())();
    _getMySubscriptionsDataEvent();
    super.initState();
  }

  Future<void> _getMySubscriptionsDataEvent() async {
    _bloc.add(GetMySubscriptionsDataEvent());
    await SetServicesIndexUseCase(injector())(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorSchemes.white,
      child: BlocConsumer<MySubscriptionsBloc, MySubscriptionsState>(
        listener: (context, state) {
          if (state is GetMySubscriptionsDataState) {
            _mySubscription = state.mySubscription;
            _compoundConfiguration = state.compoundConfiguration;
          } else if (state is ScrollToItemState) {
            _scrollToIndex(state.key);
            getColor();
          } else if (state is GetMySubscriptionsDataErrorState) {
            showMassageDialogWidget(
              context: context,
              text: state.message,
              icon: ImagePaths.error,
              buttonText: S.of(context).ok,
              onTap: () {
                Navigator.pop(context);
              },
            );
          }
        },
        builder: (context, state) {
          return state is ShowMySubscriptionsSkeletonState
              ? const SkeletonMySubscriptionItemWidget()
              : _mySubscription.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () => _getMySubscriptionsDataEvent(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 6,
                            ),
                            ListView.builder(
                              itemCount: _mySubscription.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                itemCount++;
                                if (scrollToId != 0 &&
                                    _mySubscription[index].id == scrollToId) {
                                  _key = _mySubscription[index].key;
                                }
                                if (itemCount <= _mySubscription.length &&
                                    _key != null) {
                                  _bloc.add(ScrollToItemEvent(key: _key));
                                }
                                return MySubscriptionItemWidget(
                                    key: _mySubscription[index].key,
                                    mySubscription: _mySubscription[index],
                                    currency: _compoundConfiguration
                                        .compoundSetting.currency.code,
                                    borderColor: _mySubscription[index].id ==
                                                scrollToId &&
                                            _key != null
                                        ? borderColor
                                        : ColorSchemes.white,
                                    onQRTab: (MySubscription mySubscription) {
                                      // Navigator.pushNamed(
                                      //     context, Routes.webContent,
                                      //     arguments: {
                                      //       "screenTitle":
                                      //           S.of(context).delegated,
                                      //       // "content": mySubscription.qrImage,
                                      //       "content":
                                      //           "https://filesamples.com/samples/document/pdf/sample3.pdf",
                                      //       "isLink": true,
                                      //       "isPdf": true,
                                      //     });
                                      Navigator.pushNamed(
                                          context, Routes.pdfScreen,
                                          arguments: {
                                            "screenTitle":
                                            S.of(context).mySubscriptions,
                                            // "content": mySubscription.qrImage,
                                            "link":
                                            mySubscription.qrImage,
                                          });
                                    });
                              },
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                    )
                  : CustomEmptyListWidget(
                      text: S.of(context).noBookingsRightNow,
                      imagePath: ImagePaths.emptySubscription,
                      onRefresh: () => _getMySubscriptionsDataEvent(),
                    );
        },
      ),
    );
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 300));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  getColor() {
    _timer = Timer(const Duration(seconds: 2), () {
      borderColor = ColorSchemes.white;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
