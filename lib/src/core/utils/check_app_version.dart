import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/usecase/get_current_country_code_use_case.dart';
import 'package:flutter/material.dart';
import 'package:version_check/version_check.dart';
import 'dart:math' as math;

Future<void> checkVersion(BuildContext context) async {
  await versionCheck.checkVersion(context);
}

final versionCheck = VersionCheck(
  packageName: F.isNiceTouch
      ? 'com.sprinteye.cityeye.nicetouch'
      : 'com.sprinteye.cityeye.app',
  showUpdateDialog: CheckAppVersion.customShowUpdateDialog,
  country: GetCurrentCountryCodeUseCase(injector())(),
);

class CheckAppVersion {
  static void customShowUpdateDialog(
      BuildContext context, VersionCheck versionCheck) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'NEW Update Available',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorSchemes.primary,
                ),
          ),
          content: WillPopScope(
              onWillPop: () async => Future.value(false),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You must update the app to version ${versionCheck.storeVersion}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black,
                          ),
                    ),
                    Text(
                      '(current version ${versionCheck.packageVersion})',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black,
                          ),
                    ),
                    Text(
                      '(Minimum version ${getMinVersion(versionCheck.storeVersion!)})',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black,
                          ),
                    ),
                  ],
                ),
              )),
          actions: [
            Visibility(
              visible: checkForceUpdate(
                versionCheck.packageVersion!,
                getMinVersion(versionCheck.storeVersion!),
              ),
              child: TextButton(
                child: Text(
                  "Later",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorSchemes.gray,
                      ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            TextButton(
              child: Text(
                S.of(context).updateNow,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorSchemes.primary,
                    ),
              ),
              onPressed: () async {
                await versionCheck.launchStore();
              },
            ),
          ],
        );
      },
    );
  }

  static bool checkForceUpdate(String packageVersion, String minVersion) {
    final currentVersion = packageVersion.split('.');
    final minVersion0 = minVersion.split('.');

    for (int i = 0;
        i < math.min(currentVersion.length, minVersion0.length);
        i++) {
      final int? v1 = int.tryParse(currentVersion[i]);
      final int? v2 = int.tryParse(minVersion0[i]);

      if (v1 == null || v2 == null) {
        if (minVersion0[i].compareTo(currentVersion[i]) > 0) {
          return true;
        } else if (minVersion0[i].compareTo(currentVersion[i]) < 0) {
          return false;
        }
      } else if (v2 < v1) {
        return true;
      } else if (v2 > v1) {
        return false;
      }
    }

    if (minVersion0.length < currentVersion.length) return true;

    return true;
  }

  static String getMinVersion(String storeVersion) {
    final storeVersion0 = storeVersion.split('.').map(int.parse).toList();

    while (storeVersion0.length < 3) {
      storeVersion0.add(0);
    }

    storeVersion0[storeVersion0.length - 1] -= 2;

    for (int i = storeVersion0.length - 1; i > 0; i--) {
      if (storeVersion0[i] < 0) {
        storeVersion0[i] += 10;
        storeVersion0[i - 1] -= 1;
      }
    }

    final minVersion = storeVersion0.join('.');

    return minVersion;
  }
}
