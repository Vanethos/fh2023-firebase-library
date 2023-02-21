import 'package:fire_library/providers/auth/mock_auth_provider.dart';
import 'package:fire_library/providers/book/mock_book_provider.dart';
import 'package:fire_library/providers/book_request/base_mock_book_request_provider.dart';
import 'package:fire_library/providers/library/mock_library_provider.dart';
import 'package:fire_library/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void main() {
  /// TODO(GP): Change to Firebase implementation here
  final authProvider = MockAuthProvider();
  final bookProvider = MockBookProvider();
  final libraryPvodier = MockLibraryProvider();
  final bookRequestProvider = MockBookRequestProvider();

  runApp(
    LibraryApp(
      authProvider: authProvider,
      bookProvider: bookProvider,
      libraryProvider: libraryPvodier,
      bookRequestProvider: bookRequestProvider,
    ),
  );
}
