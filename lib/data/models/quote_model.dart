import 'package:json_annotation/json_annotation.dart';

part 'generated_models/quote_model.g.dart';

@JsonSerializable()
class QuoteModel {
  final String id;
  final String author;
  final String text;
  QuoteModel(this.id, this.author, this.text);

  factory QuoteModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteModelToJson(this);

  @override
  String toString() => 'quoteAuthor: $author, quoteText: $text';
}
