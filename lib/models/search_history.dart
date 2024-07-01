import 'package:hive/hive.dart';

part 'search_history.g.dart';

@HiveType(typeId: 0)
class SearchHistory {
  @HiveField(0)
  String from;

  @HiveField(1)
  String to;

  SearchHistory({required this.from, required this.to});
}
