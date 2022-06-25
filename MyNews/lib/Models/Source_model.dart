// ignore_for_file: file_names

class Source {
  String id = '';
  String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      return Source(id: json['id'], name: json['name']);
    } else {
      return Source(id: '1', name: json['name']);
    }
  }
}
