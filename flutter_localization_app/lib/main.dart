import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'customlocalizations.dart';

void main() {runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Internationalization Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        CustomLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      home: const MyHomePage(title: 'Flutter Internationalization Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(CustomLocalizations.of(context)!.title.toString()),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(CustomLocalizations.of(context)!.message.toString(),),
          ],
        ),
      ),
    );
  }
}