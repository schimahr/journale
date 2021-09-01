import 'package:flutter/foundation.dart';
import 'package:journalio/data/models/quote_model.dart';
import 'package:journalio/data/repositories/quote_repository.dart';

class QuotesViewModel extends ChangeNotifier {
  late List<QuoteModel> quotes;

  QuotesViewModel() {
    quotes = QuoteRepository.quotes;
  }

  Stream<List<QuoteModel>> geFavouriteQuotesStream(String user) {
    return QuoteRepository.getFavouriteQuotesForUser(user);
  }

  void addToFavourites(String user, QuoteModel quote) {
    QuoteRepository.addFavouriteQuote(user, quote);
  }

  void removeFromFavourites(String user, QuoteModel quote) {
    QuoteRepository.removeFavouriteQuote(user, quote);
  }
}
