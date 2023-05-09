import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String datetimeLocal;
  final String imageUrl;

  const DetailsScreen({
    Key? key,
    required this.title,
    required this.datetimeLocal,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Image.network(imageUrl),
          Text(datetimeLocal),
        ],
      ),
    );
  }
}
