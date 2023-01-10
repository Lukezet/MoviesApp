import 'package:flutter/material.dart';

import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/search/search_delegate.dart';
import 'package:movies_app/widgets/widgets.dart';



class HomeScreen extends StatelessWidget {
   
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context); 


    return  Scaffold(
      
      appBar: AppBar(
        title: const Text('Peliculas en Cine'),
        centerTitle: true,
        elevation:0,
        actions: [
          IconButton(
            icon: const Icon(Icons.saved_search_outlined,size: 30),
            padding:const EdgeInsets.only(right: 5),
            onPressed: ()=>showSearch(context: context, delegate: MovieSearchDelegate()),)
        ],),
      
      
      body: SingleChildScrollView(
        child: Column(
      
          children: [
            //Tarjetas Principales - CardSwiper 
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //Slider de peliculas
            MovieSlider( 
              movies: moviesProvider.popularMovies,
              title: 'Populares' ,
              onNextPage:()=> moviesProvider.getPopularMovies(),),
     
          ],

        ),

      )
    );
  }
}