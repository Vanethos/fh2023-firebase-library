class BookEntity {
  final String id;
  final String name;
  final String isbn;
  final String author;
  final String description;
  final String? coverImage;

  BookEntity({
    required this.id,
    required this.name,
    required this.isbn,
    required this.author,
    required this.description,
    this.coverImage,
  });
}
