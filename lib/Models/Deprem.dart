class Deprem {
  final String id;
  final String earthquakeId;
  final String provider;
  final String title;
  final String date;
  final double mag;
  final double depth;

  Deprem({
    required this.id,
    required this.earthquakeId,
    required this.provider,
    required this.title,
    required this.date,
    required this.mag,
    required this.depth,
  });

  factory Deprem.fromJson(Map<String, dynamic> json) {
    return Deprem(
      id: json["_id"],
      earthquakeId: json["earthquake_id"],
      provider: json["provider"],
      title: json["title"],
      date: json["date"],
      mag: (json["mag"] as num).toDouble(),
      depth: (json["depth"] as num).toDouble(),
    );
  }
}
