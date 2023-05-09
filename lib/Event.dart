class Event {
  final String id;
  final String title;
  final DateTime datetimeLocal;
  final String imageUrl;

  Event({
    required this.id,
    required this.title,
    required this.datetimeLocal,
    required this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final performerJson = json['performers'][0];
    final title = json['title'] as String;
    final id = json['id'].toString();
    final datetimeLocal = DateTime.parse(json['datetime_local'] as String);
    final imageUrl = performerJson['image'] as String;
    return Event(
      id: id,
      title: title,
      datetimeLocal: datetimeLocal,
      imageUrl: imageUrl,
    );
  }
}
