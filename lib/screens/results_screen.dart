import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late MapboxMapController mapController;
  late String from;
  late String to;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    from = args['from']!;
    to = args['to']!;
  }

  void onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('From: $from'),
                Text('To: $to'),
                // Add additional UI elements such as distance, time, and step-by-step directions here
                ElevatedButton(
                  onPressed: () {
                    // Save functionality implementation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Search saved')),
                    );
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
