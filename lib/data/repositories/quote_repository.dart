import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journalio/data/models/quote_model.dart';

class QuoteRepository {
  static List<QuoteModel> quotes = [
    QuoteModel('Y7SCt1jucW', 'Abraham Lincoln',
        'A house divided against itself cannot stand.'),
    QuoteModel('ysQyzFwfym', 'Byron Pulsifer',
        'Fate is in your hands and no one elses.'),
    QuoteModel('HXC8GZgybY', 'Carl Sandburg',
        'Nothing happens unless first we dream.'),
    QuoteModel('FCS4mhH69h', 'Yogi Berra',
        'Life is a learning experience, only if you learn.'),
    QuoteModel('XqK4yAYO1O', 'Confucius',
        'Study the past, if you would divine the future.'),
    QuoteModel('mSqHW1EqwR', 'Sigmund Freud',
        'From error to error one discovers the entire truth.'),
    QuoteModel('KOIDTsukwc', 'Napoleon Hill',
        'Don\'t wait. The time will never be just right.'),
    QuoteModel('zoIweeEnYA', 'Byron Pulsifer',
        'The best teacher is experience learned from failures.'),
    QuoteModel('9YfRRvb50U', 'Oscar Wilde',
        'Be yourself; everyone else is already taken.'),
    QuoteModel('KydhYxsjJ8', 'Mahatma Gandhi',
        'Be the change that you wish to see in the world.'),
    QuoteModel('ibmlZW5LTe', 'John Lennon',
        'Love is the flower you\'ve got to let grow.'),
    QuoteModel('tQBKm6tUj7', 'Socrates', 'Wisdom begins in wonder.'),
    QuoteModel('VTSIxu5QbP', 'Aristotle', 'Change in all things is sweet.'),
    QuoteModel('iNVBzhxPHx', 'Seneca', 'No man was ever wise by chance.'),
    QuoteModel(
        'mchzWpNm5O', 'proverb', 'The harder you fall, the higher you bounce.'),
    QuoteModel('QILbjZQ1j1', 'Richard Bach',
        'The simplest things are often the truest.'),
    QuoteModel(
        '1MyMC8Qnw7', 'Walt Disney', 'If you can dream it, you can do it.'),
    QuoteModel(
        'fR1gZiZwJf', 'Confucius', 'Wherever you go, go with all your heart.'),
    QuoteModel('jZtdG21xDx', 'Robert Heller',
        'Never ignore a gut feeling, but never believe that it\'s enough.')
  ];

  static void addFavouriteQuote(String user, QuoteModel quote) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .collection('favourite_quotes')
          .doc(quote.id)
          .set(quote.toJson());
    } catch (e) {
      print(e);
    }
  }

  static void removeFavouriteQuote(String user, QuoteModel quote) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('favourite_quotes')
        .doc(quote.id)
        .delete();
  }

  static Stream<List<QuoteModel>> getFavouriteQuotesForUser(String user) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('favourite_quotes')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => QuoteModel.fromJson(doc.data()))
            .toList());
  }
}
