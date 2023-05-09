// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'view/DetailScreen.dart';






void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> events = [];

  Future<List<dynamic>> getEvents(String query) async {
    final url =
        'https://api.seatgeek.com/2/events?client_id=MzM1MzI2NTB8MTY4MzU0MDMwNC41MDIyMTU2&q=$query';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return data['events'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeatGeek Events Search',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      setState(() {
                        events.clear();
                      });
                    },
                  ),
                  hintText: 'Search events',
                ),
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    final results = await getEvents(value);
                    setState(() {
                      events = results;
                    });
                  } else {
                    setState(() {
                      events.clear();
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (BuildContext context, int index) {
                  final event = events[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        event['performers'][0]['image'],
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      event['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(DateFormat('EEE, d MMMM yyyy hh:mm a').format(DateTime.parse(event['datetime_local']))),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            title: event['title'],
                            datetimeLocal: event['datetime_local'],
                            imageUrl: event['performers'][0]['image'],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

