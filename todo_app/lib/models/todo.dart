class Todo {
  final int id;
  final String contents;

  Todo({
    required this.id,
    required this.contents,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      contents: json['contents'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contents': contents,
    };
  }

  Todo copyWith({
    int? id,
    String? contents,
  }) {
    return Todo(
      id: id ?? this.id,
      contents: contents ?? this.contents,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
} 