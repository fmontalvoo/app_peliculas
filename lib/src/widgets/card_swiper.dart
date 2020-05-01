import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:app_peliculas/src/models/pelicula_model.dart';
import 'package:app_peliculas/src/providers/pelicula_provider.dart';

class CardSwiper extends StatelessWidget {
  final List<PeliculaModel> lista;
  final PeliculaProvider provider;

  const CardSwiper({@required this.lista, this.provider});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          lista[index].uid = '${lista[index].id}s';
          return Hero(
            tag: lista[index].uid,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  child: FadeInImage(
                    image: NetworkImage(lista[index].getPosterURL()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'detalle', arguments: {
                      'pelicula': lista[index],
                      'provider': provider
                    });
                  },
                )),
          );
        },
        itemCount: lista.length,
        itemWidth: _screenSize.width * .6,
        itemHeight: _screenSize.height * .5,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}
