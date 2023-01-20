

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';


class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    super.key, 
    required this.movies}); 
   
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of( context ).size;
    
    if (this.movies.length== 0){
      return Container(
        width  : double.infinity,
        height : size.height * 0.5 ,
        child: Center(
          child: CircularProgressIndicator()),
      );
    }

    return Container(
      width  : double.infinity,
      height : size.height * 0.5 ,
      child  : Swiper(
        itemCount : movies.length,                    //*****MATERIAL ADJUNTO PARA LAS SWIPED_CARDS******
        layout    : SwiperLayout.STACK,               //?   https://pub.dev/packages/card_swiper
        itemWidth   : size.width * 0.6,
        itemHeight  : size.height * 0.4,
        itemBuilder : (BuildContext context, int index){
          
          final movie = movies[index];

        movie.heroId = 'cardSwiper-${ movie.id }';

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: 
                    BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 255, 255),
                        blurRadius:15,
                        offset:Offset(0, 0)
                        //spreadRadius:1 
                  ),
                ],
              ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:  FadeInImage(
                    image: NetworkImage( movie.fullPosterImage ),
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    fit: BoxFit.cover, 
                    ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}