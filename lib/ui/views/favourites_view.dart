import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journalio/data/models/journal_entry_model.dart';
import 'package:journalio/data/models/quote_model.dart';
import 'package:journalio/data/repositories/journal_entry_repository.dart';
import 'package:journalio/data/view_models/providers/auth_provider.dart';
import 'package:journalio/data/view_models/favourites_view_model.dart';
import 'package:journalio/data/view_models/home_view_model.dart';
import 'package:journalio/data/view_models/journal_entries_view_model.dart';
import 'package:journalio/data/view_models/quotes_view_model.dart';
import 'package:journalio/ui/widgets/components/circle_indicator.dart';
import 'package:journalio/utilities/helpers/helper_functions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'journal_entry_detail_view.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({Key? key}) : super(key: key);

  @override
  _FavouritesViewState createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Consumer<FavouritesViewModel>(builder: (context, viewModel, child) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.favourites),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.book),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.quoteRight),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildFavouriteJournalEntries(auth),
              _buildFavouriteQuotes(auth),
            ],
          ),
        ),
      );
    });
  }
}

Widget _buildFavouriteJournalEntries(AuthProvider auth) {
  return Consumer<JournalEntriesViewModel>(
    builder: (context, viewModel, child) {
      return StreamBuilder<List<JournalEntryModel>>(
        stream:
            viewModel.getFavouriteJournalEntriesStream(auth.getCurrentUserID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<JournalEntryModel>? docs = snapshot.data;
            return snapshot.data!.length == 0
                ? Scaffold(
                    body: Center(
                      child: Text(
                        AppLocalizations.of(context)!.noFavEntries,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                : ListView(
                    padding: EdgeInsets.only(top: 8, bottom: 64),
                    children: docs!
                        .map(
                          (journalEntry) => Padding(
                            padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                            child: Card(
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        child: JournalEntryDetailView(
                                            journalEntry),
                                        type: PageTransitionType.fade),
                                  );
                                },
                                title: Text(
                                  journalEntry.title,
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.kalam().fontFamily,
                                      fontSize: 18),
                                ),
                                subtitle: Text(
                                  HelperFunctions.getFormattedDate(
                                      journalEntry.created),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    journalEntry.favourite
                                        ? FontAwesomeIcons.solidHeart
                                        : FontAwesomeIcons.heart,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    JournalEntryRepository
                                        .updateFavouriteStatus(
                                            auth.getCurrentUserID,
                                            journalEntry.id,
                                            !journalEntry.favourite);
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList());
          } else {
            return Scaffold(
              body: Center(
                child: CircleIndicator(),
              ),
            );
          }
        },
      );
    },
  );
}

Widget _buildFavouriteQuotes(AuthProvider auth) {
  return Consumer<QuotesViewModel>(builder: (context, viewModel, child) {
    final home = Provider.of<HomeViewModel>(context, listen: false);
    return StreamBuilder<List<QuoteModel>>(
      stream: viewModel.geFavouriteQuotesStream(auth.getCurrentUserID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<QuoteModel>? docs = snapshot.data;
          return snapshot.data!.length == 0
              ? Scaffold(
                  body: Center(
                    child: Text(
                      AppLocalizations.of(context)!.noFavQuotes,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              : ListView(
                  padding: EdgeInsets.only(top: 8),
                  children: docs!
                      .map(
                        (quote) => ListTile(
                          contentPadding: EdgeInsets.fromLTRB(16, 2, 0, 2),
                          subtitle: Text(
                            "- " + quote.author,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: GoogleFonts.pacifico().fontFamily),
                          ),
                          title: Text(
                            quote.text,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: GoogleFonts.pacifico().fontFamily),
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              FontAwesomeIcons.ellipsisV,
                              color: Theme.of(context).accentColor,
                            ),
                            onSelected: (choice) {
                              switch (choice) {
                                case 1:
                                  viewModel.removeFromFavourites(
                                      auth.getCurrentUserID, quote);
                                  break;
                                case 2:
                                  home.randomQuote = quote;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .quoteSet),
                                    ),
                                  );
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                child: Text(AppLocalizations.of(context)!
                                    .quotesRemoveFav),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text(AppLocalizations.of(context)!
                                    .quotesAddToHome),
                                value: 2,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList());
        } else {
          return Scaffold(
            body: Center(
              child: CircleIndicator(),
            ),
          );
        }
      },
    );
  });
}
