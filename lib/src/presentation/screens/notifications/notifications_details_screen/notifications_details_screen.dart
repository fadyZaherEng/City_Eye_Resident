import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/presentation/blocs/notifications/notification_details/notification_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/gallery_screen/widgets/gallery_image_widget.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_details_screen/skeleton/skeleton_notifications_details_screen.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class NotificationDetailsScreen extends StatefulWidget {
  final bool isPushedNotification;
  final int id;
  final NotificationItem notificationDetails;

  const NotificationDetailsScreen({
    this.isPushedNotification = false,
    this.id = -1,
    required this.notificationDetails,
    super.key,
  });

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  NotificationDetailsBloc get _bloc =>
      BlocProvider.of<NotificationDetailsBloc>(context);

  NotificationItem _notificationItem = const NotificationItem();

  @override
  void initState() {
    if (!widget.isPushedNotification) {
      _getLocalNotificationDetailsDataEvent(widget.notificationDetails);
    } else {
      _getRemoteNotificationDetailsDataEvent();
    }
    super.initState();
  }

  Future<void> _getRemoteNotificationDetailsDataEvent() async {
    _bloc.add(GetRemoteNotificationDetailsDataEvent(id: widget.id));
  }

  Future<void> _getLocalNotificationDetailsDataEvent(
      NotificationItem notificationItem) async {
    _bloc.add(SetLocalNotificationDetailsDataEvent(
        localNotificationDetails: notificationItem));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(context,
          title: S.of(context).notificationDetails,
          isHaveBackButton: true, onBackButtonPressed: () {
        _bloc.add(BackEvent());
      }),
      body: BlocConsumer<NotificationDetailsBloc, NotificationDetailsState>(
        listener: (context, state) {
          if (state is BackState) {
            _backDestination();
          } else if (state is ShowSkeletonState) {
          } else if (state is SuccessGetNotificationDetailsDataState) {
            _notificationItem = state.notificationItem;
          } else if (state is FailedNotificationDetailsDataState) {
            _showMessageDialog(
              errorMessage: state.errorMessage,
            );
          } else if (state is SetLocalNotificationDetailsDataState) {
            _notificationItem = state.localNotificationItem;
          }
        },
        builder: (context, state) {
          return state is ShowSkeletonState
              ? const SkeletonNotificationDetailsScreen()
              : Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          widget.notificationDetails.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: ColorSchemes.black,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        englishNumbers(convertTimestampToDateFormat(
                            widget.notificationDetails.createDate)),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.primary,
                              fontSize: 12,
                            ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: widget
                                  .notificationDetails.attachment.isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 12),
                                child: SizedBox(
                                  height: 160,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: GalleryImageWidget(
                                      image:
                                          widget.notificationDetails.attachment,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                widget.notificationDetails.body,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: ColorSchemes.gray,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  void _backDestination() {
    if (widget.isPushedNotification) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false,
          arguments: {
            "selectIndex": 0,
          });
    } else {
      Navigator.pop(context);
    }
  }

  void _showMessageDialog({
    required String errorMessage,
  }) {
    showMassageDialogWidget(
      context: context,
      text: errorMessage,
      icon: ImagePaths.error,
      buttonText: S.of(context).ok,
      onTap: () {
        Navigator.pop(context);
        _bloc.add(BackEvent());
      },
    );
  }
}
