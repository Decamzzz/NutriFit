// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Source of the recipes. Override in tests.

@ProviderFor(recipeRepository)
final recipeRepositoryProvider = RecipeRepositoryProvider._();

/// Source of the recipes. Override in tests.

final class RecipeRepositoryProvider
    extends
        $FunctionalProvider<
          RecipeRepository,
          RecipeRepository,
          RecipeRepository
        >
    with $Provider<RecipeRepository> {
  /// Source of the recipes. Override in tests.
  RecipeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipeRepositoryHash();

  @$internal
  @override
  $ProviderElement<RecipeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecipeRepository create(Ref ref) {
    return recipeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecipeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecipeRepository>(value),
    );
  }
}

String _$recipeRepositoryHash() => r'f82833d54d7a21566e20160d6dc2dd5930e641dd';

/// The whole catalogue.

@ProviderFor(recipes)
final recipesProvider = RecipesProvider._();

/// The whole catalogue.

final class RecipesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Recipe>>,
          List<Recipe>,
          FutureOr<List<Recipe>>
        >
    with $FutureModifier<List<Recipe>>, $FutureProvider<List<Recipe>> {
  /// The whole catalogue.
  RecipesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipesHash();

  @$internal
  @override
  $FutureProviderElement<List<Recipe>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Recipe>> create(Ref ref) {
    return recipes(ref);
  }
}

String _$recipesHash() => r'63024923df107ce24bcb1e4a932d4e3ad2a02935';

/// A single recipe, or null when the id does not exist.

@ProviderFor(recipeById)
final recipeByIdProvider = RecipeByIdFamily._();

/// A single recipe, or null when the id does not exist.

final class RecipeByIdProvider
    extends $FunctionalProvider<AsyncValue<Recipe?>, Recipe?, FutureOr<Recipe?>>
    with $FutureModifier<Recipe?>, $FutureProvider<Recipe?> {
  /// A single recipe, or null when the id does not exist.
  RecipeByIdProvider._({
    required RecipeByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'recipeByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$recipeByIdHash();

  @override
  String toString() {
    return r'recipeByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Recipe?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Recipe?> create(Ref ref) {
    final argument = this.argument as String;
    return recipeById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recipeByIdHash() => r'6974847ee273b1987a5f7cc23109258e554b3d3d';

/// A single recipe, or null when the id does not exist.

final class RecipeByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Recipe?>, String> {
  RecipeByIdFamily._()
    : super(
        retry: null,
        name: r'recipeByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A single recipe, or null when the id does not exist.

  RecipeByIdProvider call(String id) =>
      RecipeByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'recipeByIdProvider';
}

/// Selected category tab (null = all recipes).

@ProviderFor(RecipeCategoryFilter)
final recipeCategoryFilterProvider = RecipeCategoryFilterProvider._();

/// Selected category tab (null = all recipes).
final class RecipeCategoryFilterProvider
    extends $NotifierProvider<RecipeCategoryFilter, RecipeCategory?> {
  /// Selected category tab (null = all recipes).
  RecipeCategoryFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipeCategoryFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipeCategoryFilterHash();

  @$internal
  @override
  RecipeCategoryFilter create() => RecipeCategoryFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecipeCategory? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecipeCategory?>(value),
    );
  }
}

String _$recipeCategoryFilterHash() =>
    r'deb56e42ba5cefb95ccfa8cb072311d81e2877fe';

/// Selected category tab (null = all recipes).

abstract class _$RecipeCategoryFilter extends $Notifier<RecipeCategory?> {
  RecipeCategory? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RecipeCategory?, RecipeCategory?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecipeCategory?, RecipeCategory?>,
              RecipeCategory?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The catalogue filtered by the selected tab.

@ProviderFor(filteredRecipes)
final filteredRecipesProvider = FilteredRecipesProvider._();

/// The catalogue filtered by the selected tab.

final class FilteredRecipesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Recipe>>,
          List<Recipe>,
          FutureOr<List<Recipe>>
        >
    with $FutureModifier<List<Recipe>>, $FutureProvider<List<Recipe>> {
  /// The catalogue filtered by the selected tab.
  FilteredRecipesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredRecipesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredRecipesHash();

  @$internal
  @override
  $FutureProviderElement<List<Recipe>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Recipe>> create(Ref ref) {
    return filteredRecipes(ref);
  }
}

String _$filteredRecipesHash() => r'29ac85996a158b8a055fc46f10c0af7f02b04d1c';
