import 'package:city_eye/src/domain/entities/wall/wall_attachment.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Wall extends Equatable {
  final int id;
  final String title;
  final String description;
  final String wallDate;
  final String createdBy;
  final String mainImage;
  final List<WallAttachment> wallAttachments;
  final GlobalKey? key;

  const Wall({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.wallDate = "",
    this.createdBy = "",
    this.mainImage = "",
    this.wallAttachments = const [],
    this.key,
  });

  Wall copyWith({
    int? id,
    String? title,
    String? description,
    String? wallDate,
    String? createdBy,
    String? mainImage,
    List<WallAttachment>? wallAttachments,
    GlobalKey? key,
  }) {
    return Wall(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      wallDate: wallDate ?? this.wallDate,
      createdBy: createdBy ?? this.createdBy,
      mainImage: mainImage ?? this.mainImage,
      wallAttachments: wallAttachments ?? this.wallAttachments,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, wallDate, createdBy, mainImage, wallAttachments];
}
