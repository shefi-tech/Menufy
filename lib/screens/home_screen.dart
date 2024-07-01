import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:hive/hive.dart';
import '../models/search_history.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  late MapboxMapController mapController;
  late String fromLocation = '';
  late String toLocation = '';
  late Box<SearchHistory> historyBox;

  @override
  void initState() {
    super.initState();
    historyBox = Hive.box<SearchHistory>('searchHistory');
  }

  void onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void navigate() {
    if (fromLocation.isNotEmpty && toLocation.isNotEmpty) {
      Navigator.pushNamed(context, '/results', arguments: {
        'from': fromLocation,
        'to': toLocation,
      });
    }
  }

  void saveSearch() {
    if (fromLocation.isNotEmpty && toLocation.isNotEmpty) {
      var history = SearchHistory(from: fromLocation, to: toLocation);
      historyBox.add(history);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Search saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Finder'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: fromController,
              decoration: InputDecoration(labelText: 'From'),
              onChanged: (value) => fromLocation = value,
            ),
            TextField(
              controller: toController,
              decoration: InputDecoration(labelText: 'To'),
              onChanged: (value) => toLocation = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: navigate,
              child: Text('Navigate'),
            ),
            ElevatedButton(
              onPressed: saveSearch,
              child: Text('Save Search'),
            ),
            Expanded(
              child: MapboxMap(
                accessToken: 'pk.eyJ1IjoiYWtoaWxsZXZha3VtYXIiLCJhIjoiY2x4MDcwYzZ4MGl2aTJqcmFxbXZzc3lndiJ9.9sxfvrADlA25b1CHX2VuDA',
                onMapCreated: onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.7749, -122.4194), // Default location (San Francisco)
                  zoom: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
