import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journalio/data/view_models/providers/auth_provider.dart';
import 'package:journalio/data/view_models/journal_entry_create_view_model.dart';
import 'package:journalio/ui/widgets/components/circle_indicator.dart';
import 'package:journalio/utilities/helpers/helper_functions.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JournalEntryCreateView extends StatefulWidget {
  const JournalEntryCreateView({Key? key}) : super(key: key);

  @override
  _JournalEntryCreateViewState createState() => _JournalEntryCreateViewState();
}

class _JournalEntryCreateViewState extends State<JournalEntryCreateView> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Consumer<JournalEntryCreateViewModel>(
        builder: (context, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(HelperFunctions.getFormattedDate(
              DateTime.now().millisecondsSinceEpoch)),
        ),
        floatingActionButton: viewModel.isCreating
            ? Container()
            : FloatingActionButton.extended(
                onPressed: () {
                  viewModel.changeStatus();
                  viewModel.createJournalEntry(auth.getCurrentUserID);
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
                label: Text(AppLocalizations.of(context)!.createJournalEntry),
                icon: Icon(FontAwesomeIcons.solidSave),
              ),
        body: viewModel.isCreating
            ? CircleIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                      child: TextFormField(
                        cursorColor: Theme.of(context).accentColor,
                        controller: viewModel.titleController,
                        style: TextStyle(
                            fontFamily: GoogleFonts.kalam().fontFamily,
                            fontSize: 24),
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.journalEntryTitle,
                        ),
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
                          focusColor: Theme.of(context).accentColor,
                          labelText:
                              AppLocalizations.of(context)!.journalEntryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
