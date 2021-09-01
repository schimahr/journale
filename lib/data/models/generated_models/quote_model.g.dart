// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteModel _$QuoteModelFromJson(Map<String, dynamic> json) {
  return QuoteModel(
    json['id'] as String,
    json['author'] as String,
    json['text'] as String,
  );
}

Map<String, dynamic> _$QuoteModelToJson(QuoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'text': instance.text,
    };
