// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_recipes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchRecipesHash() => r'cbb4ffe9e2e05e4a6c33d7e947a034a8b9d7c200';

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
class SearchRecipesFamily extends Family<AsyncValue<List<RecipeEntity>>> {
  /// See also [searchRecipes].
  const SearchRecipesFamily();

  /// See also [searchRecipes].
  SearchRecipesProvider call({
    required String query,
    required SearchMode mode,
    String? levels,
    String? categories,
  }) {
    return SearchRecipesProvider(
      query: query,
      mode: mode,
      levels: levels,
      categories: categories,
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
    extends AutoDisposeFutureProvider<List<RecipeEntity>> {
  /// See also [searchRecipes].
  SearchRecipesProvider({
    required String query,
    required SearchMode mode,
    String? levels,
    String? categories,
  }) : this._internal(
         (ref) => searchRecipes(
           ref as SearchRecipesRef,
           query: query,
           mode: mode,
           levels: levels,
           categories: categories,
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
  }) : super.internal();

  final String query;
  final SearchMode mode;
  final String? levels;
  final String? categories;

  @override
  Override overrideWith(
    FutureOr<List<RecipeEntity>> Function(SearchRecipesRef provider) create,
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
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RecipeEntity>> createElement() {
    return _SearchRecipesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchRecipesProvider &&
        other.query == query &&
        other.mode == mode &&
        other.levels == levels &&
        other.categories == categories;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, mode.hashCode);
    hash = _SystemHash.combine(hash, levels.hashCode);
    hash = _SystemHash.combine(hash, categories.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchRecipesRef on AutoDisposeFutureProviderRef<List<RecipeEntity>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `mode` of this provider.
  SearchMode get mode;

  /// The parameter `levels` of this provider.
  String? get levels;

  /// The parameter `categories` of this provider.
  String? get categories;
}

class _SearchRecipesProviderElement
    extends AutoDisposeFutureProviderElement<List<RecipeEntity>>
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
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
