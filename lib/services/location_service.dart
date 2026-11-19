import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hospital.dart';

class HospitalService {
  final String baseUrl =
      "https://example-api.com/hospitals"; // Replace with the API you choose.

  Future<List<Hospital>> fetchHospitals() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((data) => Hospital.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load hospitals");
    }
  }
}
