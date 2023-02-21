import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_library/models/library_book_entity.dart';
import 'package:fire_library/models/request_book_entity.dart';
import 'package:fire_library/providers/book_request/base_book_request_provider.dart';

const String _requestsCollection = 'requests';

class FirebasekBookRequestProvider extends BaseBookRequestProvider {
  FirebasekBookRequestProvider(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Future<void> returnBook(String id) =>
      firestore.collection(_requestsCollection).doc(id).delete();

  @override
  Future<void> requestBook(String bookId, String userId, String libraryId) =>
      firestore.collection(_requestsCollection).add({
        'bookId': bookId,
        'userId': userId,
        'libraryId': libraryId,
      });

  @override
  Future<List<RequestBookEntity>> lentBooksByUser(String userId) => firestore
      .collection(_requestsCollection)
      .where('userId', isEqualTo: userId)
      .get()
      .then(
        (value) => value.docs
            .map(
              (doc) => RequestBookEntity.fromFirebase(
                doc.id,
                doc.data(),
              ),
            )
            .toList(),
      );
}
