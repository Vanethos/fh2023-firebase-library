import 'package:fire_library/models/book_entity.dart';
import 'package:fire_library/models/library_entity.dart';
import 'package:fire_library/providers/auth/base_auth_provider.dart';
import 'package:fire_library/providers/book/base_book_provider.dart';
import 'package:fire_library/providers/book_request/base_book_request_provider.dart';
import 'package:fire_library/providers/library/base_library_provider.dart';
import 'package:fire_library/ui/widgets/library_navigation_rail.dart';
import 'package:flutter/material.dart';

class LibraryDetailPage extends StatelessWidget {
  const LibraryDetailPage({
    required this.libraryProvider,
    required this.bookProvider,
    required this.authProvider,
    required this.requestBookProvider,
    required this.id,
    super.key,
  });

  final BaseLibraryProvider libraryProvider;
  final BaseBookProvider bookProvider;
  final BaseAuthProvider authProvider;
  final BaseBookRequestProvider requestBookProvider;

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LibraryNavigationRail(
        currentPage: NavigationRailDestinationsEnum.libraries,
        child: FutureBuilder<LibraryEntity?>(
          future: libraryProvider.getLibraryById(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "No Data",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "No Data",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.red,
                      ),
                ),
              );
            }

            final books = snapshot.data!.books;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Welcome to ${snapshot.data!.name}",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) => FutureBuilder<BookEntity>(
                        future: bookProvider.getBookById(
                          books[index].id,
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Card(
                              color: Colors.amber.withOpacity(0.8),
                              child: const ListTile(
                                dense: true,
                                title: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                )),
                              ),
                            );
                          }
                          return LibraryBookWidget(
                            book: snapshot.data!,
                            quantity: books[index].quantity,
                            action: () => requestBookProvider.requestBook(
                              snapshot.data!.id,
                              authProvider.currentUser()!.id,
                              id,
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LibraryBookWidget extends StatelessWidget {
  const LibraryBookWidget({
    required this.book,
    required this.quantity,
    required this.action,
    super.key,
  });

  final BookEntity book;

  final VoidCallback action;

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: quantity > 0
          ? Colors.green.withOpacity(0.4)
          : Colors.red.withOpacity(0.4),
      child: ListTile(
        leading: book.coverImage == null || book.coverImage!.isEmpty
            ? null
            : Image.network(
                book.coverImage!,
                fit: BoxFit.contain,
                height: 80.0,
              ),
        title: Text(
          book.name ?? 'Undifined',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
            'Author: ${book.author}, ISBN: ${book.isbn}, Quantity: $quantity'),
        trailing: quantity > 0
            ? Tooltip(
                message: 'Request Book',
                child: IconButton(
                  icon: const Icon(
                    Icons.download,
                  ),
                  onPressed: action,
                ),
              )
            : null,
      ),
    );
  }
}
