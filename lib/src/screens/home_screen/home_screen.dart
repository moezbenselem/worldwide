import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldwide/core/colors.dart';
import 'package:worldwide/core/translation/supported_languages.dart';
import 'package:worldwide/src/screens/dashboard_screen/dashboard_screen.dart';
import 'package:worldwide/src/screens/list_savers_screen/list_savers_screen.dart';
import 'package:worldwide/src/shared/providers/mainProvider.dart';

import 'package:worldwide/src/shared/widgets/flags_dropdown_item.dart';
import 'package:worldwide/translations/locale.keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedScreenIndex = 1;

  @override
  Widget build(BuildContext context) {
    MainProvider langProvider = Provider.of<MainProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(getPageTitle(selectedScreenIndex, langProvider).tr()),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CountryPickerDropdown(
                initialValue: langProvider.country,
                itemFilter: (country) => ["FR", "US"].contains(country.isoCode),
                itemBuilder: (country) => FlagsDropdownItem(country),
                onValuePicked: (Country country) {
                  if (country.isoCode == "FR") {
                    context
                        .setLocale(Locale(describeEnum(SupportedLanguage.fr)));
                    langProvider.setLocale(
                        Locale(describeEnum(SupportedLanguage.fr)), "FR");
                  } else {
                    context
                        .setLocale(Locale(describeEnum(SupportedLanguage.en)));
                    langProvider.setLocale(
                        Locale(describeEnum(SupportedLanguage.en)), "US");
                  }
                },
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: $bleu,
        color: $oranger,
        style: TabStyle.react,
        curveSize: 100,
        elevation: 5,
        items: const [
          TabItem(icon: Icons.list),
          TabItem(icon: Icons.dashboard),
          TabItem(icon: Icons.person),
        ],
        initialActiveIndex: selectedScreenIndex,
        onTap: (int i) => setState(() {
          selectedScreenIndex = i;
        }),
      ),
      body: getPageByIndex(selectedScreenIndex, langProvider),
    );
  }

  String getPageTitle(index, langProvider) {
    return langProvider.listScreens.keys.toList()[index];
  }

  Widget getPageByIndex(index, langProvider) {
    return langProvider.listScreens.values.toList()[index];
  }
}
