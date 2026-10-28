class Item {
  final String title;
  final String description;
  final String category; // Misal: AI & Machine Learning, Cloud & DevOps, dll.
  final bool isImportant; // Flag Critical / Production Ready

  Item({
    required this.title,
    required this.description,
    required this.category,
    this.isImportant = false,
  });
}
