import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journalio/data/models/affirmation_model.dart';
import 'package:journalio/data/view_models/home_view_model.dart';
import 'package:journalio/data/view_models/journal_entry_create_view_model.dart';
import 'package:journalio/ui/theme/app_colours.dart';
import 'package:journalio/ui/widgets/navigation_widget.dart';
import 'package:journalio/utilities/helpers/helper_functions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'journal_entry_create_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, viewModel, child) {
      final createVm =
          Provider.of<JournalEntryCreateViewModel>(context, listen: false);
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.homeTitle),
        ),
        floatingActionButton: SpeedDial(
          overlayColor: HelperFunctions.isDarkModeOn(context)
              ? Color(0x40141414)
              : Color(0x25333333),
          elevation: 10,
          icon: FontAwesomeIcons.caretUp,
          activeIcon: FontAwesomeIcons.caretDown,
          spacing: 10,
          spaceBetweenChildren: 10,
          childrenButtonSize: 60,
          children: [
            SpeedDialChild(
              backgroundColor: Theme.of(context).cardTheme.color,
              foregroundColor: HelperFunctions.isDarkModeOn(context)
                  ? AppColours.olivine
                  : AppColours.kombuGreenV,
              labelBackgroundColor: Theme.of(context).cardTheme.color,
              labelStyle: TextStyle(
                color: HelperFunctions.isDarkModeOn(context)
                    ? AppColours.olivine
                    : AppColours.kombuGreenV,
              ),
              label: AppLocalizations.of(context)!.addJournalEntry,
              child: Icon(FontAwesomeIcons.pencilAlt),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: JournalEntryCreateView(),
                      type: PageTransitionType.fade),
                ).then((value) => Timer(Duration(seconds: 1), () {
                      createVm.clearTextEditingControllers();
                    }));
              },
            ),
            SpeedDialChild(
              backgroundColor: Theme.of(context).cardTheme.color,
              foregroundColor: HelperFunctions.isDarkModeOn(context)
                  ? AppColours.olivine
                  : AppColours.kombuGreenV,
              labelBackgroundColor: Theme.of(context).cardTheme.color,
              labelStyle: TextStyle(
                color: HelperFunctions.isDarkModeOn(context)
                    ? AppColours.olivine
                    : AppColours.kombuGreenV,
              ),
              label: AppLocalizations.of(context)!.giveAffirmation,
              child: Icon(FontAwesomeIcons.handHoldingHeart),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: FutureBuilder<AffirmationModel>(
                      future: viewModel.randomAffirmation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.affirmation + '.',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: GoogleFonts.kalam().fontFamily),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          viewModel.getNewAffirmation();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.affirmationAction,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        drawer: NavigationWidget(),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 24, left: 24, top: 8),
                        child: Text(
                          viewModel.randomQuoteText,
                          style: TextStyle(
                              fontFamily: GoogleFonts.pacifico().fontFamily,
                              fontStyle: FontStyle.italic,
                              fontSize: 28),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 24, left: 24, top: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '- ' + viewModel.randomQuoteAuthor,
                              style: TextStyle(
                                  fontFamily: GoogleFonts.pacifico().fontFamily,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                child: SvgPicture.asset('assets/graphics/thinking.svg'),
                alignment: Alignment.bottomLeft,
              ),
            ],
          ),
        ),
      );
    });
  }
}
