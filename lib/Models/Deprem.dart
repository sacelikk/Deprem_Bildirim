class Deprem {
  final String id;
  final String earthquakeId;
  final String provider;
  final String title;
  final String date;
  final double mag;
  final double depth;
  final double latitude;
  final double longitude;

  Deprem({
    required this.id,
    required this.earthquakeId,
    required this.provider,
    required this.title,
    required this.date,
    required this.mag,
    required this.depth,
    required this.latitude,
    required this.longitude,
  });

  factory Deprem.fromJson(Map<String, dynamic> json) {
    final coords = json["geojson"]?["coordinates"];

    return Deprem(
      id: json["_id"]?.toString() ?? "",
      earthquakeId: json["earthquake_id"]?.toString() ?? "",
      provider: json["provider"]?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      date: json["date_time"]?.toString() ?? "",
      mag: (json["mag"] as num?)?.toDouble() ?? 0.0,
      depth: (json["depth"] as num?)?.toDouble() ?? 0.0,
      longitude: coords is List && coords.isNotEmpty
          ? (coords[0] as num).toDouble()
          : 0.0,
      latitude: coords is List && coords.length > 1
          ? (coords[1] as num).toDouble()
          : 0.0,
    );
  }
}