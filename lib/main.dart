import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:movies_app/themes/themes.dart';
import 'package:provider/provider.dart';


void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => MoviesProvider(),lazy: false,) //*lazy hace referencia a que este en modo peresoso o no.
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: AppTheme.lightTheme,
      initialRoute: 'home',
      routes: {
        'home'    :  ( _ ) =>  const HomeScreen(),
        'details' :  ( _ ) =>  const DetailsScreen() 
      },
      
    );
  }
}