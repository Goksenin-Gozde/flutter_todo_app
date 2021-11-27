class TodoItem {
  const TodoItem({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  String toString() {
    return title + " " + description;
  }

  bool isValid() {
    return title.isNotEmpty && description.isNotEmpty;
  }
}