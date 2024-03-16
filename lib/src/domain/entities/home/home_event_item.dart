import 'package:city_eye/src/domain/entities/home/event_rules.dart';
import 'package:city_eye/src/domain/entities/home/events_attachments.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class HomeEventItem extends Equatable {
  final int id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String openingDate;
  final String closedDate;
  final bool isPaid;
  final int maxCountJoin;
  final int memberCount;
  final int memberPrice;
  final String locationAddress;
  final String locationLatitude;
  final String locationLongitude;
  final int transactionId;
  final String calenderRef;
  final List<HomeEventOption> eventsOptions;
  final List<EventRules> eventsRules;
  final List<EventAttachments> eventsAttachments;
  final HomeEventOption selectAction;
  final bool showTotalMembers;
  final GlobalKey? key;

  const HomeEventItem({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.startDate = "",
    this.endDate = "",
    this.openingDate = "",
    this.closedDate = "",
    this.selectAction = const HomeEventOption(),
    this.isPaid = false,
    this.maxCountJoin = 0,
    this.memberCount = 0,
    this.memberPrice = 0,
    this.transactionId = 0,
    this.locationAddress = "",
    this.locationLatitude = "",
    this.locationLongitude = "",
    this.calenderRef = "",
    this.eventsOptions = const [],
    this.eventsRules = const [],
    this.eventsAttachments = const [],
    this.showTotalMembers = true,
    this.key,
  });

  HomeEventItem copyWith({
    int? id,
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    String? openingDate,
    String? closedDate,
    bool? isPaid,
    int? memberCount,
    int? maxCountJoin,
    int? memberPrice,
    int? transactionId,
    String? locationAddress,
    String? locationLatitude,
    String? locationLongitude,
    String? calenderRef,
    List<HomeEventOption>? eventsOptions,
    List<EventRules>? eventsRules,
    List<EventAttachments>? eventsAttachments,
    HomeEventOption? selectAction,
    bool? showTotalMembers,
    GlobalKey? key,
  }) {
    return HomeEventItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      openingDate: openingDate ?? this.openingDate,
      closedDate: closedDate ?? this.closedDate,
      isPaid: isPaid ?? this.isPaid,
      transactionId: transactionId ?? this.transactionId,
      memberCount: memberCount ?? this.memberCount,
      maxCountJoin: maxCountJoin ?? this.maxCountJoin,
      memberPrice: memberPrice ?? this.memberPrice,
      locationAddress: locationAddress ?? this.locationAddress,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      calenderRef: calenderRef ?? this.calenderRef,
      eventsOptions: eventsOptions ?? this.eventsOptions,
      eventsRules: eventsRules ?? this.eventsRules,
      eventsAttachments: eventsAttachments ?? this.eventsAttachments,
      selectAction: selectAction ?? this.selectAction,
      showTotalMembers: showTotalMembers ?? this.showTotalMembers,
      key: key ?? this.key,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        startDate,
        endDate,
        openingDate,
        closedDate,
        isPaid,
        memberCount,
        memberPrice,
        locationAddress,
        locationLatitude,
        locationLongitude,
        calenderRef,
        eventsOptions,
        transactionId,
        eventsRules,
        eventsAttachments,
        showTotalMembers,
      ];
}
