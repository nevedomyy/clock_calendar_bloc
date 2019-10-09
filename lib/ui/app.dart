import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'clock_calendar.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
      ],
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white, fontSize: 16.0),
          body2: TextStyle(color: Colors.white, fontSize: 20.0)
        )
      ),
      home: ClockCalendar(),
    );
  }
}
