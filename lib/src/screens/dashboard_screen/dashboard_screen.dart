import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldwide/src/database/cast_database.dart';
import 'package:worldwide/src/screens/dashboard_screen/widgets/card_dashboard.dart';
import 'package:worldwide/src/shared/providers/mainProvider.dart';
import 'package:worldwide/translations/locale.keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final MainProvider refreshProvider = Provider.of<MainProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
          heightFactor: 1,
          child: FutureBuilder(
            future: Future.wait([
              CastAwayDatabase.instance.countSavers(),
              CastAwayDatabase.instance.countCastaways(),
              //CastAwayDatabase.instance.countTodayCastaways(),
            ]),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return SingleChildScrollView(
                child: Wrap(
                  runSpacing: 10,
                  runAlignment: WrapAlignment.spaceBetween,
                  spacing: 10,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    CardDashboard(LocaleKeys.saver_screen_title.tr(),
                        snapshot.data[0], Colors.deepOrangeAccent),
                    CardDashboard(LocaleKeys.castway_count_text.tr(),
                        snapshot.data[1], Colors.redAccent),
                    // CardDashboard(LocaleKeys.castaway_count_today_text.tr(),
                    //     snapshot.data[2], Colors.red),
                  ],
                ),
              );
            },
          )),
    );
  }
}
