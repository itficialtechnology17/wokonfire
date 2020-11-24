import 'dart:convert';

List<ModelFavoriteMaster> modelFavoriteMasterFromJson(String str) =>
    List<ModelFavoriteMaster>.from(
        json.decode(str).map((x) => ModelFavoriteMaster.fromJson(x)));

String modelFavoriteMasterToJson(List<ModelFavoriteMaster> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelFavoriteMaster {
  ModelFavoriteMaster({
    this.fMId,
    this.fTitle,
    this.cId,
  });

  int fMId;
  String fTitle;
  int cId;
  bool isSelected = false;

  factory ModelFavoriteMaster.fromJson(Map<String, dynamic> json) =>
      ModelFavoriteMaster(
        fMId: json["f_m_id"],
        fTitle: json["f_title"],
        cId: json["c_id"],
      );

  Map<String, dynamic> toJson() => {
        "f_m_id": fMId,
        "f_title": fTitle,
        "c_id": cId,
      };
}
