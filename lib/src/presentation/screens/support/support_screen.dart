import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/data/sources/local/singleton/support/my_support_singleton.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/usecase/get_support_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_support_index_use_case.dart';
import 'package:city_eye/src/presentation/screens/support/widgets/orders_widget.dart';
import 'package:city_eye/src/presentation/screens/support/widgets/support_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_tap_bar_widget.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen>
    with SingleTickerProviderStateMixin {
  MySupportSingleton get _mySupportSingleton => MySupportSingleton();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = int.parse(GetSupportIndexUseCase(injector())()[1]) == 1 ? 1 : 0;
    super.initState();
  }

  @override
  void deactivate() async {
    await SetSupportIndexUseCase(injector())(["0", "0",""]);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBarWidget(
          context,
          title: S.of(context).supportScreenMain,
          isHaveBackButton: false,
        ),
        body: CustomTabBarWidget(
          contentOfTapOne: SupportWidget(
            supports: _mySupportSingleton.supports,
            startIndex: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
          ),
          contentOfTapTwo: OrdersWidget(),
          titleOfTapOne: S.of(context).supportScreen,
          titleOfTapTwo: S.of(context).myOrders,
          tabController: _tabController,
        ),
      ),
    );
  }
}
