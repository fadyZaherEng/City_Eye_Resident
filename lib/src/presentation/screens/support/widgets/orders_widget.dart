import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/network_connectivity.dart';
import 'package:city_eye/src/core/utils/open_rating_bottom_sheet_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/my_orders_request.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/domain/usecase/get_no_internet_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_support_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_support_index_use_case.dart';
import 'package:city_eye/src/presentation/blocs/orders/orders_bloc.dart';
import 'package:city_eye/src/presentation/screens/qr/widgets/history_header_widget.dart';
import 'package:city_eye/src/presentation/screens/support/skeleton/skeleton_order_card_widget.dart';
import 'package:city_eye/src/presentation/screens/support/utils/open_cancel_bottom_sheet.dart';
import 'package:city_eye/src/presentation/screens/support/widgets/order_card_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:city_eye/src/presentation/widgets/empty_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersWidget extends BaseStatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  BaseState<OrdersWidget> baseCreateState() => _MyOrdersWidgetState();
}

class _MyOrdersWidgetState extends BaseState<OrdersWidget>
    with WidgetsBindingObserver {
  OrdersBloc get _bloc => BlocProvider.of<OrdersBloc>(context);

  final TextEditingController _searchController = TextEditingController();

  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  bool isOnline = true;

  bool isCurrent = true;
  List<Orders> _orders = [];

  Color borderColor = ColorSchemes.primary;
  var itemCount = 0;
  var _key;
  Timer? _timer;
  var scrollToId = 0;
  bool isDialogShowed = false;
  bool _canCallApi = false;

  @override
  void initState() {
    super.initState();
    isCurrent = GetSupportIndexUseCase(injector())().last == "all_support" ||
            GetSupportIndexUseCase(injector())().last == "support_completed"
        ? false
        : true;
    // setIndex(0);
    WidgetsBinding.instance.addObserver(this);
    _getOrdersEvent(MyOrdersRequest(
      isCurrent: isCurrent,
    ));
    _internetConnectionListener();
  }

  void _internetConnectionListener() {
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) async {
      _source = source;
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          isOnline = _source.values.toList()[0];
          break;
        case ConnectivityResult.wifi:
          isOnline = _source.values.toList()[0];
          break;
        case ConnectivityResult.none:
        default:
          isOnline = false;
      }
      if (isOnline && _canCallApi) {
        _canCallApi = false;
        _getOrdersEvent(MyOrdersRequest(
          isCurrent: isCurrent,
        ));
      } else if (!isOnline && !_canCallApi) {
        _canCallApi = true;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (isDialogShowed) return;
      if (GetNoInternetUseCase(injector())() == false) {
        _getOrdersEvent(MyOrdersRequest(
          isCurrent: isCurrent,
        ));
      }
      _canCallApi = true;
    } else if (state == AppLifecycleState.paused) {
      _canCallApi = false;
    }
  }

  @override
  void didUpdateWidget(covariant OrdersWidget oldWidget) {
    _getOrdersEvent(MyOrdersRequest(
      isCurrent: isCurrent,
    ));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetOrdersSuccessState) {
          _orders = state.orders;
          scrollToId = int.parse(GetSupportIndexUseCase(injector())().first);
          _ordersSearchEvent(_searchController.text.trim());
          if (_orders.isNotEmpty &&
              GetSupportIndexUseCase(injector())().last ==
                  "support_completed") {
            for (int i = 0; i < _orders.length; i++) {
              if (_orders[i].id ==
                  int.parse(GetSupportIndexUseCase(injector())().first)) {
                _rateOrderPressedEvent(_orders[i]);
              }
            }
          }
        } else if (state is GetOrdersErrorState) {
          _showMessageDialog(
            context,
            state.message,
            ImagePaths.error,
            () {
              _navigateBackEvent();
            },
          );
        } else if (state is SelectOrderTypeState) {
          isCurrent = state.isCurrent;
          _getOrdersEvent(MyOrdersRequest(
            isCurrent: isCurrent,
          ));
        } else if (state is OrdersSearchState) {
          _orders = state.orders;
        } else if (state is NavigateBackState) {
          _navigateBack();
        } else if (state is PayOrderSuccessState) {
          _openPaymentSite(state.paymentUrl);
        } else if (state is PayOrderErrorState) {
          _showMessageDialog(
            context,
            state.errorMessage,
            ImagePaths.error,
            () {
              _navigateBackEvent();
            },
          );
        } else if (state is OpenRateBottomSheetState) {
          openRatingBottomSheetWidget(
            context: context,
            onSendAction: (rate, review) {
              _navigateBackEvent();
              _bloc.add(
                RateOrderEvent(
                  order: state.order,
                  rate: rate,
                  comment: review,
                ),
              );
            },
            rate: state.order.ratingValue.toDouble(),
            comment: state.order.ratingComment,
            isRated: state.order.isRating,
          );
        } else if (state is RateOrderSuccessState) {
          _showMessageDialog(
            context,
            state.message,
            ImagePaths.success,
            () {
              _navigateBackEvent();
              _getOrdersEvent(MyOrdersRequest(
                isCurrent: false,
              ));
            },
          );
        } else if (state is RateOrderErrorState) {
          _showMessageDialog(
            context,
            state.errorMessage,
            ImagePaths.error,
            () {
              _navigateBackEvent();
            },
          );
        } else if (state is OpenCancelBottomSheetState) {
          openCancelBottomSheet(
            context: context,
            onSend: (reason) {
              _navigateBackEvent();
              _bloc.add(CancelOrderEvent(order: state.order, reason: reason));
            },
          );
        } else if (state is CancelOrderSuccessState) {
          _showMessageDialog(
            context,
            state.message,
            ImagePaths.success,
            () {
              _navigateBackEvent();
              _getOrdersEvent(MyOrdersRequest(
                isCurrent: true,
              ));
            },
          );
          _searchController.text = "";
        } else if (state is CancelOrderErrorState) {
          _showMessageDialog(
            context,
            state.errorMessage,
            ImagePaths.error,
            () {
              _navigateBackEvent();
            },
          );
          _searchController.text = "";
        } else if (state is NavigateToCommentScreenState) {
          _navigateToCommentScreen(state.order);
        } else if (state is ScrollToItemState) {
          _scrollToIndex(state.key);
          getColor();
        } else if (state is NavigateToPaymentDetailsState) {
          _navigateToPaymentDetails(state.paymentId);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              HistoryHeaderWidget(
                firstPageTitle: S.of(context).openRequests,
                secondPageTitle: S.of(context).allRequests,
                onTabFirstButton: () {
                  if (!isCurrent) {
                    _selectOrderTypeEvent(true);
                  }
                },
                onTabSecondButton: () {
                  if (isCurrent) {
                    _selectOrderTypeEvent(false);
                  }
                },
                type: isCurrent ? 1 : 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SearchTextFieldWidget(
                    controller: _searchController,
                    onChange: (value) {
                      _ordersSearchEvent(value);
                    },
                    searchText: S.of(context).searchWhatYouNeed,
                    onClear: () {
                      _ordersSearchEvent('');
                    }),
              ),
              const SizedBox(
                height: 16,
              ),
              state is ShowSkeletonState ? _buildSkeleton() : _buildScreen(),
            ],
          ),
        );
      },
    );
  }

  void _navigateToPaymentDetails(int paymentId) {
    if (paymentId != 0) {
      Navigator.pushNamed(context, Routes.paymentDetails, arguments: {
        'paymentId': paymentId,
      });
    }
  }

  void _showMessageDialog(
    BuildContext context,
    String message,
    String icon,
    Function() onTab,
  ) {
    if (isDialogShowed) return;
    isDialogShowed = true;
    showMassageDialogWidget(
      context: context,
      text: message,
      buttonText: S.of(context).ok,
      onTap: () {
        isDialogShowed = false;
        onTab();
      },
      icon: icon,
    );
  }

  Widget _buildScreen() {
    return _orders.isEmpty ? _buildEmptyScreen() : _buildOrders();
  }

  Widget _buildSkeleton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const SkeletonOrderCardWidget();
          },
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    _getOrdersEvent(MyOrdersRequest(
      isCurrent: isCurrent,
    ));
  }

  Widget _buildOrders() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: _orders.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    itemCount++;
                    if (scrollToId != 0 && _orders[index].id == scrollToId) {
                      _key = _orders[index].key;
                    }
                    if (itemCount <= _orders.length && _key != null) {
                      _bloc.add(ScrollToItemEvent(key: _key));
                    }
                    return OrderCardWidget(
                      key: _orders[index].key,
                      order: _orders[index],
                      orderType: isCurrent ? 1 : 2,
                      borderColor:
                          _orders[index].id == scrollToId && _key != null
                              ? borderColor
                              : ColorSchemes.cardSelected,
                      onCancel: () {
                        _cancelOrderPressedEvent(_orders[index]);
                      },
                      onPayNow: () {
                        _navigateToPaymentDetailsEvent(
                            _orders[index].paymentId);
                      },
                      onComment: () {
                        _commentOrderEvent(_orders[index]);
                      },
                      onRate: () {
                        _rateOrderPressedEvent(_orders[index]);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _rateOrderPressedEvent(Orders order) {
    _bloc.add(RateOrderPressedEvent(order: order));
  }

  Widget _buildEmptyScreen() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: CustomEmptyListWidget(
              text: S.of(context).noRequestsRightNow,
              imagePath: ImagePaths.emptyOrders,
              onRefresh: () {
                _handleRefresh();
              }),
        ),
      ),
    );
  }

  Future<void> _openPaymentSite(String paymentUrl) async {
    Uri paymentUri = Uri.parse(paymentUrl);
    launchUrl(paymentUri).then((value) => {});
  }

  void _navigateBack() {
    Navigator.pop(context);
  }

  void _getOrdersEvent(MyOrdersRequest myOrdersRequest) {
    _bloc.add(
      GetOrdersEvent(myOrdersRequest: myOrdersRequest),
    );
  }

  void _ordersSearchEvent(String value) {
    _bloc.add(
      OrdersSearchEvent(value: value),
    );
  }

  void _selectOrderTypeEvent(bool isCurrent) {
    FocusScope.of(context).unfocus();
    _searchController.text = "";
    _bloc.add(
      SelectOrderTypeEvent(isCurrent: isCurrent),
    );
  }

  void _navigateToPaymentDetailsEvent(int paymentId) {
    _bloc.add(NavigateToPaymentDetailsEvent(
      paymentId: paymentId,
    ));
  }

  void _navigateBackEvent() {
    _bloc.add(
      NavigateBackEvent(),
    );
  }

  void _cancelOrderPressedEvent(Orders order) {
    _bloc.add(
      CancelOrderPressedEvent(order: order),
    );
  }

  void _commentOrderEvent(Orders order) {
    _bloc.add(
      CommentOrderEvent(order: order),
    );
  }

  void _navigateToCommentScreen(Orders order) {
    WidgetsBinding.instance.removeObserver(this);
    Navigator.pushNamed(context, Routes.commentScreen, arguments: {
      'order': order,
      "id": -1,
    }).then((value) {
      WidgetsBinding.instance.addObserver(this);
    });
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 300));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    ).then((value) async {
      setIndex(0);
    });
  }

  Future<void> setIndex(int index) async {
    await SetSupportIndexUseCase(injector())(["0", "0", ""]);
  }

  getColor() {
    _timer = Timer(const Duration(seconds: 2), () {
      borderColor = ColorSchemes.cardSelected;
      setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (mounted) {
      FocusScope.of(context).unfocus();
    }
    _timer?.cancel();
    super.dispose();
  }
}
