import 'package:app_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:app_peliculas/src/providers/pelicula_provider.dart';

class SearchData extends SearchDelegate {
  final PeliculaProvider provider = PeliculaProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
        future: provider.getByName(query),
        builder: (BuildContext context,
            AsyncSnapshot<List<PeliculaModel>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterURL()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: () {
                    close(context, null);
                    pelicula.uid = '';
                    Navigator.pushNamed(context, 'detalle', arguments: {
                      'pelicula': pelicula,
                      'provider': provider
                    });
                  },
                );
              }).toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
