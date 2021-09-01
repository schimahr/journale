import 'package:flutter/foundation.dart';
import 'package:journalio/data/models/journal_entry_model.dart';
import 'package:journalio/data/repositories/journal_entry_repository.dart';

class JournalEntryDetailViewModel extends ChangeNotifier {
  Stream<JournalEntryModel> getJournalEntryStream(String user, String entry) {
    return JournalEntryRepository.getJournalEntryForUser(user, entry);
  }
}
