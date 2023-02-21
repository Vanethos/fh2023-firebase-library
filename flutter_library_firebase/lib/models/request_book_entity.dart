class RequestBookEntity {
  final String id;
  final String bookId;
  final String libraryId;
  final String userId;

  RequestBookEntity({
    required this.id,
    required this.bookId,
    required this.libraryId,
    required this.userId,
  });

  factory RequestBookEntity.fromFirebase(
          String id, Map<String, dynamic> data) =>
      RequestBookEntity(
        id: id,
        bookId: data['bookId'],
        libraryId: data['libraryId'],
        userId: data['userId'],
      );
}
