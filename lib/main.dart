import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/API.dart';
import 'package:wallpaper/home_screen.dart';
import 'package:wallpaper/wall_screen.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (context) => API(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wallpaper App",
      darkTheme: ThemeData(
          dialogTheme: DialogTheme(
            titleTextStyle: GoogleFonts.roboto(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  textStyle: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold, fontSize: 16))),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Color.fromRGBO(90, 90, 90, 0.612),
            suffixIconColor: Colors.white,
          ),
          iconButtonTheme: IconButtonThemeData(
              style: IconButton.styleFrom(backgroundColor: Colors.white)),
          listTileTheme: const ListTileThemeData(tileColor: Colors.black12),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color.fromRGBO(85, 77, 86, 100),
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(85, 77, 86, 100),
          textTheme: TextTheme(
              displayMedium: GoogleFonts.raleway(color: Colors.white),
              titleMedium: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400))),
      theme: ThemeData(
        dialogTheme: DialogTheme(
          titleTextStyle: GoogleFonts.roboto(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                textStyle: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold, fontSize: 16))),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[350],
          suffixIconColor: Colors.black,
        ),
        iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(backgroundColor: Colors.black)),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            titleTextStyle: TextStyle(color: Colors.black),
            backgroundColor: Colors.white),
        textTheme: TextTheme(
            displayMedium: GoogleFonts.raleway(color: Colors.black),
            titleMedium: GoogleFonts.raleway(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400)),
        primarySwatch: Colors.blue,
      ),
      routes: {WallScreen.wall_screen: (context) => WallScreen()},
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Center(
            child: Text("Wallpaper",
                style: GoogleFonts.raleway(
                    fontSize: 35, fontWeight: FontWeight.bold)),
          ),
        ),
        body: const HomePage(),
      ),
    );
  }
}
