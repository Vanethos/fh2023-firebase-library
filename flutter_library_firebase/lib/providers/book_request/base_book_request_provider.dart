import 'package:fire_library/models/library_book_entity.dart';
import 'package:fire_library/models/request_book_entity.dart';

abstract class BaseBookRequestProvider {
  Future<void> returnBook(String id);

  Future<void> requestBook(String bookId, String userId, String libraryId);

  Future<List<RequestBookEntity>> lentBooksByUser(String userId);
}
