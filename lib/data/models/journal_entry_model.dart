import 'package:json_annotation/json_annotation.dart';

part 'generated_models/journal_entry_model.g.dart';

@JsonSerializable()
class JournalEntryModel {
  final String id;
  final String userID;
  final String title;
  final String text;
  final bool favourite;
  final int created;

  JournalEntryModel(
      {required this.id,
      required this.userID,
      required this.title,
      required this.text,
      required this.favourite,
      required this.created});
  factory JournalEntryModel.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryModelFromJson(json);
  Map<String, dynamic> toJson() => _$JournalEntryModelToJson(this);
}
