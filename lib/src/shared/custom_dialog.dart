import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:worldwide/src/database/cast_database.dart';
import 'package:worldwide/src/models/castaway.dart';
import 'package:worldwide/src/models/saver.dart';
import 'package:worldwide/src/shared/providers/mainProvider.dart';
import 'package:worldwide/translations/locale.keys.g.dart';

saverDialog(BuildContext c, String title, String buttonText,
    MainProvider refreshProvider) {
  String? nom;
  String tel = "", code = "";
  return showDialog(
    barrierDismissible: false,
    context: c,
    builder: (BuildContext context) {
      bool? active = true;
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  nom = value;
                },
                decoration: InputDecoration(
                    hintText: LocaleKeys.fullname_field.tr(),
                    icon: Icon(Icons.account_box_outlined)),
              ),
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  tel = value;
                },
                decoration: InputDecoration(
                    hintText: LocaleKeys.tel_field.tr(),
                    icon: Icon(Icons.phone)),
              ),
              TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  code = value;
                },
                decoration: InputDecoration(
                    hintText: LocaleKeys.code_field.tr(),
                    icon: Icon(Icons.vpn_key)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(LocaleKeys.save_button.tr()),
            onPressed: () async {
              int r = await CastAwayDatabase.instance
                  .createClient(Saver(null, nom, code, tel, true));
              refreshProvider.refreshUI();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(LocaleKeys.cancel_button.tr()),
              onPressed: () async {
                Navigator.of(context).pop();
              })
        ],
      );
    },
  );
}

editSaverDialog(BuildContext c, String title, String buttonText, Saver saver,
    MainProvider refreshProvider) {
  String? nom = saver.nom;
  String tel = saver.tel, code = saver.code;

  return showDialog(
    barrierDismissible: false,
    context: c,
    builder: (BuildContext context) {
      bool? active = false;
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                controller: TextEditingController(text: nom),
                onChanged: (value) {
                  nom = value;
                },
                decoration: InputDecoration(
                    hintText: LocaleKeys.fullname_field.tr(),
                    icon: Icon(Icons.account_box_outlined)),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                controller: TextEditingController(text: tel),
                onChanged: (value) {
                  tel = value;
                },
                decoration: InputDecoration(
                    hintText: LocaleKeys.tel_field.tr(),
                    icon: Icon(Icons.phone)),
              ),
              TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                controller: TextEditingController(text: code),
                onChanged: (value) {
                  code = value;
                },
                decoration: InputDecoration(
                    hintText: LocaleKeys.code_field.tr(),
                    icon: Icon(Icons.vpn_key)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(LocaleKeys.save_button.tr()),
            onPressed: () async {
              int r = await CastAwayDatabase.instance.updateSaverInfo(
                  Saver(saver.id, nom, tel, code, saver.active));
              refreshProvider.refreshUI();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(LocaleKeys.cancel_button.tr()),
              onPressed: () async {
                Navigator.of(context).pop();
              })
        ],
      );
    },
  );
}

castawayDialog(BuildContext c, String title, String buttonText,
    MainProvider refreshProvider) {
  return showDialog(
    barrierDismissible: false,
    context: c,
    builder: (BuildContext context) {
      String nom = "", prenom = "", tel = "";
      String depart = "", adresse = "";
      return AlertDialog(
        title: Text(LocaleKeys.add_castaway.tr()),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  nom = value;
                },
                decoration: InputDecoration(
                    hintText: LocaleKeys.lastname_field.tr(),
                    icon: Icon(Icons.person)),
              ),
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  prenom = value;
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.firstname_field.tr(),
                  icon: Icon(Icons.description),
                ),
              ),
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  tel = value;
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.tel_field.tr(),
                  icon: Icon(Icons.phone),
                ),
              ),
              TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.streetAddress,
                onChanged: (value) {
                  adresse = value;
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.adresse_field.tr(),
                  icon: Icon(Icons.map),
                ),
              ),
              TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  depart = value;
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.departure_field.tr(),
                  icon: Icon(Icons.map),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(LocaleKeys.save_button.tr()),
            onPressed: () async {
              DateTime now = DateTime.now();
              DateTime date = DateTime(now.year, now.month, now.day);
              int r = await CastAwayDatabase.instance.createCastaway(Castaway(
                  null,
                  nom,
                  prenom,
                  adresse,
                  tel,
                  depart,
                  date.toIso8601String()));
              refreshProvider.refreshUI();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(LocaleKeys.cancel_button.tr()),
              onPressed: () async {
                Navigator.of(context).pop();
              })
        ],
      );
    },
  );
}

editCastawayDialog(BuildContext c, String title, String buttonText,
    Castaway castaway, MainProvider refreshProvider) {
  return showDialog(
    barrierDismissible: false,
    context: c,
    builder: (BuildContext context) {
      String nom = castaway.nom!,
          prenom = castaway.prenom!,
          tel = castaway.tel,
          date = castaway.date,
          depart = castaway.depart,
          adresse = castaway.adresse;
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                textInputAction: TextInputAction.next,
                controller: TextEditingController(text: nom),
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  nom = value;
                },
                decoration: InputDecoration(
                    hintText: LocaleKeys.lastname_field.tr(),
                    icon: Icon(Icons.person)),
              ),
              TextField(
                controller: TextEditingController(text: prenom),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  prenom = value;
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.firstname_field.tr(),
                  icon: Icon(Icons.description),
                ),
              ),
              TextField(
                controller: TextEditingController(text: tel),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  tel = value;
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.tel_field.tr(),
                  icon: Icon(Icons.phone),
                ),
              ),
              TextField(
                controller: TextEditingController(text: adresse),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.streetAddress,
                onChanged: (value) {
                  adresse = value;
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.adresse_field.tr(),
                  icon: Icon(Icons.map),
                ),
              ),
              TextField(
                controller: TextEditingController(text: depart),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.streetAddress,
                onChanged: (value) {
                  depart = value;
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.departure_field.tr(),
                  icon: Icon(Icons.map),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(LocaleKeys.save_button.tr()),
            onPressed: () async {
              DateTime now = DateTime.now();
              DateTime date = DateTime(now.year, now.month, now.day);
              int r = await CastAwayDatabase.instance.editCastaway(Castaway(
                  castaway.id,
                  nom,
                  prenom,
                  adresse,
                  tel,
                  depart,
                  castaway.date));
              refreshProvider.refreshUI();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(LocaleKeys.cancel_button.tr()),
              onPressed: () async {
                Navigator.of(context).pop();
              })
        ],
      );
    },
  );
}
