import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:journalio/data/models/journal_entry_model.dart';
import 'package:journalio/data/repositories/journal_entry_repository.dart';
import 'package:uuid/uuid.dart';

class JournalEntryCreateViewModel extends ChangeNotifier {
  late TextEditingController titleController;
  late TextEditingController textController;

  bool isCreating = false;

  JournalEntryCreateViewModel() {
    titleController = TextEditingController();
    textController = TextEditingController();
  }

  void createJournalEntry(String user) {
    var journalEntryID = Uuid().v1();
    JournalEntryModel journalEntry = JournalEntryModel(
      id: journalEntryID,
      userID: user,
      title: titleController.text,
      text: textController.text,
      created: DateTime.now().millisecondsSinceEpoch,
      favourite: false,
    );
    JournalEntryRepository.createJournalEntry(
        user, journalEntry, journalEntryID);
  }

  void clearTextEditingControllers() {
    titleController.clear();
    textController.clear();
  }

  void changeStatus() {
    isCreating = !isCreating;
    notifyListeners();
  }
}
