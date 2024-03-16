import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history_with_questions_answer.dart';
import 'package:city_eye/src/presentation/blocs/qr_details/qr_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/qr_details_screen/skeleton/skeleton_qr_details.dart';
import 'package:city_eye/src/presentation/screens/qr_details_screen/widgets/qr_details_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class QrDetailsScreen extends BaseStatefulWidget {
  final int qrId;

  const QrDetailsScreen({super.key, required this.qrId});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _BarcodeSuccessScreenState();
}

class _BarcodeSuccessScreenState extends BaseState<QrDetailsScreen> {
  QrDetailsBloc get _bloc => BlocProvider.of<QrDetailsBloc>(context);

  QrHistoryWithQuestionAnswer _qrDetailsData =
      const QrHistoryWithQuestionAnswer();

  @override
  void initState() {
    _bloc.add(GetQrDetailsDataEvent(qrId: widget.qrId));
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBarWidget(
          context,
          title: S.of(context).details,
          isHaveBackButton: true,
          onBackButtonPressed: () {
            _bloc.add(QrDetailsBackEvent());
          },
          actionWidget: GestureDetector(
            onTap: () {
              _bloc.add(QrDetailsShareQrEvent());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(ImagePaths.shareBlack),
            ),
          ),
        ),
        body: BlocConsumer<QrDetailsBloc, QrDetailsState>(
          listener: (context, state) {
            if (state is QrDetailsBackState) {
              Navigator.pop(context);
            } else if (state is SuccessGetQrDetailsDataState) {
              _qrDetailsData = state.qrDetails;
            } else if (state is QrDetailsShareQrState) {
              _onShareClicked();
            } else if (state is QrDetailsDownloadQrState) {
              if (_qrDetailsData.pdfUrl.isEmpty) {
                showMassageDialogWidget(
                  context: context,
                  text: S.of(context).notValidPdfUrlToDownloadIt,
                  icon: ImagePaths.error,
                  buttonText: S.of(context).ok,
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
              } else {
                _requestStoragePermission(_qrDetailsData.pdfUrl);
              }
            } else if (state is ErrorGetQrDetailsDataState) {
              showMassageDialogWidget(
                context: context,
                text: state.errorMessage,
                icon: ImagePaths.error,
                buttonText: S.of(context).ok,
                onTap: () {
                  Navigator.pop(context);
                },
              );
            }
          },
          builder: (context, state) {
            return state is QrDetailsShowSkeletonState
                ? const SkeletonQrDetails()
                : QrDetailsWidget(
                    qrDetails: _qrDetailsData,
                    onTapDownload: () {
                      _bloc.add(QrDetailsDownloadQrEvent());
                    },
                  );
          },
        ),
      ),
    );
  }

  bool isDebouncing = false;

  void _onShareClicked() async {
    if (!isDebouncing) {
      setState(() {
        isDebouncing = true;
      });

      await shareImage(_qrDetailsData.imageUrl);

      Timer(const Duration(seconds: 1), () {
        setState(() {
          isDebouncing = false;
        });
      });
    }
  }

  Future<void> shareImage(String imageUrl) async {
    try {
      // Fetch the image bytes from the network
      http.Response response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Uint8List imageBytes = response.bodyBytes;

        // Save the image to a temporary file
        Directory tempDir;
        if (Platform.isIOS) {
          tempDir = await getApplicationDocumentsDirectory();
        } else {
          tempDir = await getTemporaryDirectory();
        }
        File tempFile = File('${tempDir.path}/image.png');
        await tempFile.writeAsBytes(imageBytes);

        // Use the share function to share the image
        await Share.shareXFiles([XFile(tempFile.path)], text: imageUrl);
      } else {
        showMassageDialogWidget(
            context: context,
            text: S.of(context).failedToShareImage,
            icon: ImagePaths.error,
            buttonText: S.of(context).ok,
            onTap: () {
              Navigator.pop(context);
            });
      }
    } catch (e) {
      showMassageDialogWidget(
          context: context,
          text: S.of(context).failedToShareImage,
          icon: ImagePaths.error,
          buttonText: S.of(context).ok,
          onTap: () {
            Navigator.pop(context);
          });
      // Handle the error as needed
    }
  }

  void _onDownloadQrClicked(String file) async {
    bool downloadSuccess = true;
    Directory? dir;
    showSnackBar(
      context: context,
      message: S.of(context).downloading,
      color: ColorSchemes.snackBarInfo,
      icon: ImagePaths.info,
    );

    if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = await DownloadsPathProvider.downloadsDirectory;
    }
    if (dir != null) {
      try {
        await Dio().download(
          file,
          "${dir.path}/${file.split("/").last ?? ""}",
          onReceiveProgress: (received, total) {},
        );
      } on DioError catch (e) {
        downloadSuccess = false;
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showSnackBar(
          context: context,
          message: S.current.failedToDownloadTheQrCodePleaseTryAgain,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      }
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (downloadSuccess) {
        showSnackBar(
          context: context,
          message: S.current.theQrCodeHasBeenDownloadedSuccessfully,
          color: ColorSchemes.snackBarSuccess,
          icon: ImagePaths.success,
        );
      } else {
        showSnackBar(
          context: context,
          message: S.current.failedToDownloadTheQrCodePleaseTryAgain,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      }
    }
  }

  Future<void> _requestStoragePermission(String pdfUrl) async {
    Permission permission = Permission.storage;
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final androidInfo = await deviceInfoPlugin.androidInfo;
      permission = androidInfo.version.sdkInt >= 33
          ? Permission.mediaLibrary
          : Permission.storage;
    } else {
      permission = Permission.storage;
    }
    PermissionStatus status = await permission.request();

    if (status.isGranted) {
      _onDownloadQrClicked(pdfUrl);
    } else {
      // Permission denied by the user
      bool storagePermission = await PermissionServiceHandler()
          .handleServicePermission(setting: permission);
      if (storagePermission) {
        _onDownloadQrClicked(pdfUrl);
      } else {
        _showActionDialog(
          icon: ImagePaths.warning,
          onPrimaryAction: () async {
            Navigator.pop(context);
            openAppSettings().then((value) {
              _requestStoragePermission(pdfUrl);
            });
          },
          onSecondaryAction: () {
            Navigator.pop(context);
          },
          primaryText: !context.mounted ? "" : S.of(context).ok,
          secondaryText: !context.mounted ? "" : S.of(context).cancel,
          text: !context.mounted
              ? ""
              : S.of(context).youShouldHaveStoragePermission,
        );
      }
    }
  }

  void _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    showActionDialogWidget(
      context: context,
      text: text,
      primaryText: primaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryText: secondaryText,
      secondaryAction: () {
        onSecondaryAction();
      },
      icon: icon,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
