import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/global_keys.dart';
import 'package:shop_app/preferences_service.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  PreferencesService preferencesService = PreferencesService();
  String? savedLanguageCode = await preferencesService.loadLanguageCode();
  Locale initialLocale = savedLanguageCode != null 
      ? Locale(savedLanguageCode) 
      : const Locale('en', 'US');
  runApp(
    //haana uurhclult orsniig helj uguh
    ChangeNotifierProvider(
      create: (context) => Global_provider(),
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('mn', 'MN')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        startLocale: initialLocale,
        child: const MyApp(),
        ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorKey: GLobalKeys.navigatorKey,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const SafeArea(
        child: LoginPage(),
      ),
    );
  }
}
