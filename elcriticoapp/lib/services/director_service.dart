import 'dart:convert';
import 'package:elcriticoapp/models/director.dart';
import 'package:elcriticoapp/shared/constants.dart';
import 'package:http/http.dart' as http;

Future<List<Director>> fetchDirectors() async {
  final response = await http.get(Uri.parse('$apiURL/directors/'));
  var directorList = jsonDecode(response.body)["directors"];
  List<Director> directors = [];
  for (var director in directorList) {
    directors.add(Director.fromJson(director));
  }
  return directors;
}
