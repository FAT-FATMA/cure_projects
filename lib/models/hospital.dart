class Hospital {
  final String name;
  final String imageUrl;
  final double distance;
  final double latitude;
  final double longitude;
  final String status;

  Hospital({
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      name: json['name'],
      imageUrl: json['imageUrl'] ?? '',
      distance: json['distance'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'] ?? 'Unknown',
    );
  }
}
