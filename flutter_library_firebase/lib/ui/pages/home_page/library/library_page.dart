import 'package:fire_library/main.dart';
import 'package:fire_library/models/library_entity.dart';
import 'package:fire_library/providers/auth/base_auth_provider.dart';
import 'package:fire_library/providers/library/base_library_provider.dart';
import 'package:fire_library/ui/navigation/navigation.dart';
import 'package:fire_library/ui/widgets/library_navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage(
      {required this.authProvider, required this.libraryProvider, super.key});

  final BaseAuthProvider authProvider;
  final BaseLibraryProvider libraryProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LibraryNavigationRail(
        onLogout: () => authProvider.logout(),
        currentPage: NavigationRailDestinationsEnum.libraries,
        child: FutureBuilder<List<LibraryEntity>>(
          future: libraryProvider.listLibraries(),
          builder: (context, snapshot) {
            logger.wtf(snapshot.error);
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

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => LibraryListItem(
                library: snapshot.data![index],
                onTap: () => context.goNamed(routeLibraryDetail,
                    params: {'id': snapshot.data![index].id}),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LibraryListItem extends StatelessWidget {
  const LibraryListItem(
      {required this.library, required this.onTap, super.key});

  final LibraryEntity library;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.amber.withOpacity(0.8),
        child: ListTile(
          title: Text(library.name),
          subtitle: Text(library.country),
        ),
      ),
    );
  }
}
