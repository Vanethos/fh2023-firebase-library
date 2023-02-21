import 'package:fire_library/ui/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber, Colors.purple],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.my_library_books_outlined,
                  color: Colors.purpleAccent,
                  size: 400.0,
                  fill: 1.0,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(
                        0.8,
                      ),
                      offset: const Offset(10, 10),
                    ),
                    Shadow(
                      color: Colors.black.withOpacity(
                        0.6,
                      ),
                      offset: const Offset(15, 15),
                    ),
                    Shadow(
                      color: Colors.black.withOpacity(
                        0.4,
                      ),
                      offset: const Offset(20, 20),
                    ),
                    Shadow(
                      color: Colors.black.withOpacity(
                        0.2,
                      ),
                      offset: const Offset(25, 25),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Card(
                    color: Colors.black.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Heroes Library',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.amberAccent,
                                    ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                'Want to read a new book?\nOr maybe you want to give back to your community?\n\nThe Heroes Library is here for you!',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          OutlinedButton(
                            onPressed: () => context.goNamed(
                              routeAuth,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "ENTER",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
