import 'package:fire_library/models/library_book_entity.dart';
import 'package:fire_library/models/library_entity.dart';
import 'package:fire_library/providers/library/base_library_provider.dart';

class MockLibraryProvider extends BaseLibraryProvider {
  final _mockData = <String, LibraryEntity>{
    'lib-id-1': LibraryEntity(
      id: 'lib-id-1',
      books: <LibraryBookEntity>[
        LibraryBookEntity(
          id: 'book-id-1',
          quantity: 2,
        ),
      ],
      city: 'Montijo',
      name: 'Biblioteca Municipal',
      country: 'Portugal',
    ),
    'lib-id-2': LibraryEntity(
      id: 'lib-id-2',
      books: <LibraryBookEntity>[],
      city: 'Torino',
      name: 'Public Library of Torino',
      country: 'Italy',
    ),
  };

  @override
  Future<List<LibraryEntity>> listLibraries() async =>
      _mockData.values.toList();

  @override
  Future<LibraryEntity> getLibraryById(String id) async => _mockData[id]!;

  @override
  Future<List<LibraryEntity>> getLibraryForCountry(String country) async => [
        _mockData[country]!,
      ];

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
