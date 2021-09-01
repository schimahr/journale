import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journalio/data/models/journal_entry_model.dart';
import 'package:journalio/data/view_models/journal_entry_update_view_model.dart';
import 'package:journalio/ui/widgets/components/circle_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JournalEntryUpdateView extends StatefulWidget {
  const JournalEntryUpdateView(this.journalEntry, {Key? key}) : super(key: key);

  final JournalEntryModel journalEntry;

  @override
  _JournalEntryUpdateViewState createState() => _JournalEntryUpdateViewState();
}

class _JournalEntryUpdateViewState extends State<JournalEntryUpdateView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JournalEntryUpdateViewModel>(
        builder: (context, viewModel, child) {
      viewModel.setTextEditingControllerValues(
          widget.journalEntry.title, widget.journalEntry.text);
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.editJournalEntry),
        ),
        floatingActionButton: viewModel.isUpdating
            ? Container()
            : FloatingActionButton.extended(
                onPressed: () {
                  viewModel.changeStatus();
                  viewModel.updateJournalEntry(
                      widget.journalEntry.userID, widget.journalEntry.id);
                  Timer(
                    Duration(seconds: 2),
                    () {
                      Navigator.pop(context);
                      Timer(
                        Duration(seconds: 1),
                        () {
                          viewModel.changeStatus();
                          viewModel.clearTextEditingControllers();
                        },
                      );
                    },
                  );
                },
                label: Text(AppLocalizations.of(context)!.saveChanges),
                icon: Icon(FontAwesomeIcons.solidSave),
              ),
        body: viewModel.isUpdating
            ? CircleIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                      child: TextFormField(
                        controller: viewModel.titleController,
                        cursorColor: Theme.of(context).accentColor,
                        style: TextStyle(
                            fontFamily: GoogleFonts.kalam().fontFamily,
                            fontSize: 24),
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .journalEntryTitle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
                      child: TextFormField(
                        cursorColor: Theme.of(context).accentColor,
                        controller: viewModel.textController,
                        maxLength: 600,
                        maxLines: 14,
                        style: TextStyle(
                            fontFamily: GoogleFonts.kalam().fontFamily,
                            fontSize: 16),
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.journalEntryText),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
