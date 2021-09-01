import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journalio/data/models/affirmation_model.dart';
import 'package:journalio/data/models/quote_model.dart';
import 'package:journalio/data/repositories/quote_repository.dart';
import 'package:journalio/services/affirmations_service.dart';

class HomeViewModel extends ChangeNotifier {
  late QuoteModel _randomQuote;
  late Future<AffirmationModel> _randomAffirmation;

  int currentIndex = 0;

  HomeViewModel() {
    _randomQuote = getRandomQuote();
    _randomAffirmation = getRandomAffirmation();
  }

  Future<AffirmationModel> getRandomAffirmation() {
    return AffirmationService.getAffirmation();
  }

  void getNewAffirmation() {
    _randomAffirmation = getRandomAffirmation();
  }

  QuoteModel getRandomQuote() {
    int quoteRepLen = QuoteRepository.quotes.length - 1;
    return QuoteRepository.quotes[Random().nextInt(quoteRepLen)];
  }

  void initRandomQuote() {
    _randomQuote = getRandomQuote();
    notifyListeners();
  }

  bool isFav = false;

  void changeFavStatus() {
    isFav = !isFav;
    notifyListeners();
  }

  QuoteModel get randomQuote => _randomQuote;

  set randomQuote(QuoteModel quote) {
    _randomQuote = quote;
    notifyListeners();
  }

  Future<AffirmationModel> get randomAffirmation => _randomAffirmation;

  String get randomQuoteText => _randomQuote.text;
  String get randomQuoteAuthor => _randomQuote.author;
}
