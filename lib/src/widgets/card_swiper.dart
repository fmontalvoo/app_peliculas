import 'package:app_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<PeliculaModel> lista;

  const CardSwiper({Key key, @required this.lista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(lista[index].getPosterURL()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover,
              ));
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
