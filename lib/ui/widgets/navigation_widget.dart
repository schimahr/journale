import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journalio/data/view_models/journal_entries_view_model.dart';
import 'package:journalio/data/view_models/providers/auth_provider.dart';
import 'package:journalio/data/view_models/providers/settings_provider.dart';
import 'package:journalio/ui/views/favourites_view.dart';
import 'package:journalio/ui/views/journal_entries_view.dart';
import 'package:journalio/ui/views/quotes_view.dart';
import 'package:journalio/ui/widgets/auth_widget.dart';
import 'package:journalio/utilities/helpers/helper_functions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final settings = Provider.of<SettingsProvider>(context, listen: true);
    final entriesVm =
        Provider.of<JournalEntriesViewModel>(context, listen: false);
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.only(bottom: 0.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF6A8448),
                  Color(0xFF55693A),
                  Color(0xFF404F2B),
                  Color(0xFF364224)
                ], stops: [
                  0.2,
                  0.4,
                  0.6,
                  0.8
                ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                image: DecorationImage(
                    image: AssetImage('assets/drawer_header.png'),
                    fit: BoxFit.fill),
              ),
              accountName: Text(
                auth.userDisplayName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFDF6F0),
                ),
              ),
              accountEmail: Text(
                auth.userEmail,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFDF6F0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.quoteRight,
                color: Theme.of(context).accentColor,
              ),
              title: Text(AppLocalizations.of(context)!.quotes),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  PageTransition(
                      child: QuotesView(), type: PageTransitionType.fade),
                );
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.book,
                color: Theme.of(context).accentColor,
              ),
              title: Text(AppLocalizations.of(context)!.journalEntries),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                      child: JournalEntriesView(),
                      type: PageTransitionType.fade),
                ).then((value) => Timer(Duration(seconds: 1), () {
                      entriesVm.endSearch();
                    }));
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.solidHeart,
                color: Theme.of(context).accentColor,
              ),
              title: Text(AppLocalizations.of(context)!.favourites),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                      child: FavouritesView(), type: PageTransitionType.fade),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.solidMoon,
                color: Theme.of(context).accentColor,
              ),
              title: Text(AppLocalizations.of(context)!.darkMode),
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).accentColor,
                onChanged: (bool value) {
                  settings.changeTheme(value);
                },
                value: settings.useDarkMode,
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.language,
                color: Theme.of(context).accentColor,
              ),
              title: Text(AppLocalizations.of(context)!.language),
              trailing: ToggleSwitch(
                activeBgColor: [
                  HelperFunctions.isDarkModeOn(context)
                      ? Color(0xFF6A8448)
                      : Color(0xFF55693A)
                ],
                inactiveBgColor: HelperFunctions.isDarkModeOn(context)
                    ? Color(0x2555693A)
                    : Color(0x2555693A),
                inactiveFgColor: HelperFunctions.isDarkModeOn(context)
                    ? Colors.grey.shade700
                    : Colors.black45,
                activeFgColor: HelperFunctions.isDarkModeOn(context)
                    ? Colors.white
                    : Colors.white,
                minWidth: 50,
                fontSize: 16,
                totalSwitches: 2,
                labels: ["HR", "EN"],
                initialLabelIndex: settings.initialLocaleIndex,
                onToggle: (locale) {
                  switch (locale) {
                    case 0:
                      settings.changeLocale(0);
                      break;
                    case 1:
                      settings.changeLocale(1);
                      break;
                  }
                },
              ),
            ),
            Divider(),
            AboutListTile(
              icon: Icon(
                FontAwesomeIcons.infoCircle,
                color: Theme.of(context).accentColor,
              ),
              child: Text(AppLocalizations.of(context)!.about),
              applicationName: 'Journalé',
              applicationVersion: 'preview-0.19',
              applicationIcon: Image.asset(
                'assets/icon_transparent.png',
                width: 80,
                height: 80,
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Theme.of(context).accentColor,
              ),
              title: Text(AppLocalizations.of(context)!.signOut),
              onTap: () async {
                Navigator.pop(context);
                await auth.signOut();
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: AuthWidget(), type: PageTransitionType.fade),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
