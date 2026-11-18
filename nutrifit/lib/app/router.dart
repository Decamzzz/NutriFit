import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/models/nutrition_item.dart';
import '../core/providers/session_provider.dart';
import '../features/auth_profile/presentation/pages/login_page.dart';
import '../features/auth_profile/presentation/pages/onboarding_page.dart';
import '../features/auth_profile/presentation/pages/profile_page.dart';
import '../features/diary/domain/meal_type.dart';
import '../features/diary/presentation/pages/add_food_page.dart';
import '../features/diary/presentation/pages/confirm_scan_page.dart';
import '../features/diary/presentation/pages/home_page.dart';
import '../features/food_scan/presentation/pages/scan_page.dart';
import '../features/progress/presentation/pages/progress_page.dart';
import '../features/recipes/presentation/pages/recipe_detail_page.dart';
import '../features/recipes/presentation/pages/recipes_page.dart';
import 'scaffold_with_nav_bar.dart';

part 'router.g.dart';

/// Routes reachable without an active session.
const Set<String> publicRoutes = {'/onboarding', '/login'};

/// Route guard. Pure function so it can be unit tested.
///
/// - Signed in  + public route  -> go to the home.
/// - Signed out + private route -> go to login.
String? sessionRedirect({required String userId, required String location}) {
  final signedIn = userId.isNotEmpty;
  final isPublic = publicRoutes.contains(location);
  if (signedIn && isPublic) return '/home';
  if (!signedIn && !isPublic) return '/login';
  return null;
}

/// Central route table.
@riverpod
GoRouter appRouter(Ref ref) {
  // Notifies go_router when the session changes (login, logout, restore).
  final refresh = ValueNotifier<int>(0);
  ref.listen(sessionUserIdProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: '/onboarding',
    refreshListenable: refresh,
    redirect: (context, state) => sessionRedirect(
      userId: ref.read(sessionUserIdProvider),
      location: state.matchedLocation,
    ),
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (_, _) => const OnboardingPage(),
      ),
      GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
      GoRoute(
        path: '/add-food/:meal',
        builder: (context, state) => AddFoodPage(
          meal: MealTypeX.parse(state.pathParameters['meal'] ?? 'breakfast'),
        ),
      ),
      GoRoute(path: '/scan', builder: (_, _) => const ScanPage()),
      GoRoute(
        path: '/scan/confirm',
        builder: (context, state) => ConfirmScanPage(
          items: (state.extra as List<NutritionItem>?) ?? const [],
          // `?source=recipe` when it comes from a recipe; scan otherwise.
          source: state.uri.queryParameters['source'] == 'recipe'
              ? 'recipe'
              : 'scan',
        ),
      ),
      GoRoute(
        path: '/recipe/:id',
        builder: (context, state) =>
            RecipeDetailPage(id: state.pathParameters['id'] ?? ''),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (_, _) => const HomePage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/recipes', builder: (_, _) => const RecipesPage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/progress',
                builder: (_, _) => const ProgressPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/profile', builder: (_, _) => const ProfilePage()),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}
