final String tableSavers = "savers";

class SaversFields {
  static final String id = '_id';
  static final String nom = 'nom';
  static final String code = 'code';
  static final String tel = 'tel';
  static final String active = 'active';
}

class Saver {
  int? id;
  String? nom;
  late String code;
  late String tel;
  late bool active;

  Saver(this.id, this.nom, this.code, this.tel, this.active);

  Saver.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    tel = json['tel'];
    code = json['code'];
    active = json['active'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['nom'] = nom;
    data['tel'] = tel;
    data['code'] = code;
    data['active'] = active ? 1 : 0;
    return data;
  }

  @override
  String toString() {
    return 'Client{id: $id, nom: $nom, tel: $tel, code: $code, active: $active}';
  }
}
