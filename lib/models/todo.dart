class Todo {
  int? id;
  String title;
  String description;

  Todo({this.id, required this.title, required this.description});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": description,
      "userId": 1,
    };
  }
}