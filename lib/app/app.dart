import 'package:dazone/app/router/generate_route_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Dazone extends StatelessWidget with GenerateRouteMixin {
  const Dazone({super.key});

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
      onGenerateRoute: onGenerateRoute,
    );
  }
}