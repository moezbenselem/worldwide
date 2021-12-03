import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';
import 'package:worldwide/src/database/cast_database.dart';
import 'package:worldwide/src/models/saver.dart';
import 'package:worldwide/src/shared/custom_dialog.dart';
import 'package:worldwide/src/shared/providers/mainProvider.dart';
import 'package:worldwide/translations/locale.keys.g.dart';

class ListSaversScreen extends StatefulWidget {
  const ListSaversScreen({Key? key}) : super(key: key);

  @override
  _ListSaversScreenState createState() => _ListSaversScreenState();
}

class _ListSaversScreenState extends State<ListSaversScreen> {
  List<Saver>? listSavers;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    final MainProvider refreshProvider = Provider.of<MainProvider>(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: FutureBuilder(
            future: CastAwayDatabase.instance.readAllSavers(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                listSavers = snapshot.data;

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return FocusedMenuHolder(
                        blurSize: 1,
                        menuWidth: screenWidth * 0.5,
                        blurBackgroundColor: Colors.white,
                        duration: Duration(milliseconds: 500),
                        onPressed: () {},
                        menuItems: [
                          FocusedMenuItem(
                              title: Text(
                                LocaleKeys.edit_button.tr(),
                              ),
                              onPressed: () {
                                editSaverDialog(
                                    context,
                                    LocaleKeys.edit_button.tr(),
                                    LocaleKeys.save_button.tr(),
                                    listSavers![index],
                                    refreshProvider);
                              },
                              trailingIcon: Icon(Icons.edit)),
                          FocusedMenuItem(
                              title: Text(
                                LocaleKeys.delete_button.tr(),
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                CastAwayDatabase.instance
                                    .deleteSaver(snapshot.data[index].id);
                                refreshProvider.refreshUI();
                              },
                              backgroundColor: Colors.redAccent,
                              trailingIcon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ))
                        ],
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: snapshot.data[index].nom != null
                              ? Text(snapshot.data[index].nom)
                              : Text(snapshot.data[index].tel),
                          subtitle: snapshot.data[index].nom != null
                              ? Text(snapshot.data[index].tel)
                              : null,
                          trailing: Text(
                            snapshot.data[index].active ? "Active" : "Inactive",
                            style: theme.textTheme.subtitle2!.copyWith(
                              color: snapshot.data[index].active
                                  ? Colors.green
                                  : Colors.deepOrange,
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                print(snapshot.error);
                return Text("an error occured !");
              }
            },
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              saverDialog(context, LocaleKeys.add_saver_text.tr(),
                  LocaleKeys.save_button.tr(), refreshProvider);
            },
            child: Icon(Icons.person_add_alt_1),
          ),
        ),
      ],
    );
  }
}
