import 'package:fire_library/models/library_book_entity.dart';
import 'package:fire_library/models/library_entity.dart';

abstract class BaseLibraryProvider {
  Future<List<LibraryEntity>> listLibraries();

  Future<LibraryEntity> getLibraryById(String id);

  Future<List<LibraryEntity>> getLibraryForCountry(String country);

  Future<void> returnBook(String id, String userId);

  Future<void> requestBook(String id, String userId);

  Future<List<LibraryBookEntity>> lentBooksByUser(String userId);
}
