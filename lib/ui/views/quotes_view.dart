import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journalio/data/view_models/providers/auth_provider.dart';
import 'package:journalio/data/view_models/home_view_model.dart';
import 'package:journalio/data/view_models/quotes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuotesView extends StatefulWidget {
  const QuotesView({Key? key}) : super(key: key);

  @override
  _QuotesViewState createState() => _QuotesViewState();
}

class _QuotesViewState extends State<QuotesView> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final home = Provider.of<HomeViewModel>(context, listen: false);
    return Consumer<QuotesViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.quotes),
          ),
          body: ListView.builder(
            padding: EdgeInsets.only(bottom: 64, top: 8),
            itemCount: viewModel.quotes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(16, 2, 0, 2),
                  subtitle: Text(
                    "- " + viewModel.quotes[index].author,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.pacifico().fontFamily),
                  ),
                  title: Text(
                    viewModel.quotes[index].text,
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
                          viewModel.addToFavourites(
                              auth.getCurrentUserID, viewModel.quotes[index]);
                          break;
                        case 2:
                          home.randomQuote = viewModel.quotes[index];
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(AppLocalizations.of(context)!.quoteSet),
                            ),
                          );
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child:
                            Text(AppLocalizations.of(context)!.quotesAddToFavs),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child:
                            Text(AppLocalizations.of(context)!.quotesAddToHome),
                        value: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
