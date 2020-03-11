import 'package:flutter/material.dart';
import 'package:app_peliculas/src/widgets/card_swiper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[_crearSwiper()],
        ),
      ),
    );
  }

  Widget _crearSwiper() {
    return CardSwiper(lista: null);
  }
}
