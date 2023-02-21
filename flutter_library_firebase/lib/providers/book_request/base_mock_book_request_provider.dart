import 'package:fire_library/models/library_book_entity.dart';
import 'package:fire_library/models/request_book_entity.dart';
import 'package:fire_library/providers/book_request/base_book_request_provider.dart';

class MockBookRequestProvider extends BaseBookRequestProvider {
  @override
  Future<void> returnBook(String id) async {}

  @override
  Future<List<RequestBookEntity>> lentBooksByUser(String userId) async {
    return [
      RequestBookEntity(
          bookId: 'book-id-1',
          id: 'id1',
          userId: "user-1",
          libraryId: "library-id-1"),
    ];
  }

  @override
  Future<void> requestBook(
      String bookId, String userId, String libraryId) async {}
}
