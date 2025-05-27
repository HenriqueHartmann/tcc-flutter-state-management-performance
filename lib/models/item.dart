class Item {
  final int id;
  final String title;
  final String description;

  Item({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['overview'] as String,
    );
  }
}
