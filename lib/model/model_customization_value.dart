class CustomizationValue {
  CustomizationValue({
    this.fcvId,
    this.rlIdFk,
    this.fIdFk,
    this.fcmIdFk,
    this.fcvName,
    this.fcvExtraPrice,
    this.fcvRank,
    this.fcvIsDefault,
    this.fcvStatus,
    this.posist,
  });

  int fcvId;
  int rlIdFk;
  int fIdFk;
  int fcmIdFk;
  String fcvName;
  String fcvExtraPrice;
  dynamic fcvRank;
  int fcvIsDefault;
  dynamic fcvStatus;
  String posist;
  bool isSelected = false;

  factory CustomizationValue.fromJson(Map<String, dynamic> json) =>
      CustomizationValue(
        fcvId: json["fcv_id"],
        rlIdFk: json["rl_id_fk"],
        fIdFk: json["f_id_fk"],
        fcmIdFk: json["fcm_id_fk"],
        fcvName: json["fcv_name"],
        fcvExtraPrice: json["fcv_extra_price"],
        fcvRank: json["fcv_rank"],
        fcvIsDefault: json["fcv_is_default"],
        fcvStatus: json["fcv_status"],
        posist: json["posist"],
      );

  Map<String, dynamic> toJson() => {
        "fcv_id": fcvId,
        "rl_id_fk": rlIdFk,
        "f_id_fk": fIdFk,
        "fcm_id_fk": fcmIdFk,
        "fcv_name": fcvName,
        "fcv_extra_price": fcvExtraPrice,
        "fcv_rank": fcvRank,
        "fcv_is_default": fcvIsDefault,
        "fcv_status": fcvStatus,
        "posist": posist,
      };
}
