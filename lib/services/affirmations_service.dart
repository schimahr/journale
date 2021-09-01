import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journalio/data/models/affirmation_model.dart';

class AffirmationService {
  static Future<AffirmationModel> getAffirmation() async {
    final url = "https://www.affirmations.dev/";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return AffirmationModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to get affirmation.');
    }
  }
}
