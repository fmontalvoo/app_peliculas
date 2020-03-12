import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app_peliculas/src/models/pelicula_model.dart';

class PeliculaProvider {
  String _apiKey = "43330c8aae2221d888abce07daefbb53";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<PeliculaModel>> getEsternos() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    List<PeliculaModel> peliculas = List<PeliculaModel>();
    for (var json in decodeData['results']) {
      peliculas.add(PeliculaModel.fromJson(json));
    }
    return peliculas;
  }
}
