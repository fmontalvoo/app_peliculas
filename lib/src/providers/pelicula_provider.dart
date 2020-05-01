import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app_peliculas/src/models/pelicula_model.dart';

class PeliculaProvider {
  String _apiKey = "43330c8aae2221d888abce07daefbb53";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  int _popularesPage = 0;
  bool _cargando = false;

  List<PeliculaModel> _populares = List();

  // Inicia el flujo de datos, y lo prepara para que varios widgets lo usen.
  final _popularesStream = StreamController<List<PeliculaModel>>.broadcast();

  // Ingresa datos al stream.
  Function(List<PeliculaModel>) get getPopularesSink =>
      _popularesStream.sink.add;

  // Recupera los datos del stream.
  Stream<List<PeliculaModel>> get getPopularesStream => _popularesStream.stream;

  // Cierra los stream.
  void disposeStream() {
    _popularesStream?.close();
  }

  Future<List<PeliculaModel>> getEsternos() async {
    final uri = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return _procesarPeticion(uri);
  }

  Future<List<PeliculaModel>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;

    _popularesPage++;
    final uri = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final respuesta = await _procesarPeticion(uri);

    _populares.addAll(respuesta);
    getPopularesSink(_populares);

    _cargando = false;
    return respuesta;
  }

  Future<List<PeliculaModel>> _procesarPeticion(Uri uri) async {
    final response = await http.get(uri);

    final decodeData = json.decode(response.body);

    List<PeliculaModel> peliculas = List<PeliculaModel>();

    for (var json in decodeData['results']) {
      peliculas.add(PeliculaModel.fromJson(json));
    }

    return peliculas;
  }
}
