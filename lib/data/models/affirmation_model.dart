class AffirmationModel {
  final String affirmation;

  AffirmationModel({required this.affirmation});
  factory AffirmationModel.fromJson(Map<String, dynamic> json) {
    return AffirmationModel(affirmation: json['affirmation']);
  }
}
