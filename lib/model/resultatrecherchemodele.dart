class ResultatRecherche {
  int? id;
  int? idUser;
  int? matricule;
  String? designation;
  String? description;
  String? localisation;
  String? commune;
  String? longitude;
  String? latitude;
  int? disponibilite;
  int? type;
  String? pathUn;
  String? pathDeux;
  String? pathTrois;
  String? montant;
  String? createdAt;
  String? updatedAt;

  ResultatRecherche(
      {required this.id,
      required this.idUser,
      required this.matricule,
      required this.designation,
      required this.description,
      required this.localisation,
      required this.commune,
      required this.longitude,
      required this.latitude,
      required this.disponibilite,
      required this.type,
      required this.pathUn,
      required this.pathDeux,
      required this.pathTrois,
      required this.montant,
      required this.createdAt,
      required this.updatedAt});

  ResultatRecherche.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    matricule = json['matricule'];
    designation = json['designation'];
    description = json['description'];
    localisation = json['localisation'];
    commune = json['commune'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    disponibilite = json['disponibilite'];
    type = json['type'];
    pathUn = json['path_un'];
    pathDeux = json['path_deux'];
    pathTrois = json['path_trois'];
    montant = json['montant'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['matricule'] = this.matricule;
    data['designation'] = this.designation;
    data['description'] = this.description;
    data['localisation'] = this.localisation;
    data['commune'] = this.commune;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['disponibilite'] = this.disponibilite;
    data['type'] = this.type;
    data['path_un'] = this.pathUn;
    data['path_deux'] = this.pathDeux;
    data['path_trois'] = this.pathTrois;
    data['montant'] = this.montant;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
