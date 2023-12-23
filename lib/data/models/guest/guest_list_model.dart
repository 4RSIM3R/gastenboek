class GuestListModel {
  final int? id;
  final String? userId;
  final DateTime? createdAt;
  final String? address;
  final String? nik;
  final String? name;
  final int? tip;

  GuestListModel({
    this.id,
    this.userId,
    this.createdAt,
    this.address,
    this.nik,
    this.name,
    this.tip,
  });

  factory GuestListModel.fromJson(Map<String, dynamic> json) => GuestListModel(
        id: json["id"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        address: json["address"],
        nik: json["nik"],
        name: json["name"],
        tip: json["tip"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "address": address,
        "nik": nik,
        "name": name,
        "tip": tip,
      };
}
