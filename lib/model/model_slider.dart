import 'dart:convert';

List<ModelSlider> modelSliderFromJson(String str) => List<ModelSlider>.from(
    json.decode(str).map((x) => ModelSlider.fromJson(x)));

String modelSliderToJson(List<ModelSlider> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSlider {
  ModelSlider({
    this.hbId,
    this.hbImage,
    this.hbUrl,
    this.hbRank,
    this.rlIdFk,
    this.isForAll,
    this.hbStatus,
  });

  int hbId;
  String hbImage;
  String hbUrl;
  int hbRank;
  String rlIdFk;
  String isForAll;
  String hbStatus;

  factory ModelSlider.fromJson(Map<String, dynamic> json) => ModelSlider(
        hbId: json["hb_id"],
        hbImage: json["hb_image"],
        hbUrl: json["hb_url"],
        hbRank: json["hb_rank"],
        rlIdFk: json["rl_id_fk"] == null ? null : json["rl_id_fk"],
        isForAll: json["is_for_all"],
        hbStatus: json["hb_status"],
      );

  Map<String, dynamic> toJson() => {
        "hb_id": hbId,
        "hb_image": hbImage,
        "hb_url": hbUrl,
        "hb_rank": hbRank,
        "rl_id_fk": rlIdFk == null ? null : rlIdFk,
        "is_for_all": isForAll,
        "hb_status": hbStatus,
      };
}
