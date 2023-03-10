import 'package:fire_library/models/library_book_entity.dart';
import 'package:fire_library/models/library_entity.dart';

abstract class BaseLibraryProvider {
  Future<List<LibraryEntity>> listLibraries();

  Future<LibraryEntity?> getLibraryById(String id);

  Future<List<LibraryEntity>> getLibraryForCountry(String country);
}
