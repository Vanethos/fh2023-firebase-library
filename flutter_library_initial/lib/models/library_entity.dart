import 'package:fire_library/models/library_book_entity.dart';

class LibraryEntity {
  final String id;
  final String name;
  final String country;
  final String city;
  final List<LibraryBookEntity> books;

  /// TODO(GP): See the best way to optimize
  /// data finding here, bascially we want a list
  /// of all the lent books and to which user.
  /// Should this be a new service?

  LibraryEntity({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    required this.books,
  });
}
