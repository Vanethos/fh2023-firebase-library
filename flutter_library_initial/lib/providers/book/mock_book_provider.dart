import 'package:fire_library/models/book_entity.dart';
import 'package:fire_library/providers/book/base_book_provider.dart';

class MockBookProvider extends BaseBookProvider {
  final _mockData = <String, BookEntity>{
    'book-id-1': BookEntity(
      id: 'book-id-1',
      name: 'Flutter for Heroes',
      isbn: 'abc-def-ghe',
      author: 'Dash',
      description: 'A hero for Flutter has arisen!',
      coverImage: 'https://loremflickr.com/200/200',
    ),
    'book-id-2': BookEntity(
      id: 'book-id-2',
      name: 'Oh no! The overflow attacks again',
      isbn: 'ghj-lki-ope',
      author: 'Render Boxes',
      description:
          'What has happened? A render overflow? Who is going to save the day?',
      coverImage: 'https://loremflickr.com/200/200',
    ),
    'book-id-3': BookEntity(
      id: 'book-id-3',
      name: 'Oh no! The overflow attacks again',
      isbn: 'hft-wer-opr',
      author: 'Render Boxes',
      description:
          'What has happened? A render overflow? Who is going to save the day?',
      coverImage: 'https://loremflickr.com/200/200',
    ),
    'book-id-4': BookEntity(
      id: 'book-id-4',
      name: 'Impeller by Dawn',
      isbn: 'qer-kty-uan',
      author: 'Skia',
      description:
          'A rendering framework finds itself in a conundrum - who is going to replace her?',
      coverImage: 'https://loremflickr.com/200/200',
    ),
  };

  @override
  Future<List<BookEntity>> getBooks() async => _mockData.values.toList();

  @override
  Future<BookEntity> getBookById(String id) async => _mockData[id]!;

  @override
  Future<BookEntity> createBook(
    String name,
    String isbn,
  ) async =>
      _mockData.values.last;
}
