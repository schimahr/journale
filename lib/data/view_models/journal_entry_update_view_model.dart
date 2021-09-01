import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:journalio/data/repositories/journal_entry_repository.dart';

class JournalEntryUpdateViewModel extends ChangeNotifier {
  late TextEditingController titleController;
  late TextEditingController textController;

  bool isUpdating = false;

  JournalEntryUpdateViewModel() {
    titleController = TextEditingController();
    textController = TextEditingController();
  }

  void updateJournalEntry(String user, String entry) {
    JournalEntryRepository.updateJournalEntry(
        user, entry, titleController.text, textController.text);
  }

  void setTextEditingControllerValues(
      String journalEntryTitle, String journalEntryText) {
    titleController.text = journalEntryTitle;
    textController.text = journalEntryText;
  }

  void clearTextEditingControllers() {
    titleController.clear();
    textController.clear();
  }

  void changeStatus() {
    isUpdating = !isUpdating;
    notifyListeners();
  }
}
