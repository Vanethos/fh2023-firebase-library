import 'package:fire_library/ui/navigation/navigation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

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
        child: Center(
          child: Theme(
            data: Theme.of(context).copyWith(
              /// Adapted from: https://github.com/firebase/flutterfire/blob/master/packages/firebase_ui_auth/doc/theming.md
              scaffoldBackgroundColor: Colors.transparent,
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.white,
                  focusColor: Colors.white),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(24),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 500.0, maxWidth: 500.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FirebaseUIActions(
                      actions: [
                        /// When the user signs in
                        AuthStateChangeAction<SignedIn>(
                          (context, state) {
                            context.goNamed(routeHome);
                          },
                        ),

                        /// When the user registers
                        AuthStateChangeAction<UserCreated>(
                          (context, state) {
                            context.goNamed(routeHome);
                          },
                        ),
                      ],
                      child: LoginView(
                        action: AuthAction.signIn,
                        providers: FirebaseUIAuth.providersFor(
                          FirebaseAuth.instance.app,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
