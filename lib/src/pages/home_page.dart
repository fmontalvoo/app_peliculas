import 'package:flutter/material.dart';
import 'package:app_peliculas/src/widgets/card_swiper.dart';
import 'package:app_peliculas/src/widgets/horizontal_list.dart';
import 'package:app_peliculas/src/providers/pelicula_provider.dart';

class HomePage extends StatelessWidget {
  final PeliculaProvider provider = PeliculaProvider();

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperTarjetas(), _footer(context)],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: provider.getEsternos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return CardSwiper(lista: snapshot.data, provider: provider);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          );
        });
  }

  Widget _footer(BuildContext context) {
    provider.getPopulares();
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
              stream: provider.getPopularesStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData)
                  return HorizontalList(
                    lista: snapshot.data,
                    cargarData: provider.getPopulares,
                    provider: provider,
                  );
                return Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}
