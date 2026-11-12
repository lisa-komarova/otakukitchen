// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_recipes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchRecipesHash() => r'2945d28684a5e314f4561c4f3f4c0aa4c500a36e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchRecipes].
@ProviderFor(searchRecipes)
const searchRecipesProvider = SearchRecipesFamily();

/// See also [searchRecipes].
class SearchRecipesFamily
    extends Family<AsyncValue<List<RecipeCardInfoEntity>>> {
  /// See also [searchRecipes].
  const SearchRecipesFamily();

  /// See also [searchRecipes].
  SearchRecipesProvider call({
    required String query,
    required SearchMode mode,
    String? levels,
    String? categories,
    String? ingredients,
    int? numberOfIngredients,
  }) {
    return SearchRecipesProvider(
      query: query,
      mode: mode,
      levels: levels,
      categories: categories,
      ingredients: ingredients,
      numberOfIngredients: numberOfIngredients,
    );
  }

  @override
  SearchRecipesProvider getProviderOverride(
    covariant SearchRecipesProvider provider,
  ) {
    return call(
      query: provider.query,
      mode: provider.mode,
      levels: provider.levels,
      categories: provider.categories,
      ingredients: provider.ingredients,
      numberOfIngredients: provider.numberOfIngredients,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchRecipesProvider';
}

/// See also [searchRecipes].
class SearchRecipesProvider
    extends AutoDisposeFutureProvider<List<RecipeCardInfoEntity>> {
  /// See also [searchRecipes].
  SearchRecipesProvider({
    required String query,
    required SearchMode mode,
    String? levels,
    String? categories,
    String? ingredients,
    int? numberOfIngredients,
  }) : this._internal(
         (ref) => searchRecipes(
           ref as SearchRecipesRef,
           query: query,
           mode: mode,
           levels: levels,
           categories: categories,
           ingredients: ingredients,
           numberOfIngredients: numberOfIngredients,
         ),
         from: searchRecipesProvider,
         name: r'searchRecipesProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$searchRecipesHash,
         dependencies: SearchRecipesFamily._dependencies,
         allTransitiveDependencies:
             SearchRecipesFamily._allTransitiveDependencies,
         query: query,
         mode: mode,
         levels: levels,
         categories: categories,
         ingredients: ingredients,
         numberOfIngredients: numberOfIngredients,
       );

  SearchRecipesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.mode,
    required this.levels,
    required this.categories,
    required this.ingredients,
    required this.numberOfIngredients,
  }) : super.internal();

  final String query;
  final SearchMode mode;
  final String? levels;
  final String? categories;
  final String? ingredients;
  final int? numberOfIngredients;

  @override
  Override overrideWith(
    FutureOr<List<RecipeCardInfoEntity>> Function(SearchRecipesRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchRecipesProvider._internal(
        (ref) => create(ref as SearchRecipesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        mode: mode,
        levels: levels,
        categories: categories,
        ingredients: ingredients,
        numberOfIngredients: numberOfIngredients,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RecipeCardInfoEntity>> createElement() {
    return _SearchRecipesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchRecipesProvider &&
        other.query == query &&
        other.mode == mode &&
        other.levels == levels &&
        other.categories == categories &&
        other.ingredients == ingredients &&
        other.numberOfIngredients == numberOfIngredients;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, mode.hashCode);
    hash = _SystemHash.combine(hash, levels.hashCode);
    hash = _SystemHash.combine(hash, categories.hashCode);
    hash = _SystemHash.combine(hash, ingredients.hashCode);
    hash = _SystemHash.combine(hash, numberOfIngredients.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchRecipesRef
    on AutoDisposeFutureProviderRef<List<RecipeCardInfoEntity>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `mode` of this provider.
  SearchMode get mode;

  /// The parameter `levels` of this provider.
  String? get levels;

  /// The parameter `categories` of this provider.
  String? get categories;

  /// The parameter `ingredients` of this provider.
  String? get ingredients;

  /// The parameter `numberOfIngredients` of this provider.
  int? get numberOfIngredients;
}

class _SearchRecipesProviderElement
    extends AutoDisposeFutureProviderElement<List<RecipeCardInfoEntity>>
    with SearchRecipesRef {
  _SearchRecipesProviderElement(super.provider);

  @override
  String get query => (origin as SearchRecipesProvider).query;
  @override
  SearchMode get mode => (origin as SearchRecipesProvider).mode;
  @override
  String? get levels => (origin as SearchRecipesProvider).levels;
  @override
  String? get categories => (origin as SearchRecipesProvider).categories;
  @override
  String? get ingredients => (origin as SearchRecipesProvider).ingredients;
  @override
  int? get numberOfIngredients =>
      (origin as SearchRecipesProvider).numberOfIngredients;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
