// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../journal_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalEntryModel _$JournalEntryModelFromJson(Map<String, dynamic> json) {
  return JournalEntryModel(
    id: json['id'] as String,
    userID: json['userID'] as String,
    title: json['title'] as String,
    text: json['text'] as String,
    favourite: json['favourite'] as bool,
    created: json['created'] as int,
  );
}

Map<String, dynamic> _$JournalEntryModelToJson(JournalEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'title': instance.title,
      'text': instance.text,
      'favourite': instance.favourite,
      'created': instance.created,
    };
