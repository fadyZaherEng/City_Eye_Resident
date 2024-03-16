import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:city_eye/src/presentation/blocs/delegated/delegated_bloc.dart';
import 'package:city_eye/src/presentation/screens/delegated/skeleton/delegated_skeleton.dart';
import 'package:city_eye/src/presentation/screens/delegated/widgets/delegates_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DelegatedScreen extends BaseStatefulWidget {
  final bool isSubmitDelegation;

  const DelegatedScreen({
    this.isSubmitDelegation = true,
    super.key,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _DelegatedScreenState();
}

class _DelegatedScreenState extends BaseState<DelegatedScreen> {
  DelegatedBloc get _bloc => BlocProvider.of<DelegatedBloc>(context);
  List<Delegated> _delegates = [];

  final Delegated emptyDelegated = const Delegated();

  @override
  void initState() {
    super.initState();

    _bloc.add(GetDelegatedDataEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<DelegatedBloc, DelegatedState>(
        listener: (context, state) {
      if (state is ShowLoadingState) {
        showLoading();
      } else if (state is HideLoadingState) {
        hideLoading();
      } else if (state is GetDelegatedDataSuccessState) {
        _delegates = state.delegatedList;
        _bloc.isReloadList = false;
      } else if (state is GetDelegatedDataErrorState) {
        showSnackBar(
          context: context,
          message: state.errorMessage,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      } else if (state is BackDelegatedState) {
        Navigator.pop(context);
      } else if (state is AddDelegatedState) {
        Navigator.pushNamed(context, Routes.delegatedStepsScreen, arguments: {
          "isEdit": false,
          "delegatedData": emptyDelegated,
        }).then((value) => {
              if (_bloc.isReloadList) _bloc.add(GetDelegatedDataEvent()),
            });
      } else if (state is DeactivateSuccessState) {
        hideLoading();
        // _delegates.remove(state.delegated);
        showSnackBar(
          context: context,
          message: state.message,
          color: ColorSchemes.snackBarSuccess,
          icon: ImagePaths.success,
        );
      } else if (state is DeactivateErrorState) {
        showSnackBar(
          context: context,
          message: state.errorMessage,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      } else if (state is EditDelegatedState) {
        Navigator.pushNamed(context, Routes.delegatedStepsScreen, arguments: {
          "isEdit": true,
          "delegatedData": state.delegated.deepClone(),
        }).then((value) => {
              if (_bloc.isReloadList) _bloc.add(GetDelegatedDataEvent()),
            });
      } else if (state is DelegatedCallPhoneNumberState) {
        _onCallPhoneNumberState(delegated: state.delegated);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: _buildAppBar(),
        floatingActionButton: _floatingActionButton(),
        body: state is ShowSkeletonState
            ? const DelegatedSkeleton()
            : DelegatesWidget(
                delegates: _delegates,
                deactivateAction: (Delegated delegated) {
                  _showActionDialogWidget(
                      icon: ImagePaths.warning,
                      text: delegated.isEnabled
                          ? S
                              .of(context)
                              .areYouSureYouWantToDeactivateThisDelegation
                          : S
                              .of(context)
                              .areYouSureYouWantToActivateTheDelegation,
                      primaryText: S.of(context).no,
                      secondaryText: S.of(context).yes,
                      onPrimaryAction: () {
                        Navigator.pop(context);
                      },
                      onSecondaryAction: () {
                        _onDeActivateAction(delegated);
                        Navigator.pop(context);
                      });
                },
                phoneNumberAction: (Delegated delegated) {
                  _bloc.add(DelegatedCallPhoneNumberEvent(
                    delegated: delegated,
                  ));
                },
                editAction: (Delegated delegated) {
                  if (delegated.isEnabled) {
                    _bloc.add(EditDelegatedEvent(
                      delegated: delegated,
                    ));
                  } else {
                    showSnackBar(
                      context: context,
                      message: S
                          .of(context)
                          .youCannotEditTheDelegationBecauseItIsDeactivated,
                      color: ColorSchemes.snackBarInfo,
                      icon: ImagePaths.info,
                    );
                  }
                },
                onScanQRDelegation: (Delegated delegated) {
                  // Navigator.pushNamed(context, Routes.webContent, arguments: {
                  //   "screenTitle": S.of(context).delegated,
                  //   "content": delegated.documentDelegation,
                  //   "isLink": true,
                  //   "isPdf": true,
                  // });
                  Navigator.pushNamed(context, Routes.pdfScreen, arguments: {
                    "screenTitle": S.of(context).delegated,
                    "link": delegated.documentDelegation,
                  });
                },
                onPullToRefresh: () {
                  _handleRefresh();
                },
              ),
      );
    });
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetDelegatedDataEvent());
  }

  AppBar _buildAppBar() {
    return buildAppBarWidget(context,
        title: S.of(context).delegated,
        isHaveBackButton: true,
        onBackButtonPressed: () => _bloc.add(BackDelegatedEvent()));
  }

  void _onCallPhoneNumberState({
    required Delegated delegated,
  }) async {
    if (delegated.authMobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorSchemes.primary,
          content: Text(
            S.of(context).errorLaunchingPhoneDialer,
          ),
        ),
      );
      return;
    } else {
      try {
        await launchUrl(Uri.parse("tel://${delegated.authMobile}"));
      } on PlatformException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorSchemes.primary,
            content: Text(
              e.message.toString(),
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).errorLaunchingPhoneDialer,
            ),
          ),
        );
      }
    }
  }

  void _showActionDialogWidget({
    required String text,
    required String icon,
    required String primaryText,
    required String secondaryText,
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
  }) {
    showActionDialogWidget(
      context: context,
      icon: icon,
      text: text,
      primaryText: primaryText,
      secondaryText: secondaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryAction: () {
        onSecondaryAction();
      },
    );
  }

  void _onDeActivateAction(Delegated delegated) async {
    showLoading();
    _bloc.add(DeactivateEvent(
      delegated: delegated,
      delegations: _delegates,
    ));
  }

  Widget _floatingActionButton() {
    return InkWell(
      onTap: () => _bloc.add(AddDelegatedEvent()),
      child: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsetsDirectional.only(end: 16, bottom: 16),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorSchemes.black,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 32,
              spreadRadius: 0,
              color: Color.fromRGBO(0, 0, 0, 0.12),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: SvgPicture.asset(
            ImagePaths.add,
            fit: BoxFit.contain,
            color: ColorSchemes.white,
          ),
        ),
      ),
    );
  }
}
