import 'package:fire_library/models/book_entity.dart';
import 'package:fire_library/models/library_book_entity.dart';
import 'package:fire_library/models/request_book_entity.dart';
import 'package:fire_library/providers/auth/base_auth_provider.dart';
import 'package:fire_library/providers/book/base_book_provider.dart';
import 'package:fire_library/providers/book_request/base_book_request_provider.dart';
import 'package:fire_library/providers/library/base_library_provider.dart';
import 'package:fire_library/ui/widgets/library_navigation_rail.dart';
import 'package:flutter/material.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({
    required this.bookProvider,
    required this.libraryProvider,
    required this.authProvider,
    required this.requestBookProvider,
    super.key,
  });

  final BaseBookProvider bookProvider;
  final BaseLibraryProvider libraryProvider;
  final BaseAuthProvider authProvider;
  final BaseBookRequestProvider requestBookProvider;

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LibraryNavigationRail(
        currentPage: NavigationRailDestinationsEnum.books,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500.0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 20.0,
                ),
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: 'All Books',
                    ),
                    Tab(
                      text: 'Requested Books',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FutureBuilder<List<BookEntity>>(
                    future: widget.bookProvider.getBooks(),
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
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: Colors.red,
                                ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => BookWidget(
                          book: snapshot.data![index],
                        ),
                      );
                    },
                  ),
                  FutureBuilder<List<RequestBookEntity>>(
                    future: widget.requestBookProvider.lentBooksByUser(
                      widget.authProvider.currentUser()!.id,
                    ),
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
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: Colors.red,
                                ),
                          ),
                        );
                      }

                      final books = snapshot.data!;

                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) =>
                            FutureBuilder<BookEntity>(
                                future: widget.bookProvider.getBookById(
                                  books[index].bookId,
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
                                  return BookWidget(
                                    book: snapshot.data!,
                                    action: () => widget.requestBookProvider
                                        .returnBook(books[index].id),
                                  );
                                }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookWidget extends StatelessWidget {
  const BookWidget({
    required this.book,
    this.action,
    super.key,
  });

  final BookEntity book;

  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.withOpacity(0.8),
      child: ListTile(
        leading: book.coverImage == null || book.coverImage!.isEmpty
            ? null
            : Image.network(
                book.coverImage!,
                fit: BoxFit.contain,
                height: 80.0,
              ),
        title: Text(
          book.name ?? 'Undefined',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text('Author: ${book.author}, ISBN: ${book.isbn}'),
        trailing: action != null
            ? Tooltip(
                message: 'Return Book',
                child: IconButton(
                  icon: const Icon(Icons.book),
                  onPressed: action,
                ),
              )
            : null,
      ),
    );
  }
}
