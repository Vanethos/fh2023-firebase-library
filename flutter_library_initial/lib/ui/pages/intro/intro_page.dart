import 'package:fire_library/ui/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              Icons.my_library_books_outlined,
              color: Colors.purpleAccent.withOpacity(
                0.2,
              ),
              fill: 1.0,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Heroes Library',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.amberAccent.withOpacity(
                          0.4,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Want to read a new book?\nOr maybe you want to give back to your community?\n\nThe Heroes Library is here for you!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Center(
                  child: OutlinedButton(
                    onPressed: () => context.goNamed(
                      routeAuth,
                    ),
                    child: const Text(
                      "ENTER",
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
