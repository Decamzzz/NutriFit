import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/services/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Degraded mode without keys: app still runs for UI/tests.
  await SupabaseService.init();
  runApp(const ProviderScope(child: NutriFitApp()));
}
