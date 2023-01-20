import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({super.key, 
  
  required this.movies, 
  required this.onNextPage,
  this.title 
  
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollControler =  new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollControler.addListener(() { 

      if (scrollControler.position.pixels>=scrollControler.position.maxScrollExtent-300){
        this.widget.onNextPage();
      };

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          if (this.widget.title!=null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(this.widget.title! ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),

          const SizedBox( height :5),
          
          Expanded(
            child: ListView.builder(
              controller: scrollControler,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,                                  
              itemBuilder: ( __, int index)=>_MoviePoster(widget.movies[index],'${ widget.title }-${ index }-${widget.movies[index].id}') //iterador de peliculas por peliculas
              ),                                                               //?Este segundo argumento es un tag unico para evitar el triagulamiento de tags hero
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _MoviePoster( this.movie, this.heroId );

  @override
  Widget build(BuildContext context) { 
    
    movie.heroId = heroId;
    
    return Container(
        width: 130,
        height: 200,
        margin: const EdgeInsets.only(left: 10,right: 10, top: 10),
        child: Column(
          children: [

            GestureDetector(
              onTap: ()=>Navigator.pushNamed(context, 'details',arguments: movie),
              child: Hero(
                tag: movie.heroId!,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: 
                    BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 255, 255),
                        blurRadius:5,
                        offset:Offset(0, -5)
                        //spreadRadius:1 
                  ),
                ],
              ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:  FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'), 
                      image: NetworkImage(movie.fullPosterImage),
                      width: 130,
                      height: 190,
                      fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),

            const SizedBox( height :5),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ),
  //       decoration: BoxDecoration(
  //           color: Colors.indigo,
  //           borderRadius: BorderRadius.circular(20),
  //               boxShadow: [
  //                 BoxShadow(
  //                 color: Colors.indigoAccent.withOpacity(0.6),
  //                 spreadRadius: 2,
  //                 blurRadius: 6,
  //                 offset: Offset(0, 3), // changes position of shadow
  //               ),
  //             ],
  // ),
                );
  }
}