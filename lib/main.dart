import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worldwide/core/colors.dart';
import 'package:worldwide/core/translation/supported_languages.dart';
import 'package:worldwide/src/screens/home_screen/home_screen.dart';
import 'package:worldwide/src/shared/providers/mainProvider.dart';
import 'package:worldwide/translations/codegen_loader.g.dart';

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(ChangeNotifierProvider<MainProvider>(
    create: (context) => MainProvider(),
    child: EasyLocalization(
        supportedLocales: [
          Locale(describeEnum(SupportedLanguage.fr)),
          Locale(describeEnum(SupportedLanguage.en))
        ],
        path: 'assets/translations',
        assetLoader: CodegenLoader(),
        fallbackLocale: Locale(describeEnum(SupportedLanguage.fr)),
        child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainNotifier = Provider.of<MainProvider>(context);
    mainNotifier.initLocale(context.locale.languageCode);

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: mainNotifier.locale,
      debugShowCheckedModeBanner: false,
      title: 'Castaway',
      theme: ThemeData(
          fontFamily: GoogleFonts.roboto().fontFamily,
          textTheme: TextTheme(
            bodyText1: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            bodyText2: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            subtitle1: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
            subtitle2: TextStyle(fontWeight: FontWeight.w100, fontSize: 14),
          ),
          primaryColor: $oranger,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: $bleu),
          appBarTheme: AppBarTheme.of(context).copyWith(color: $oranger)),
      home: HomeScreen(),
    );
  }
}
