class Jour {
  int? id;
  String? libelle;
  int? jours;
  String? createdAt;
  String? updatedAt;

  Jour(
      {required this.id,
      required this.libelle,
      required this.jours,
      required this.createdAt,
      required this.updatedAt});

  Jour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    jours = json['jours'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['libelle'] = this.libelle;
    data['jours'] = this.jours;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
