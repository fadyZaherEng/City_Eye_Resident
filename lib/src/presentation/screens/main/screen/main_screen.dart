import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/core/utils/check_app_version.dart';
import 'package:city_eye/src/core/utils/notification_services.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:city_eye/src/domain/entities/home/home_section_item.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/entities/push_notification/firebase_notification_data.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/domain/usecase/get_can_navigate_to_badge_screen_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/home/get_home_compound_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_current_country_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_can_navigate_to_badge_screen_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_no_internet_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_qr_code_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_support_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_switch_logo_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_services_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_wall_item_id_use_case.dart';
import 'package:city_eye/src/presentation/screens/home/home_screen.dart';
import 'package:city_eye/src/presentation/screens/more/more_screen.dart';
import 'package:city_eye/src/presentation/screens/my_cart/my_cart_screen.dart';
import 'package:city_eye/src/presentation/screens/services/services_screen.dart';
import 'package:city_eye/src/presentation/screens/support/support_screen.dart';
import 'package:city_eye/src/presentation/screens/wall/wall_screen.dart';
import 'package:city_eye/src/presentation/widgets/restart_widget.dart';
import 'package:country_ip/country_ip.dart';

// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MainScreen extends BaseStatefulWidget {
  final int selectIndex;

  const MainScreen({
    this.selectIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen>
    with WidgetsBindingObserver {
  late StreamSubscription<UserAccelerometerEvent> shakeAppListener;
  int _selectedIndex = 0;
  List<Widget> _pages = [];
  List<BottomNavigationBarItem> _navigationItems = [];
  bool _dataInitialied = false;

  List<double> accelerationValues = List.filled(3, 2.0);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    checkVersion(context);
    _selectedIndex = widget.selectIndex;
    _shakeAppListener();
    _getCurrentCountryCode();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) async {
    super.didChangeAppLifecycleState(appLifecycleState);
    if (appLifecycleState == AppLifecycleState.resumed) {
      // _shakeAppListener();
      await SetCanNavigateToBadgeScreenUseCase(injector())(true);
    } else if (appLifecycleState == AppLifecycleState.paused) {
      // await shakeAppListener.cancel();
      await SetCanNavigateToBadgeScreenUseCase(injector())(false);
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await SetNoInternetUseCase(injector())(false);
    WidgetsBinding.instance.removeObserver(this);
  }

  void _getCurrentCountryCode() async {
    final countryIpResponse = await CountryIp.find();
    await SaveCurrentCountryCodeUseCase(injector())(
        countryIpResponse?.countryCode ?? "EG");
  }

  void _shakeAppListener() async {
    await SetCanNavigateToBadgeScreenUseCase(injector())(true);
    shakeAppListener = userAccelerometerEventStream(
      samplingPeriod: const Duration(milliseconds: 500),
    ).listen((UserAccelerometerEvent event) {
      accelerationValues = <double>[event.x, event.y, event.z];

      if (isShake(accelerationValues)) {
        _handleShake();
      }
    });
  }

  bool isShake(List<double> values) {
    const double shakeThreshold = 30;

    double acceleration = values.reduce((sum, value) => sum + value.abs());

    return acceleration > shakeThreshold;
  }

  void _handleShake() async {
    setState(() {});
    if (GetCanNavigateToBadgeScreenUseCase(injector())()) {
      await SetCanNavigateToBadgeScreenUseCase(injector())(false)
          .then((value) => Navigator.pushNamed(context, Routes.badgeIdentity));
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_dataInitialied) {
      return;
    }
    _notificationListener();
    _dataInitialied = true;
    DataState<CompoundConfiguration> dataState =
        await GetCompoundConfigurationUseCase(injector())();
    if (dataState is DataSuccess) {
      await SaveCompoundConfigurationUseCase(injector())(
        dataState.data ?? const CompoundConfiguration(),
      );
    } else {
      //TODO handle error
    }

    DataState<HomeCompound> home = await GetHomeCompoundUseCase(injector())();
    if (home is DataSuccess) {
      List<HomeCompoundItem> items = home.data?.homeSections ?? [];
      _pages = [
        HomeScreen(
          homeCompound: home.data ?? const HomeCompound(),
        ),
        SupportScreen(),
        WallScreen(),
        ServicesScreen(),
        MoreScreen(),
      ];
      _navigationItems = [
        _item(
          label: S.of(context).home,
          iconSelected: ImagePaths.selectedHome,
          iconUnSelected: ImagePaths.unselectedHome,
        ),
        _item(
          label: S.of(context).homeSupport,
          iconSelected: ImagePaths.selectedMaintenance,
          iconUnSelected: ImagePaths.unSelectedMaintenance,
        ),
        _item(
          label: S.of(context).wall,
          iconSelected: ImagePaths.selectedWall,
          iconUnSelected: ImagePaths.unselectedWall,
        ),
        _item(
          label: S.of(context).services,
          iconSelected: ImagePaths.selectedServices,
          iconUnSelected: ImagePaths.unSelectedServices,
        ),
        _item(
          label: S.of(context).more,
          iconSelected: ImagePaths.selectedMore,
          iconUnSelected: ImagePaths.unSelectedMore,
        )
      ];

      for (var item in items) {
        if (item.code == 'SUPPORT' && !item.isVisible) {
          _pages.removeAt(_navigationItems
              .indexWhere((element) => element.label == S.of(context).support));
          _navigationItems.removeAt(_navigationItems
              .indexWhere((element) => element.label == S.of(context).support));
        } else if (item.code == 'SERVICES' && !item.isVisible) {
          _pages.removeAt(_navigationItems.indexWhere(
              (element) => element.label == S.of(context).services));
          _navigationItems.removeAt(_navigationItems.indexWhere(
              (element) => element.label == S.of(context).services));
        }
      }
      setState(() {});
    } else {}
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: _pages.isEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 48,
                              width: 48,
                              borderRadius: BorderRadius.circular(16),
                              shape: BoxShape.rectangle),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 5,
                                width: 50,
                              ),
                            ),
                            SizedBox(height: 10),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 5,
                                width: 100,
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 40,
                              width: 40,
                              borderRadius: BorderRadius.circular(16),
                              shape: BoxShape.circle),
                        )
                      ],
                    ),
                    const SizedBox(height: 28),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 160,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(32),
                          shape: BoxShape.rectangle),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 8,
                              width: 8,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 8,
                              width: 8,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 8,
                              width: 8,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 8,
                              width: 8,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.circle),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: ColorSchemes.borderGray,
                          width: 1,
                        ),
                      ),
                      height: 111,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 8,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 8,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ],
                            ),
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                  height: 100,
                                  width: 90,
                                  borderRadius: BorderRadius.circular(22),
                                  shape: BoxShape.rectangle),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 33),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 10,
                        width: 100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        height: 50,
                                        width: 50,
                                        borderRadius: BorderRadius.circular(32),
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 16),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 8,
                                      width: 50,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        height: 50,
                                        width: 50,
                                        borderRadius: BorderRadius.circular(32),
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 16),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 8,
                                      width: 50,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        height: 50,
                                        width: 50,
                                        borderRadius: BorderRadius.circular(32),
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 16),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 8,
                                      width: 50,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        height: 50,
                                        width: 50,
                                        borderRadius: BorderRadius.circular(32),
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 16),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 8,
                                      width: 50,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        height: 50,
                                        width: 50,
                                        borderRadius: BorderRadius.circular(32),
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 16),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 8,
                                      width: 50,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        height: 50,
                                        width: 50,
                                        borderRadius: BorderRadius.circular(32),
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 16),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 8,
                                      width: 50,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        height: 50,
                                        width: 50,
                                        borderRadius: BorderRadius.circular(32),
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 16),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 8,
                                      width: 50,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        height: 50,
                                        width: 50,
                                        borderRadius: BorderRadius.circular(32),
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 16),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 8,
                                      width: 50,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                            ],
                          ),
                        )),
                    const SizedBox(height: 33),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 10,
                        width: 100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 32,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(0, 0, 0, 0.12))
                              ],
                              color: ColorSchemes.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 70,
                                      width: 70,
                                      borderRadius: BorderRadius.circular(32),
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 10,
                                      width: 100,
                                      borderRadius: BorderRadius.circular(32),
                                      shape: BoxShape.rectangle),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 10,
                                      width: 150,
                                      borderRadius: BorderRadius.circular(32),
                                      shape: BoxShape.rectangle),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 32,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(0, 0, 0, 0.12))
                              ],
                              color: ColorSchemes.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 70,
                                      width: 70,
                                      borderRadius: BorderRadius.circular(32),
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 10,
                                      width: 100,
                                      borderRadius: BorderRadius.circular(32),
                                      shape: BoxShape.rectangle),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 10,
                                      width: 150,
                                      borderRadius: BorderRadius.circular(32),
                                      shape: BoxShape.rectangle),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 32,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(0, 0, 0, 0.12))
                              ],
                              color: ColorSchemes.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 70,
                                      width: 70,
                                      borderRadius: BorderRadius.circular(32),
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 10,
                                      width: 100,
                                      borderRadius: BorderRadius.circular(32),
                                      shape: BoxShape.rectangle),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 10,
                                      width: 150,
                                      borderRadius: BorderRadius.circular(32),
                                      shape: BoxShape.rectangle),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: _pages.isEmpty
          ? Container(
              height: 20,
            )
          : Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: WillPopScope(
                onWillPop: () {
                  _onWillPop();
                  return Future.value(true);
                },
                child: BottomNavigationBar(
                  items: _navigationItems,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedItemColor: ColorSchemes.primary,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  unselectedItemColor: ColorSchemes.gray,
                  backgroundColor: ColorSchemes.white,
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: ColorSchemes.iconBackGround),
                  selectedLabelStyle: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: ColorSchemes.primary),
                  onTap: (index) => setState(() => _onItemTapped(index)),
                ),
              ),
            ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onWillPop() {
    showActionDialogWidget(
        context: context,
        text: S.of(context).areYouSureYouWantExitCityEye,
        icon: ImagePaths.warning,
        primaryText: S.of(context).no,
        secondaryText: S.of(context).yes,
        primaryAction: () {
          Navigator.pop(context);
        },
        secondaryAction: () {
          exit(0);
        });
  }

  BottomNavigationBarItem _item({
    required String label,
    required String iconSelected,
    required String iconUnSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(2),
        child: SvgPicture.asset(iconUnSelected),
      ),
      label: label,
      activeIcon: Padding(
        padding: const EdgeInsets.all(2),
        child: SvgPicture.asset(
          iconSelected,
          color: ColorSchemes.primary,
        ),
      ),
    );
  }

  void _notificationListener() {
    NotificationService.onNotificationClick.stream.listen((event) {
      _onNotificationClick(event);
    });
  }

  void _onNotificationClick(String? notificationData) async {
    FirebaseNotificationData firebaseNotificationData =
        mapNotification(notificationData);
    final userUnit = GetUserUnitUseCase(injector())();
    final user = GetUserInformationUseCase(injector())();

    bool isUnitExist = false;

    for (int i = 0; i < user.userUnits.length; i++) {
      if (user.userUnits[i].unitId == firebaseNotificationData.unitId) {
        isUnitExist = true;
        break;
      }
    }

    if (isUnitExist) {
      if (userUnit.unitId == firebaseNotificationData.unitId) {
        _checkNotificationStatus(firebaseNotificationData);
      } else {
        // ignore: await_only_futures
        final user = await GetUserInformationUseCase(injector()).call();
        for (int i = 0; i < user.userUnits.length; i++) {
          if (user.userUnits[i].unitId == firebaseNotificationData.unitId) {
            await SetSwitchLogoUseCase(injector())(
                user.userUnits[i].compoundLogo);
            await SetUserUnitUseCase(injector())(user.userUnits[i])
                .then((value) => {
                      _restartApp(value),
                    });
            break;
          }
        }
      }
    } else {
      NotificationService.onNotificationClick.add("");
      await SetRememberMeUseCase(injector())(false);
      await RemoveUserInformationUseCase(injector())();
      await RemoveUserUnitsUseCase(injector())().then((value) =>
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.splash, (route) => false));
    }
  }

  void _checkNotificationStatus(
      FirebaseNotificationData firebaseNotificationData) async {
    if (firebaseNotificationData.code == "general") {
      if (firebaseNotificationData.message.isNotEmpty) {
        _showMassageDialogWidget(
          firebaseNotificationData.message,
          ImagePaths.logo,
        );
      }
    } else if (firebaseNotificationData.code == "notificationDetails") {
      _navigateToNotificationDetailsScreen(firebaseNotificationData.id);
    } else if (firebaseNotificationData.code == "eventDetails") {
      _navigateToEventDetailsScreen(firebaseNotificationData.id);
    } else if (firebaseNotificationData.code == "surveys") {
      Navigator.pushNamed(context, Routes.surveys, arguments: {
        "id": firebaseNotificationData.id,
      });
    } else if (firebaseNotificationData.code == "qrDetails") {
      _navigateToQrDetailsScreen(firebaseNotificationData.id);
    } else if (firebaseNotificationData.code == "current_qrHistory") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to current or previous
      await SetQrCodeIndexUseCase(injector())(
          [firebaseNotificationData.id.toString(), "1", "0"]).then((value) {
        _navigateToQrHistory();
      });
    } else if (firebaseNotificationData.code == "previous_qrHistory") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to current or previous
      await SetQrCodeIndexUseCase(injector())(
          [firebaseNotificationData.id.toString(), "1", "1"]).then((value) {
        _navigateToQrHistory();
      });
    } else if (firebaseNotificationData.code == "open_support") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to open requests or all requests
      await SetSupportIndexUseCase(injector())(
              [firebaseNotificationData.id.toString(), "1", "open_support"])
          .then((value) {
        _selectedIndex = 1;
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    } else if (firebaseNotificationData.code == "all_support") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to open requests or all requests
      await SetSupportIndexUseCase(injector())(
              [firebaseNotificationData.id.toString(), "1", "all_support"])
          .then((value) {
        _selectedIndex = 1;
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    } else if (firebaseNotificationData.code == "support_completed") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to open requests or all requests
      await SetSupportIndexUseCase(injector())([
        firebaseNotificationData.id.toString(),
        "1",
        "support_completed"
      ]).then((value) {
        _selectedIndex = 1;
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    } else if (firebaseNotificationData.code == "wall") {
      await SetWallItemIdUseCase(injector())(firebaseNotificationData.id)
          .then((value) {
        _selectedIndex = 2;
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    } else if (firebaseNotificationData.code == "services") {
      await SetServicesIndexUseCase(injector())(firebaseNotificationData.id)
          .then((value) {
        _selectedIndex = 3;
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    } else if (firebaseNotificationData.code == "gallery") {
      Navigator.pushNamed(context, Routes.gallery);
    } else if (firebaseNotificationData.code == "paymentDetails") {
      Navigator.pushNamed(context, Routes.paymentDetails, arguments: {
        "paymentId": firebaseNotificationData.id,
      });
    } else if (firebaseNotificationData.code == "events") {
      Navigator.pushNamed(context, Routes.events, arguments: {
        "id": firebaseNotificationData.id,
      });
    } else if (firebaseNotificationData.code == "notifications") {
      Navigator.pushNamed(context, Routes.notifications, arguments: {
        "id": firebaseNotificationData.id,
      });
    } else if (firebaseNotificationData.code == "familymember") {
      Navigator.pushNamed(context, Routes.profile, arguments: {
        "index": 4,
        "scrollToId": firebaseNotificationData.id,
      });
    } else if (firebaseNotificationData.code == "support_comments") {
      Navigator.pushNamed(context, Routes.commentScreen, arguments: {
        'order': const Orders(),
        "id": firebaseNotificationData.id,
      });
    } else if (firebaseNotificationData.code == "UnitContract") {
      Navigator.pushNamed(context, Routes.profile, arguments: {
        "index": 3,
        "scrollToId": firebaseNotificationData.id,
      });
    }

    NotificationService.onNotificationClick.add("");
    setState(() {});
  }

  FirebaseNotificationData mapNotification(String? notificationData) {
    Map<String, dynamic> mapDate = json.decode(notificationData!);
    FirebaseNotificationData model = FirebaseNotificationData.fromJson(mapDate);

    return model;
  }

  Future<void> _navigateToNotificationDetailsScreen(int id) async {
    Navigator.pushNamed(context, Routes.notificationsDetailsScreen, arguments: {
      "isPushedNotification": true,
      "details": const NotificationItem(),
      "id": id,
    });
  }

  Future<void> _navigateToEventDetailsScreen(int id) async {
    await Navigator.pushNamed(context, Routes.eventDetails, arguments: {
      "eventId": id,
    });
  }

  Future<void> _navigateToQrDetailsScreen(int id) async {
    await Navigator.pushNamed(context, Routes.qrDetailsScreen, arguments: {
      "qrId": id,
    });
  }

  void _navigateToQrHistory() async {
    await Navigator.pushNamed(context, Routes.qr);
  }

  void _showMassageDialogWidget(
    String text,
    String icon,
  ) {
    showMassageDialogWidget(
      context: context,
      text: text,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  _restartApp(bool value) async {
    if (value) {
      (await SharedPreferences.getInstance())
          .setBool(SharedPreferenceKeys.isRestart, true);
      if (mounted) RestartWidget.restartApp(context);
    }
  }
}
