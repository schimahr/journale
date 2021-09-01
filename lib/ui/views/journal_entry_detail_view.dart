import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journalio/data/models/journal_entry_model.dart';
import 'package:journalio/data/repositories/journal_entry_repository.dart';
import 'package:journalio/data/view_models/journal_entry_detail_view_model.dart';
import 'package:journalio/data/view_models/journal_entry_update_view_model.dart';
import 'package:journalio/utilities/helpers/helper_functions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'journal_entry_update_view.dart';

class JournalEntryDetailView extends StatefulWidget {
  const JournalEntryDetailView(this.journalEntry, {Key? key}) : super(key: key);

  final JournalEntryModel journalEntry;

  @override
  _JournalEntryDetailViewState createState() => _JournalEntryDetailViewState();
}

class _JournalEntryDetailViewState extends State<JournalEntryDetailView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JournalEntryDetailViewModel>(
      builder: (context, viewModel, child) {
        final updateVm =
            Provider.of<JournalEntryUpdateViewModel>(context, listen: false);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                HelperFunctions.getFormattedDate(widget.journalEntry.created)),
            actions: [
              StreamBuilder<JournalEntryModel>(
                  stream: viewModel.getJournalEntryStream(
                      widget.journalEntry.userID, widget.journalEntry.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                child: JournalEntryUpdateView(snapshot.data!),
                                type: PageTransitionType.fade),
                          ).then(
                            (value) => Timer(
                              Duration(seconds: 1),
                              () {
                                updateVm.setTextEditingControllerValues(
                                    snapshot.data!.title, snapshot.data!.title);
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.solidEdit,
                          color: Theme.of(context).accentColor,
                        ),
                      );
                    } else {
                      return IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                child:
                                    JournalEntryUpdateView(widget.journalEntry),
                                type: PageTransitionType.fade),
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.solidEdit,
                          color: Theme.of(context).accentColor,
                        ),
                      );
                    }
                  }),
              IconButton(
                onPressed: () {
                  JournalEntryRepository.removeJournalEntry(
                      widget.journalEntry.userID, widget.journalEntry.id);
                  Navigator.pop(context);
                },
                icon: Icon(FontAwesomeIcons.trashAlt,
                    color: Theme.of(context).accentColor),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: StreamBuilder<JournalEntryModel>(
              stream: viewModel.getJournalEntryStream(
                  widget.journalEntry.userID, widget.journalEntry.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: Text(
                          snapshot.data!.title,
                          style: TextStyle(
                              fontFamily: GoogleFonts.kalam().fontFamily,
                              fontSize: 24),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
                        child: Text(
                          snapshot.data!.text,
                          style: TextStyle(
                              fontFamily: GoogleFonts.kalam().fontFamily,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
