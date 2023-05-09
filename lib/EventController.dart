import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


import 'Event.dart';

class EventController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> searchEvents(String query) async {
    final url = 'https://api.seatgeek.com/2/events?'
        'client_id=MzM1MzI2NTB8MTY4MzU0MDMwNC41MDIyMTU2&q=$query';
    final response = await http.get(Uri.parse(url));
    final data = await json.decode(response.body);
    final eventsJson = data['events'] as List<dynamic>;
    final events = eventsJson.map((eventJson) => Event.fromJson(eventJson)).toList();
    _events = events;
    notifyListeners();
  }

  Future<void> clearSearch() async {
    searchController.clear();
    _events.clear();
    notifyListeners();
  }

  Future<Event> getEventDetails(Event event) async {
    final url = 'https://api.seatgeek.com/2/events/${event.id}?'
        'client_id=MzM1MzI2NTB8MTY4MzU0MDMwNC41MDIyMTU2';
    final response = await http.get(Uri.parse(url));
    final data = await json.decode(response.body);
    return Event.fromJson(data);
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('EEE, d MMMM yyyy hh:mm a').format(dateTime);
  }
}
