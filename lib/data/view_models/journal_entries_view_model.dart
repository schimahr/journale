import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:journalio/data/models/journal_entry_model.dart';
import 'package:journalio/data/repositories/journal_entry_repository.dart';

class JournalEntriesViewModel extends ChangeNotifier {
  late TextEditingController searchController;
  bool isSearching = false;
  String searchQuery = '';

  JournalEntriesViewModel() {
    searchController = TextEditingController();
  }

  void clearTextEditingController() {
    searchController.clear();
  }

  void addToQuery() {
    searchQuery = searchController.text;
    notifyListeners();
  }

  void startSearch() {
    isSearching = true;
    notifyListeners();
  }

  void endSearch() {
    isSearching = false;
    searchQuery = '';
    clearTextEditingController();
    notifyListeners();
  }

  Stream<List<JournalEntryModel>> getJournalEntriesStream(String user) {
    return JournalEntryRepository.getJournalEntriesForUser(user);
  }

  Stream<List<JournalEntryModel>> getFavouriteJournalEntriesStream(
      String user) {
    return JournalEntryRepository.getFavouriteJournalEntriesForUser(user);
  }
}
