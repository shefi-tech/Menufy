import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/search_history.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final historyBox = Hive.box<SearchHistory>('searchHistory');

    return Scaffold(
      appBar: AppBar(
        title: Text('Search History'),
      ),
      body: ValueListenableBuilder(
        valueListenable: historyBox.listenable(),
        builder: (context, Box<SearchHistory> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text('No search history'),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                SearchHistory history = box.getAt(index)!;
                return ListTile(
                  title: Text('${history.from} to ${history.to}'),
                  onTap: () {
                    Navigator.pushNamed(context, '/results', arguments: {
                      'from': history.from,
                      'to': history.to,
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
