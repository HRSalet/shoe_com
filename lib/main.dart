import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneakers_app/controller/language_change_controller.dart';
import 'package:sneakers_app/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? '';
  runApp(MyApp(locale: languageCode));
}

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageChangeController()),
      ],
      child: Consumer<LanguageChangeController>(
        builder: (context, provider, child) {
          if (locale.isEmpty) {
            provider.changeLanguage(Locale('en'));
          }
          return MaterialApp(
            title: 'Sneakers Shop App',
            locale:
                locale == ''
                    ? Locale('en')
                    : provider.appLocale ?? Locale('en'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('en'), Locale('hi'), Locale('gu')],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Quicksand'),
            home: SplashScreen(),
            //home: SplashScreen(),
          );
        },
      ),
    );
  }
}
