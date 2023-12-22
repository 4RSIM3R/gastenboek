class AgendaModel {
  final int? id;
  final String? name;
  final String? description;
  final DateTime? date;
  final String? thumbnail;
  final String? createdAt;
  final double? lat;
  final double? lng;
  final String? location;

  AgendaModel({
    this.id,
    this.name,
    this.description,
    this.date,
    this.thumbnail,
    this.createdAt,
    this.lat,
    this.lng,
    this.location,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) => AgendaModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        thumbnail: json["thumbnail"],
        createdAt: json["created_at"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "date": date?.toIso8601String(),
        "thumbnail": thumbnail,
        "created_at": createdAt,
        "lat": lat,
        "lng": lng,
        "location": location,
      };
}
