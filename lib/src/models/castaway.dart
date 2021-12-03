final String tableCastAway = "castaways";

class castAwayFields {
  static final String id = '_id';
  static final String nom = 'nom';
  static final String prenom = 'prenom';
  static final String tel = 'tel';
  static final String adresse = 'adresse';
  static final String depart = 'depart';
  static final String date = 'date';
}

class Castaway {
  int? id;
  String? nom;
  String? prenom;
  late String adresse;
  late String tel;
  late String depart;
  late String date;

  Castaway(this.id, this.nom, this.prenom, this.adresse, this.tel, this.depart,
      this.date);

  Castaway.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    prenom = json['prenom'];
    tel = json['tel'];
    adresse = json['adresse'];
    depart = json['depart'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['tel'] = tel;
    data['adresse'] = adresse;
    data['depart'] = depart;
    data['date'] = date;
    return data;
  }
}
