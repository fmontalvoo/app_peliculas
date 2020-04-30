import 'package:flutter/material.dart';

import 'package:app_peliculas/src/models/pelicula_model.dart';

class HorizontalList extends StatelessWidget {
  final List<PeliculaModel> lista;

  const HorizontalList({@required this.lista});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * .3,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: .3),
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return this.lista.map((pelicula) {
      return Container(
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
    }).toList();
  }
}
