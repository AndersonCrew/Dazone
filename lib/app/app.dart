import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Dazone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dazone Base",
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
        Locale('vi'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const Scaffold(
        body: Center(
          child: Text("Dazone Base"),
        ),
      ),
    );
  }
}