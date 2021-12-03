import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:worldwide/src/screens/dashboard_screen/dashboard_screen.dart';
import 'package:worldwide/src/screens/list_castaway/list_castaway.dart';
import 'package:worldwide/src/screens/list_savers_screen/list_savers_screen.dart';
import 'package:worldwide/translations/locale.keys.g.dart';

class MainProvider with ChangeNotifier {
  late bool refresh;
  late Locale locale;
  late String country;
  final storage = GetStorage();
  Map<String, StatefulWidget> listScreens = {
    LocaleKeys.saver_screen_title.tr(): ListSaversScreen(),
    LocaleKeys.dashboard_title.tr(): DashboardScreen(),
    LocaleKeys.naufrage_screen_title.tr(): ListCastawayScreen(),
  };

  refreshUI() {
    notifyListeners();
  }

  initLocale(String lang) {
    storage.writeIfNull("LANGUAGE", lang);
    locale = Locale(storage.read("LANGUAGE"));
    if (lang.toUpperCase() == 'FR')
      country = "FR";
    else
      country = "US";
    refreshUI();
  }

  setLocale(Locale l, String c) {
    locale = l;
    country = c;
    storage.write("LANGUAGE", l.languageCode.toLowerCase());
    storage.write("COUNTRY", c);
    notifyListeners();
  }
}
