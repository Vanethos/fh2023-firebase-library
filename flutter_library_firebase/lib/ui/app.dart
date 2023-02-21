import 'package:fire_library/providers/auth/base_auth_provider.dart';
import 'package:fire_library/providers/book/base_book_provider.dart';
import 'package:fire_library/providers/book_request/base_book_request_provider.dart';
import 'package:fire_library/providers/library/base_library_provider.dart';
import 'package:fire_library/ui/navigation/navigation.dart';
import 'package:flutter/material.dart';

class LibraryApp extends StatelessWidget {
  const LibraryApp({
    required this.authProvider,
    required this.bookProvider,
    required this.libraryProvider,
    required this.bookRequestProvider,
    super.key,
  });

  final BaseAuthProvider authProvider;

  final BaseBookProvider bookProvider;

  final BaseLibraryProvider libraryProvider;

  final BaseBookRequestProvider bookRequestProvider;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      routerConfig: navigationRouter(
        authProvider,
        bookProvider,
        libraryProvider,
        bookRequestProvider,
      ),
    );
  }
}
