import 'package:fire_library/ui/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum NavigationRailDestinationsEnum {
  home,
  books,
  libraries,
}

class LibraryNavigationRail extends StatelessWidget {
  const LibraryNavigationRail({
    required this.child,
    required this.currentPage,
    super.key,
  });

  final Widget child;

  final NavigationRailDestinationsEnum currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NavigationRail(
          backgroundColor: Colors.purple.withOpacity(
            0.4,
          ),
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.local_library),
              label: Text('Books'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.library_books),
              label: Text('Library'),
            ),
          ],
          selectedIndex: currentPage.index,
          onDestinationSelected: (index) {
            if (index == NavigationRailDestinationsEnum.libraries.index) {
              context.goNamed(
                routeLibrary,
              );
            } else if (index == NavigationRailDestinationsEnum.books.index) {
              context.goNamed(routeBooks);
            } else {
              context.goNamed(routeHome);
            }
          },
        ),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
