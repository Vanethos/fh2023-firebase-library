import 'package:fire_library/models/book_entity.dart';

abstract class BaseBookProvider {
  Future<List<BookEntity>> getBooks();

  Future<BookEntity> getBookById(String id);

  Future<BookEntity> createBook(
    String name,
    String isbn,
  );
}
