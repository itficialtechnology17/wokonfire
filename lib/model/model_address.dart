import 'dart:convert';

List<ModelAddress> modelAddressFromJson(String str) => List<ModelAddress>.from(
    json.decode(str).map((x) => ModelAddress.fromJson(x)));

String modelAddressToJson(List<ModelAddress> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelAddress {
  ModelAddress({
    this.caId,
    this.cIdFk,
    this.caType,
    this.caLat,
    this.caLong,
    this.caIsPrimary,
    this.caLandmark,
    this.caMapAddress,
    this.caBlockNo,
    this.caTypeChoice,
  });

  int caId;
  int cIdFk;
  String caType;
  double caLat;
  double caLong;
  int caIsPrimary;
  String caLandmark;
  String caMapAddress;
  String caBlockNo;
  String caTypeChoice;

  factory ModelAddress.fromJson(Map<String, dynamic> json) => ModelAddress(
        caId: json["ca_id"],
        cIdFk: json["c_id_fk"],
        caType: json["ca_type"],
        caLat: json["ca_lat"].toDouble(),
        caLong: json["ca_long"].toDouble(),
        caIsPrimary: json["ca_is_primary"],
        caLandmark: json["ca_landmark"],
        caMapAddress: json["ca_map_address"],
        caBlockNo: json["ca_block_no"],
        caTypeChoice: json["ca_type_choice"],
      );

  Map<String, dynamic> toJson() => {
        "ca_id": caId,
        "c_id_fk": cIdFk,
        "ca_type": caType,
        "ca_lat": caLat,
        "ca_long": caLong,
        "ca_is_primary": caIsPrimary,
        "ca_landmark": caLandmark,
        "ca_map_address": caMapAddress,
        "ca_block_no": caBlockNo,
        "ca_type_choice": caTypeChoice,
      };
}
