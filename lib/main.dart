import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/results_screen.dart';
import 'screens/history_screen.dart';
import 'models/search_history.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SearchHistoryAdapter());
  await Hive.openBox<SearchHistory>('searchHistory');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/results': (context) => ResultsScreen(),
        '/history': (context) => HistoryScreen(),
      },
    );
  }
}
