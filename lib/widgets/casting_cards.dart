

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {

  final int movieId;
  

  const CastingCards({ required this.movieId }); 

  @override
  Widget build(BuildContext context) {

  final moviesProvider = Provider.of<MoviesProvider>(context, listen:false);
  
  return FutureBuilder(
    future: moviesProvider.getMovieCast(movieId),
    builder: ( _ , AsyncSnapshot<List<Cast>> snapshot) {

      if ( !snapshot.hasData ){
        return Container(
          height: 180,
          child: const CupertinoActivityIndicator(),
        );
      }

      final List<Cast> cast = snapshot.data!;//almacenamos la lista de los actores de una pelicula
      
        return Container(
          width: double.infinity,
          height: 200,
          margin: EdgeInsets.only(bottom: 30),
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ( __ , int index) =>_CastCard(actor:cast[index])//al darle el index le decimos la posicion de la lista del actor
            ),                                                          // Y accedemos a todo el json de ese actor
        );
    },
  );

   
  }
}

class _CastCard extends StatelessWidget {
  
  final Cast actor;

  const _CastCard({super.key, 
  required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:10),
      width: 110,
      height: 120,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(actor.fullProfilePath),
                height: 160,
                fit: BoxFit.cover
                ),
          ),

          const SizedBox(height: 5),

          Text(actor.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,)
        ],
      ),      
     );
  }
}
