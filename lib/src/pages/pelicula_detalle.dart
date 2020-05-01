import 'package:flutter/material.dart';
import 'package:app_peliculas/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PeliculaModel pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            _appBar(pelicula),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 20.0),
              _encabezado(context, pelicula),
              _descripcion(pelicula),
            ]))
          ],
        ),
      ),
    );
  }

  Widget _appBar(PeliculaModel pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      // backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackdropPath()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _encabezado(BuildContext context, PeliculaModel pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterURL()),
              height: 150.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pelicula.title,
                style: Theme.of(context).textTheme.title,
                overflow: TextOverflow.ellipsis,
              ),
              Text(pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle),
              Row(
                children: <Widget>[
                  Icon(Icons.star),
                  Text(pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(PeliculaModel pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
