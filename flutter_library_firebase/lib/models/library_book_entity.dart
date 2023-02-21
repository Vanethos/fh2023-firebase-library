class LibraryBookEntity {
  final String id;
  final int quantity;

  LibraryBookEntity({
    required this.id,
    required this.quantity,
  });

  factory LibraryBookEntity.fromFirebase(Map<String, dynamic> data) =>
      LibraryBookEntity(
        id: data['id'],
        quantity: data['quantity'],
      );
}
