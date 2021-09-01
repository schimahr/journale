import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:journalio/data/view_models/providers/auth_provider.dart';
import 'package:journalio/data/view_models/providers/settings_provider.dart';
import 'package:journalio/data/view_models/favourites_view_model.dart';
import 'package:journalio/data/view_models/home_view_model.dart';
import 'package:journalio/data/view_models/journal_entries_view_model.dart';
import 'package:journalio/data/view_models/journal_entry_create_view_model.dart';
import 'package:journalio/data/view_models/journal_entry_update_view_model.dart';
import 'package:journalio/data/view_models/login_view_model.dart';
import 'package:journalio/data/view_models/quotes_view_model.dart';
import 'package:journalio/data/view_models/register_view_model.dart';
import 'package:journalio/ui/theme/app_themes.dart';
import 'package:journalio/ui/widgets/auth_widget.dart';
import 'package:provider/provider.dart';
import 'data/view_models/journal_entry_detail_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider(),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create: (context) => RegisterViewModel(),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => JournalEntriesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => JournalEntryDetailViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => JournalEntryCreateViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => JournalEntryUpdateViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuotesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouritesViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          title: 'Journalé',
          themeMode: settings.useDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          home: AuthWidget(),
          locale: settings.preferredLocale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''), // English
            Locale('hr', ''), // Croatian
          ],
        );
      },
    );
  }
}
