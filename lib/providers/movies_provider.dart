
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{                        //!PARA SABER SOBRE PETICIONES HTTP
                                                                    //!ingresar en: https://pub.dev/packages/http/example
  final String _apiKey   = 'eaaf28d05ee30b5547c052d8f8439922' ;
  final String _baseUrl  = 'api.themoviedb.org' ;
  final String _language = 'es-ES' ;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies   = [];

  Map<int,List <Cast>> moviesCast = {};//Mapa donde la llave es el Id Movie y el valor es el listado de actores por pelicula

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500));

  final  StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();//esto no es un stream es el streamController
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;


  MoviesProvider(){
    print('MoviesProvider inicializado');
  
    this.getOnDisplayMovies();
    this.getPopularMovies();
     
  }

  Future<String> _getJsonData( String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
    'api_key'  : _apiKey,
    'language' : _language,
    'page'     : '$page'
    
    });

  // Await the http get response, then decode the json-formatted response.
  final response = await http.get(url);
  return response.body; 


  }


  getOnDisplayMovies() async {
    
    final jsonData           = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    
    onDisplayMovies = nowPlayingResponse.results; 
    
    notifyListeners();
    //print( nowPlayingResponse.results[1].title );
    }

  getPopularMovies() async{
    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular',_popularPage);
    
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies         = [...popularMovies,...popularResponse.results]; 
    notifyListeners();   
    }

  Future<List<Cast>>getMovieCast(int movieId, ) async{
    
    if (moviesCast.containsKey(movieId)) return moviesCast[ movieId ]!;
    
    print('pidiendo info al servidor - Cast');

    final jsonData        = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson( jsonData );

    moviesCast[ movieId ] = creditsResponse.cast;

    return creditsResponse.cast;
  
  }

  Future<List<Movie>> searchMovies( String query) async{
    final url = Uri.https(_baseUrl, '3/search/movie', {
    'api_key'  : _apiKey,
    'language' : _language,
    'query'     : query 
    });
    final response = await http.get(url);
    final searchResponse =  SearchResponse.fromJson(response.body);
    
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm ){

    debouncer.value="";
    debouncer.onValue= ( value ) async{
    // print("Tenemos Valor a buscar: $value ");
    final results = await this.searchMovies( value );
    this._suggestionStreamController.add( results );
    
    };  
    final timer = Timer.periodic(const Duration(milliseconds:300), ( _ ) { 

      debouncer.value = searchTerm;
    });

    Future.delayed( const Duration(milliseconds: 301)).then(( _ )=>timer.cancel());

    

  }

  }