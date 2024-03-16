import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/staff/staff.dart';
import 'package:city_eye/src/presentation/blocs/staff/staff_bloc.dart';
import 'package:city_eye/src/presentation/screens/staff/skeleton/staff_skeleton_screen.dart';
import 'package:city_eye/src/presentation/screens/staff/widgets/staff_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffScreen extends BaseStatefulWidget {
  const StaffScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _StuffScreenState();
}

class _StuffScreenState extends BaseState<StaffScreen> {
  StaffBloc get _bloc => BlocProvider.of<StaffBloc>(context);
  List<Staff> _staffs = [];

  @override
  void initState() {
    _bloc.add(GetStaffEvent());
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<StaffBloc, StaffState>(listener: (context, state) {
      if (state is GetStaffLoadingState) {
      } else if (state is GetStaffSuccessState) {
        _onStuffSuccessState(
          staffs: state.staff,
        );
      } else if (state is GetStaffErrorState) {
        _onStuffErrorState(
          errorMessage: state.errorMessage,
        );
      } else if (state is OpenStaffPhoneNumberState) {
        _onOpenStuffPhoneNumberState(
          phoneNumber: state.phoneNumber,
          context: context,
        );
      } else if (state is NavigationPopState) {
        _onNavigationPopState();
      }
    }, builder: (context, state) {
      if (state is GetStaffLoadingState) {
        return const StaffSkeletonScreen();
      }
      return _buildScreen();
    });
  }

  Widget _buildScreen() {
    return StaffContentWidget(
      onBackButtonPressed: () {
        _bloc.add(NavigationPopEvent());
      },
      stuff: _staffs,
      onTapPhoneNumber: ({
        required String phoneNumber,
      }) {
        _bloc.add(OpenStuffPhoneNumberEvent(
          phoneNumber: phoneNumber,
        ));
      },
      onTapStuffImage: (image) {
        _onTapStuffImage(image);
      },
      onPullToRefresh: () {
        _handleRefresh();
      },
    );
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetStaffEvent());
  }

  void _onStuffSuccessState({
    required List<Staff> staffs,
  }) {
    _staffs = staffs;
  }

  void _onStuffErrorState({
    required String errorMessage,
  }) {
    showMassageDialogWidget(
      context: context,
      text: errorMessage,
      icon: ImagePaths.error,
      buttonText: S.of(context).ok,
      onTap: () {
        _bloc.add(NavigationPopEvent());
      },
    );
  }

  void _onOpenStuffPhoneNumberState({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorSchemes.primary,
          content: Text(
            S.of(context).errorLaunchingPhoneDialer,
          ),
        ),
      );
      return;
    }
    try {
      await launchUrl(Uri.parse("tel://$phoneNumber"));
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

  void _onNavigationPopState() {
    Navigator.pop(context);
  }

  void _onTapStuffImage(String image) {
    Navigator.pushNamed(context, Routes.galleryImages,
        arguments: GalleryImages(initialIndex: 0, images: [
          GalleryAttachment(attachment: image),
        ]));
  }
}
