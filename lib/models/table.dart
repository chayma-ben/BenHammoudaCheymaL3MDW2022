class TableModel {
  int? id;
  int? num;
  Null? compteur;
  String? createdAt;
  String? updatedAt;
  int? status;
bool selectedTable = true;
    int? orderidtable;

  TableModel(
      {this.id,
      this.num,
      this.compteur,
      this.createdAt,
      this.updatedAt,
      this.status});

  TableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    compteur = json['compteur'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['num'] = this.num;
    data['compteur'] = this.compteur;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}