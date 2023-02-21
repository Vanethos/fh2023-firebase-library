import 'package:fire_library/providers/auth/base_auth_provider.dart';
import 'package:fire_library/providers/book/base_book_provider.dart';
import 'package:fire_library/providers/book_request/base_book_request_provider.dart';
import 'package:fire_library/providers/library/base_library_provider.dart';
import 'package:fire_library/ui/pages/auth/auth_page.dart';
import 'package:fire_library/ui/pages/home_page/library/detail/library_detail_page.dart';
import 'package:fire_library/ui/pages/home_page/library/library_page.dart';
import 'package:fire_library/ui/pages/intro/intro_page.dart';
import 'package:fire_library/ui/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home_page/books/books_page.dart';

const String routeIntro = 'intro';
const String routeHome = '/';
const String routeAuth = 'auth';
const String routeLibrary = 'library';
const String routeLibraryDetail = 'library/detail';
const String routeBooks = 'books';

GoRouter navigationRouter(
  BaseAuthProvider authProvider,
  BaseBookProvider bookProvider,
  BaseLibraryProvider libraryProvider,
  BaseBookRequestProvider bookRequestProvider,
) =>
    GoRouter(
      debugLogDiagnostics: true,
      initialLocation: routeHome,
      redirect: (context, state) async {
        final isSignedIn = await authProvider.isUserSignedIn();

        if (!isSignedIn) {
          return state.location == '/auth' ? '/auth' : '/intro';
        }

        if (isSignedIn && state.location.contains('auth') ||
            state.location.contains('intro')) {
          return '/';
        }

        return state.location;
      },
      routes: <GoRoute>[
        GoRoute(
          name: routeIntro,
          path: '/intro',
          pageBuilder: (_, __) => const NoTransitionPage(child: IntroPage()),
        ),
        GoRoute(
          name: routeAuth,
          path: '/auth',
          pageBuilder: (_, __) => const NoTransitionPage(child: AuthPage()),
        ),
        GoRoute(
          name: routeHome,
          path: '/',
          pageBuilder: (context, state) => NoTransitionPage(
              child: HomePage(
            authProvider: authProvider,
          )),
          routes: <GoRoute>[
            GoRoute(
              name: routeBooks,
              path: 'books',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  NoTransitionPage(
                child: BooksPage(
                  authProvider: authProvider,
                  bookProvider: bookProvider,
                  libraryProvider: libraryProvider,
                  requestBookProvider: bookRequestProvider,
                ),
              ),
            ),
            GoRoute(
              name: routeLibrary,
              path: 'library',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  NoTransitionPage(
                child: LibraryPage(
                  libraryProvider: libraryProvider,
                  authProvider: authProvider,
                ),
              ),
              routes: <GoRoute>[
                GoRoute(
                  name: routeLibraryDetail,
                  path: ':id',
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      NoTransitionPage(
                    child: LibraryDetailPage(
                      id: state.params['id']!,
                      libraryProvider: libraryProvider,
                      bookProvider: bookProvider,
                      authProvider: authProvider,
                      requestBookProvider: bookRequestProvider,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
