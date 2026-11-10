class TodoModel {
  final int id;
  final String name;
  final String description;
  final bool isDone;

  TodoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isDone,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] is int
          ? json['id'] as int
          : (int.tryParse(json['id']?.toString() ?? '0') ?? 0),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isDone: json['is_done'] is bool
          ? json['is_done'] as bool
          : (json['is_done'] == 1 || json['is_done'] == 'true'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'is_done': isDone,
    };
  }
}
