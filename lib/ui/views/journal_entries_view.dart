import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journalio/data/models/journal_entry_model.dart';
import 'package:journalio/data/repositories/journal_entry_repository.dart';
import 'package:journalio/data/view_models/journal_entry_create_view_model.dart';
import 'package:journalio/data/view_models/providers/auth_provider.dart';
import 'package:journalio/data/view_models/journal_entries_view_model.dart';
import 'package:journalio/ui/widgets/components/circle_indicator.dart';
import 'package:journalio/utilities/helpers/helper_functions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'journal_entry_create_view.dart';
import 'journal_entry_detail_view.dart';

class JournalEntriesView extends StatefulWidget {
  const JournalEntriesView({Key? key}) : super(key: key);

  @override
  _JournalEntriesViewState createState() => _JournalEntriesViewState();
}

class _JournalEntriesViewState extends State<JournalEntriesView> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final createVm =
        Provider.of<JournalEntryCreateViewModel>(context, listen: false);
    return Consumer<JournalEntriesViewModel>(
        builder: (context, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.journalEntries),
          actions: [
            IconButton(
              onPressed: () {
                if (viewModel.isSearching) {
                  viewModel.endSearch();
                } else {
                  viewModel.startSearch();
                }
              },
              icon: Icon(
                viewModel.isSearching
                    ? FontAwesomeIcons.times
                    : FontAwesomeIcons.search,
                color: Theme.of(context).accentColor,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                  child: JournalEntryCreateView(),
                  type: PageTransitionType.fade),
            ).then(
              (value) => Timer(
                Duration(seconds: 1),
                () {
                  createVm.clearTextEditingControllers();
                },
              ),
            );
          },
          label: Text(AppLocalizations.of(context)!.addJournalEntry),
          icon: Icon(FontAwesomeIcons.pencilAlt),
        ),
        body: Column(
          children: [
            Visibility(
              visible: viewModel.isSearching,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                child: TextFormField(
                  cursorColor: Theme.of(context).accentColor,
                  keyboardType: TextInputType.text,
                  controller: viewModel.searchController,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.searchJournalEntriesLabel,
                  ),
                  onChanged: (text) {
                    viewModel.addToQuery();
                  },
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<JournalEntryModel>>(
                stream:
                    viewModel.getJournalEntriesStream(auth.getCurrentUserID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<JournalEntryModel>? docs = snapshot.data;
                    return snapshot.data!.length == 0
                        ? Scaffold(
                            body: Center(
                              child: Text(
                                AppLocalizations.of(context)!.noEntries,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                        : ListView(
                            padding: EdgeInsets.only(top: 8, bottom: 64),
                            children: docs!
                                .map((journalEntry) => journalEntry.title
                                        .toLowerCase()
                                        .contains(
                                            viewModel.searchQuery.toLowerCase())
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 1, 8, 1),
                                        child: Card(
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  child: JournalEntryDetailView(
                                                      journalEntry),
                                                  type: PageTransitionType.fade,
                                                ),
                                              );
                                            },
                                            title: Text(
                                              journalEntry.title,
                                              style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.kalam()
                                                          .fontFamily,
                                                  fontSize: 18),
                                            ),
                                            subtitle: Text(
                                              HelperFunctions.getFormattedDate(
                                                  journalEntry.created),
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(
                                                journalEntry.favourite
                                                    ? FontAwesomeIcons
                                                        .solidHeart
                                                    : FontAwesomeIcons.heart,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                JournalEntryRepository
                                                    .updateFavouriteStatus(
                                                        auth.getCurrentUserID,
                                                        journalEntry.id,
                                                        !journalEntry
                                                            .favourite);
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container())
                                .toList());
                  } else {
                    return Scaffold(
                      body: Center(
                        child: CircleIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
