import 'dart:convert';
import 'package:elcriticoapp/models/studio.dart';
import 'package:elcriticoapp/shared/constants.dart';
import 'package:http/http.dart' as http;

Future<List<Studio>> fetchStudios() async {
  final response = await http.get(Uri.parse('$apiURL/studios/'));
  var json = jsonDecode(response.body)["studios"];
  List<Studio> studios = [];
  for (var review in json) {
    studios.add(Studio.fromJson(review));
  }
  return studios;
}
