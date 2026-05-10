// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_by_category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipesByCategoryHash() => r'e9c3a91c460717f8677cbf554ead9acda8408ff6';

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

/// See also [recipesByCategory].
@ProviderFor(recipesByCategory)
const recipesByCategoryProvider = RecipesByCategoryFamily();

/// See also [recipesByCategory].
class RecipesByCategoryFamily extends Family<AsyncValue<List<RecipeEntity>>> {
  /// See also [recipesByCategory].
  const RecipesByCategoryFamily();

  /// See also [recipesByCategory].
  RecipesByCategoryProvider call(String categoryName) {
    return RecipesByCategoryProvider(categoryName);
  }

  @override
  RecipesByCategoryProvider getProviderOverride(
    covariant RecipesByCategoryProvider provider,
  ) {
    return call(provider.categoryName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recipesByCategoryProvider';
}

/// See also [recipesByCategory].
class RecipesByCategoryProvider
    extends AutoDisposeFutureProvider<List<RecipeEntity>> {
  /// See also [recipesByCategory].
  RecipesByCategoryProvider(String categoryName)
    : this._internal(
        (ref) => recipesByCategory(ref as RecipesByCategoryRef, categoryName),
        from: recipesByCategoryProvider,
        name: r'recipesByCategoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$recipesByCategoryHash,
        dependencies: RecipesByCategoryFamily._dependencies,
        allTransitiveDependencies:
            RecipesByCategoryFamily._allTransitiveDependencies,
        categoryName: categoryName,
      );

  RecipesByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryName,
  }) : super.internal();

  final String categoryName;

  @override
  Override overrideWith(
    FutureOr<List<RecipeEntity>> Function(RecipesByCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecipesByCategoryProvider._internal(
        (ref) => create(ref as RecipesByCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryName: categoryName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RecipeEntity>> createElement() {
    return _RecipesByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipesByCategoryProvider &&
        other.categoryName == categoryName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecipesByCategoryRef on AutoDisposeFutureProviderRef<List<RecipeEntity>> {
  /// The parameter `categoryName` of this provider.
  String get categoryName;
}

class _RecipesByCategoryProviderElement
    extends AutoDisposeFutureProviderElement<List<RecipeEntity>>
    with RecipesByCategoryRef {
  _RecipesByCategoryProviderElement(super.provider);

  @override
  String get categoryName => (origin as RecipesByCategoryProvider).categoryName;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
