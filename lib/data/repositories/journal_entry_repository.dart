import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journalio/data/models/journal_entry_model.dart';

class JournalEntryRepository {
  static void createJournalEntry(String user, JournalEntryModel journalEntry,
      String journalEntryID) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('journal_entries')
        .doc(journalEntryID)
        .set(journalEntry.toJson());
  }

  static void removeJournalEntry(String user, String journalEntry) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('journal_entries')
        .doc(journalEntry)
        .delete();
  }

  static Stream<List<JournalEntryModel>> getJournalEntriesForUser(String user) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('journal_entries')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JournalEntryModel.fromJson(doc.data()))
            .toList());
  }

  static Stream<JournalEntryModel> getJournalEntryForUser(
      String user, String entry) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('journal_entries')
        .doc(entry)
        .snapshots()
        .map(
          (entry) => JournalEntryModel.fromJson(entry.data()!),
        );
  }

  static Stream<List<JournalEntryModel>> getFavouriteJournalEntriesForUser(
      String user) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('journal_entries')
        .where('favourite', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JournalEntryModel.fromJson(doc.data()))
            .toList());
  }

  static void updateFavouriteStatus(
      String user, String entry, bool isFavourite) async {
    print(user + ' | ' + entry + ' | ' + isFavourite.toString());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('journal_entries')
        .doc(entry)
        .update({'favourite': isFavourite})
        .then((value) => print("isFav Updated"))
        .catchError((error) => print("Failed to update Fav: $error"));
  }

  static void updateJournalEntry(String user, String entry, String updatedTitle,
      String updatedText) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('journal_entries')
        .doc(entry)
        .update({'title': updatedTitle, "text": updatedText})
        .then((value) => print("entry updated"))
        .catchError((error) => print("Failed to update: $error"));
  }
}
