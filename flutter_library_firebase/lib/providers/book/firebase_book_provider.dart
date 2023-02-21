import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_library/models/book_entity.dart';
import 'package:fire_library/providers/book/base_book_provider.dart';

const String _libraryCollection = 'books';

class FirebaseBookProvider extends BaseBookProvider {
  FirebaseBookProvider(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Future<List<BookEntity>> getBooks() async => firestore
      .collection(_libraryCollection)
      .get()
      .then((collection) => collection.docs)
      .then(
        (value) => value
            .map(
              (doc) => BookEntity.fromFirebase(
                doc.id,
                doc.data(),
              ),
            )
            .toList(),
      );

  @override
  Future<BookEntity> getBookById(String id) async =>
      firestore.collection(_libraryCollection).doc(id).get().then(
            (value) => BookEntity.fromFirebase(
              value.id,
              value.data()!,
            ),
          );

  @override
  Future<BookEntity> createBook(
    String name,
    String isbn,
  ) async {
    throw UnimplementedError('To implement later');
  }
}
