import 'dart:async';

import 'package:city_eye/src/core/utils/show_no_internet_dialog_widget.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/usecase/get_no_internet_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_no_internet_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:city_eye/src/core/base/manager/loading/loading_manager.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  final Color materialColor;

  const BaseStatefulWidget({
    Key? key,
    this.materialColor = Colors.white,
  }) : super(key: key);

  @override
  BaseState createState() {
    return baseCreateState();
  }

  BaseState baseCreateState();
}

abstract class BaseState<W extends BaseStatefulWidget> extends State<W>
    with LoadingManager {
  // late StreamSubscription<ConnectivityResult> subscription;
  @override
  Widget build(BuildContext context) {
    return baseWidget();
  }

  @override
  void initState() {
    super.initState();
    // subscription = Connectivity().onConnectivityChanged.listen((connectivityResult) {
    //   print("Hassan $connectivityResult");
    //   _updateConnectionStatus(connectivityResult);
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget baseWidget() {
    return Material(
      color: widget.materialColor,
      child: Stack(
        fit: StackFit.expand,
        children: [baseBuild(context), loadingManagerWidget()],
      )
    );
  }

  void changeState() {
    setState(() {});
  }

  @override
  void runChangeState() {
    changeState();
  }

  Widget baseBuild(BuildContext context);

  // void _updateConnectionStatus(ConnectivityResult status)  {
  //   if (status == ConnectivityResult.none &&
  //       !GetNoInternetUseCase(injector())()) {
  //     SetNoInternetUseCase(injector())(true);
  //     showNoInternetDialogWidget(
  //       context: context,
  //       onTapTryAgain: () {
  //         if (status != ConnectivityResult.none) {
  //           SetNoInternetUseCase(injector())(false);
  //           Navigator.pop(context);
  //         }
  //       },
  //     );
  //   }  if (status != ConnectivityResult.none &&
  //       GetNoInternetUseCase(injector())()) {
  //     SetNoInternetUseCase(injector())(false);
  //     Navigator.pop(context);
  //   }
  //   setState(() {});
  // }
}
