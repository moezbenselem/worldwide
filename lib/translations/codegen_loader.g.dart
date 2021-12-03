// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "saver_screen_title": "Savers",
  "naufrage_screen_title": "Castaway",
  "saver_satus_active": "Active",
  "saver_satuts_inactive": "Inactive",
  "dashboard_title": "Dashboard",
  "tel_field": "Telephone",
  "code_field": "Code",
  "adresse_field": "Adresse",
  "departure_field": "Departure",
  "date_field": "Date",
  "ship_code_field": "Ship Code",
  "change_lang_text": "Change Language",
  "firstname_field": "First Name",
  "lastname_field": "Last Name",
  "fullname_field": "Fullname",
  "cancel_button": "Cancel",
  "save_button": "Save",
  "delete_button": "Delete",
  "edit_button": "Edit",
  "add_saver_text": "Add Saver",
  "castway_count_text": "Castaway",
  "castaway_count_today_text": "Castaway today",
  "add_castaway": "Add Castawa"
};
static const Map<String,dynamic> fr = {
  "saver_screen_title": "Sauveteurs",
  "naufrage_screen_title": "Naufragés",
  "saver_satus_active": "Active",
  "saver_satuts_inactive": "Inactive",
  "dashboard_title": "Tableau de Bord",
  "tel_field": "Téléphone",
  "code_field": "Code",
  "adresse_field": "Address",
  "departure_field": "Départ",
  "date_field": "Date",
  "ship_code_field": "Matricule du bateau",
  "change_lang_text": "Changer la Langue",
  "firstname_field": "Prénom",
  "lastname_field": "Nom",
  "fullname_field": "Nom & Prénom",
  "cancel_button": "Annuler",
  "save_button": "Enregistrer",
  "delete_button": "Supprimer",
  "edit_button": "Modifier",
  "add_saver_text": "Ajouter Sauveteur",
  "castway_count_text": "Naufragé",
  "castaway_count_today_text": "Naufragé aujourdh'ui",
  "add_castaway": "Ajouter Naufragé"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fr": fr};
}
