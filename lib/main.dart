import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:movies_app/themes/themes.dart';
import 'package:provider/provider.dart';

import 'themes/theme_provider.dart';


void main() { 
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(AppState());}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => MoviesProvider(),lazy: false,), //*lazy hace referencia a que este en modo peresoso o no.
        ChangeNotifierProvider(create: (context)=>ThemeProvider())
      ],
     child: const MyApp(),
    );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
      initialRoute: 'home',
      routes: {
        'home'    :  ( _ ) =>  const HomeScreen(),
        'details' :  ( _ ) =>  const DetailsScreen() 
      },
      
    );
  }
}