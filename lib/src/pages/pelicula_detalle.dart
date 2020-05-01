import 'package:app_peliculas/src/models/actor_model.dart';
import 'package:flutter/material.dart';
import 'package:app_peliculas/src/models/pelicula_model.dart';
import 'package:app_peliculas/src/providers/pelicula_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments;

    final PeliculaModel pelicula = arguments['pelicula'];
    final PeliculaProvider provider = arguments['provider'];

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
              _casting(pelicula, provider)
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
          Hero(
            tag: pelicula.uid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterURL()),
                height: 150.0,
              ),
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

  Widget _casting(PeliculaModel pelicula, PeliculaProvider provider) {
    return FutureBuilder(
        future: provider.getCast(pelicula.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) return _castingPageView(snapshot.data);
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _castingPageView(List<ActorModel> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: .3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, index) {
          return _tarjeta(context, actores[index]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, ActorModel actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getProfilePath()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
