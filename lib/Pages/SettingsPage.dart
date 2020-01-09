import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      // needed for AndroidTV to be able to select
      shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const Intent(ActivateAction.key)},
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.openSans().fontFamily,
          
        ),
        home: Scaffold(
          body: ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(title: Text('Trakt'), subtitle: Text('Login to Trakt'), onTap: () {},),
                ListTile(title: Text('RD'), subtitle: Text('Login to RealDebrid'), onTap: () {}),
              ]
            ).toList(),
),
        ),
      ),
    );
  }
}