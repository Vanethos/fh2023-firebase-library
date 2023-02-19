import 'package:fire_library/ui/navigation/navigation.dart';
import 'package:fire_library/ui/widgets/library_navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LibraryNavigationRail(
        currentPage: NavigationRailDestinationsEnum.home,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What do you want to do today?',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 60.0,
            ),
            LayoutBuilder(builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth * 0.65,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _BoxIcon(
                        icon: Icons.local_library,
                        title: 'Book Catalog',
                        onTap: () => context.goNamed(routeBooks),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: _BoxIcon(
                        icon: Icons.library_books,
                        title: 'Find a Library',
                        onTap: () => context.goNamed(routeLibrary),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class _BoxIcon extends StatelessWidget {
  const _BoxIcon({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          padding: const EdgeInsets.all(
            40.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            border: Border.all(color: Colors.pink.withOpacity(0.2), width: 2.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.purple.withOpacity(0.4),
                size: 120.0,
              ),
              const SizedBox(
                height: 18.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
