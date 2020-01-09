import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:chillyflix/Services/FanartService.dart';
import 'package:chillyflix/Pages/HomePage.dart';
import 'package:chillyflix/Services/TraktService.dart';

extension Precision on double {
      double toPrecision(int fractionDigits) {
      double mod = pow(10, fractionDigits.toDouble());
      return ((this * mod).round().toDouble() / mod);
    }
}


void main() {
  return runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TraktService>(create: (_) => TraktService()),
        Provider<FanartService>(create: (_) => FanartService()),
      ],
      child: Shortcuts(
        // needed for AndroidTV to be able to select
        shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const Intent(ActivateAction.key)},
        child: MaterialApp(
          title: 'ChillyFlix',
          theme: ThemeData(
            fontFamily: GoogleFonts.openSans().fontFamily,
            primarySwatch: Colors.blueGrey,
            backgroundColor: Color.fromARGB(255, 35, 40, 50)
          ),
          home: HomePage(title: 'ChillyFlix'),
        ),
      ),
    );
  }
}