import 'package:wokonfire/model/model_customization_value.dart';

class Customization {
  Customization({
    this.fcmId,
    this.fcmTitle,
    this.fcmPrice,
    this.fcmRank,
    this.fcmMinSelection,
    this.fcmMaxSelection,
    this.fcmType,
    this.isTypeSize,
    this.isCompulsory,
    this.posist,
    this.fcvId,
    this.rlIdFk,
    this.fIdFk,
    this.fcmIdFk,
    this.fcvName,
    this.fcvExtraPrice,
    this.fcvRank,
    this.fcvIsDefault,
    this.fcvStatus,
    this.customizationValues,
  });

  int fcmId;
  String fcmTitle;
  int fcmPrice;
  int fcmRank;
  int fcmMinSelection;
  int fcmMaxSelection;
  int fcmType;
  String isTypeSize;
  int isCompulsory;
  String posist;
  int fcvId;
  int rlIdFk;
  int fIdFk;
  int fcmIdFk;
  String fcvName;
  String fcvExtraPrice;
  dynamic fcvRank;
  int fcvIsDefault;
  dynamic fcvStatus;
  List<CustomizationValue> customizationValues;

  factory Customization.fromJson(Map<String, dynamic> json) => Customization(
        fcmId: json["fcm_id"],
        fcmTitle: json["fcm_title"],
        fcmPrice: json["fcm_price"],
        fcmRank: json["fcm_rank"],
        fcmMinSelection: json["fcm_min_selection"],
        fcmMaxSelection: json["fcm_max_selection"],
        fcmType: json["fcm_type"],
        isTypeSize: json["is_type_size"],
        isCompulsory: json["is_compulsory"],
        posist: json["posist"],
        fcvId: json["fcv_id"],
        rlIdFk: json["rl_id_fk"],
        fIdFk: json["f_id_fk"],
        fcmIdFk: json["fcm_id_fk"],
        fcvName: json["fcv_name"],
        fcvExtraPrice: json["fcv_extra_price"],
        fcvRank: json["fcv_rank"],
        fcvIsDefault: json["fcv_is_default"],
        fcvStatus: json["fcv_status"],
        customizationValues: List<CustomizationValue>.from(
            json["customization_values"]
                .map((x) => CustomizationValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fcm_id": fcmId,
        "fcm_title": fcmTitle,
        "fcm_price": fcmPrice,
        "fcm_rank": fcmRank,
        "fcm_min_selection": fcmMinSelection,
        "fcm_max_selection": fcmMaxSelection,
        "fcm_type": fcmType,
        "is_type_size": isTypeSize,
        "is_compulsory": isCompulsory,
        "posist": posist,
        "fcv_id": fcvId,
        "rl_id_fk": rlIdFk,
        "f_id_fk": fIdFk,
        "fcm_id_fk": fcmIdFk,
        "fcv_name": fcvName,
        "fcv_extra_price": fcvExtraPrice,
        "fcv_rank": fcvRank,
        "fcv_is_default": fcvIsDefault,
        "fcv_status": fcvStatus,
        "customization_values":
            List<dynamic>.from(customizationValues.map((x) => x.toJson())),
      };
}
