import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/usecase/get_services_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_services_index_use_case.dart';
import 'package:city_eye/src/presentation/screens/services/my_subscription_screen/my_subscription_screen.dart';
import 'package:city_eye/src/presentation/screens/services/widgets/my_services_screen.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_tap_bar_widget.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends BaseStatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _ServicesScreenState();
}

class _ServicesScreenState extends BaseState<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = GetServicesIndexUseCase(injector())() != 0 ? 1 : 0;
    super.initState();
  }

  @override
  void deactivate() async {
    await SetServicesIndexUseCase(injector())(0);
    super.deactivate();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarWidget(
          context,
          title: S.of(context).services,
          isHaveBackButton: false,
        ),
        body: CustomTabBarWidget(
          titleOfTapOne: S.of(context).myServices,
          titleOfTapTwo: S.of(context).mySubscriptions,
          contentOfTapOne: MyServicesScreen(
            startIndex: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
          ),
          contentOfTapTwo: const MySubscriptionScreen(),
          tabController: _tabController,
        ));
  }
}
