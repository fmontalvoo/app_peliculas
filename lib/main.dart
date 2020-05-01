import 'package:app_peliculas/src/pages/pelicula_detalle.dart';
import 'package:flutter/material.dart';
import 'package:app_peliculas/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'detalle': (context) => PeliculaDetalle()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
