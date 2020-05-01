import 'package:flutter/material.dart';

import 'package:app_peliculas/src/models/pelicula_model.dart';

class HorizontalList extends StatelessWidget {
  final List<PeliculaModel> lista;
  final Function cargarData;

  const HorizontalList({@required this.lista, this.cargarData});

  @override
  Widget build(BuildContext context) {
    final _pageController =
        PageController(initialPage: 1, viewportFraction: .3);

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 250) cargarData();
    });

    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * .3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: lista.length,
        itemBuilder: (context, index) => _tarjeta(context, lista[index]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, PeliculaModel pelicula) {
    final tarjeta = Container(
      margin: EdgeInsets.only(left: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(pelicula.getPosterURL()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 160,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}
