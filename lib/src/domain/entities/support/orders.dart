import 'package:city_eye/src/domain/entities/support/category.dart';
import 'package:city_eye/src/domain/entities/support/status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Orders extends Equatable {
  final int id;
  final String date;
  final String time;
  final bool isRating;
  final int ratingValue;
  final String ratingComment;
  final Category category;
  final List<Status> statusList;
  final int paymentId;
  final GlobalKey? key;

  const Orders({
    this.id = 0,
    this.date = "",
    this.time = "",
    this.isRating = false,
    this.ratingValue = 0,
    this.ratingComment = "",
    this.category = const Category(),
    this.statusList = const [],
    this.paymentId = 0,
    this.key,
  });

  Orders copyWith({
    int? id,
    String? date,
    String? time,
    bool? isRating,
    int? ratingValue,
    String? ratingComment,
    Category? category,
    List<Status>? statusList,
    int? paymentId,
    GlobalKey? key,
  }) {
    return Orders(
      id: id ?? this.id,
      date: date ?? this.date,
      time: time ?? this.time,
      isRating: isRating ?? this.isRating,
      ratingValue: ratingValue ?? this.ratingValue,
      ratingComment: ratingComment ?? this.ratingComment,
      category: category ?? this.category,
      statusList: statusList ?? this.statusList,
      paymentId: paymentId ?? this.paymentId,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        time,
        isRating,
        ratingValue,
        ratingComment,
        category,
        statusList,
        paymentId,
      ];
}
