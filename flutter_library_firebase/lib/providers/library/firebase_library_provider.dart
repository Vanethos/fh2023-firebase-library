import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_library/main.dart';
import 'package:fire_library/models/library_book_entity.dart';
import 'package:fire_library/models/library_entity.dart';
import 'package:fire_library/providers/library/base_library_provider.dart';

const String _libraryCollection = 'libraries';

class FirebaseLibraryProvider extends BaseLibraryProvider {
  final FirebaseFirestore firestore;

  FirebaseLibraryProvider(this.firestore);

  @override
  Future<List<LibraryEntity>> listLibraries() async {
    late Future<List<LibraryEntity>> result;

    try {
      result = firestore
          .collection(_libraryCollection)
          .get()
          .then((collection) => collection.docs)
          .then(
            (value) => value
                .map(
                  (doc) => LibraryEntity.fromFirebase(
                    doc.id,
                    doc.data(),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      logger.e(e);
    }

    return result;
  }

  @override
  Future<LibraryEntity?> getLibraryById(String id) async =>
      firestore.collection(_libraryCollection).doc(id).get().then((doc) {
        final data = doc.data();
        if (data == null) {
          return null;
        }

        return LibraryEntity.fromFirebase(doc.id, data);
      });

  @override
  Future<List<LibraryEntity>> getLibraryForCountry(String country) async => [];

  @override
  Future<void> returnBook(String id, String userId) async {}

  @override
  Future<List<LibraryBookEntity>> lentBooksByUser(String userId) async {
    return [
      LibraryBookEntity(id: 'book-id-1', quantity: 1),
    ];
  }

  @override
  Future<void> requestBook(String id, String userId) async {}
}
