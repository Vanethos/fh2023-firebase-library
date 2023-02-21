class BookEntity {
  final String id;
  final String isbn;
  final String? name;
  final String? author;
  final String? description;
  final String? coverImage;

  BookEntity({
    required this.id,
    required this.isbn,
    this.name,
    this.author,
    this.description,
    this.coverImage,
  });

  factory BookEntity.fromFirebase(
    String id,
    Map<String, dynamic> data,
  ) =>
      BookEntity(
        id: id,
        isbn: data['isbn'],
        name: data['name'],
        author: data['author'],
        description: data['description'],
        coverImage: data['coverImage'],
      );
}
