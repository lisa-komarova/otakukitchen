// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipeDetailsControllerHash() =>
    r'0f93cc6f2ceb4bea2c6603a69011c0f9ac42f89d';

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

abstract class _$RecipeDetailsController
    extends BuildlessAutoDisposeAsyncNotifier<RecipeEntity> {
  late final int id;

  FutureOr<RecipeEntity> build(int id);
}

/// See also [RecipeDetailsController].
@ProviderFor(RecipeDetailsController)
const recipeDetailsControllerProvider = RecipeDetailsControllerFamily();

/// See also [RecipeDetailsController].
class RecipeDetailsControllerFamily extends Family<AsyncValue<RecipeEntity>> {
  /// See also [RecipeDetailsController].
  const RecipeDetailsControllerFamily();

  /// See also [RecipeDetailsController].
  RecipeDetailsControllerProvider call(int id) {
    return RecipeDetailsControllerProvider(id);
  }

  @override
  RecipeDetailsControllerProvider getProviderOverride(
    covariant RecipeDetailsControllerProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recipeDetailsControllerProvider';
}

/// See also [RecipeDetailsController].
class RecipeDetailsControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          RecipeDetailsController,
          RecipeEntity
        > {
  /// See also [RecipeDetailsController].
  RecipeDetailsControllerProvider(int id)
    : this._internal(
        () => RecipeDetailsController()..id = id,
        from: recipeDetailsControllerProvider,
        name: r'recipeDetailsControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$recipeDetailsControllerHash,
        dependencies: RecipeDetailsControllerFamily._dependencies,
        allTransitiveDependencies:
            RecipeDetailsControllerFamily._allTransitiveDependencies,
        id: id,
      );

  RecipeDetailsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<RecipeEntity> runNotifierBuild(
    covariant RecipeDetailsController notifier,
  ) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(RecipeDetailsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeDetailsControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RecipeDetailsController, RecipeEntity>
  createElement() {
    return _RecipeDetailsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeDetailsControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecipeDetailsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<RecipeEntity> {
  /// The parameter `id` of this provider.
  int get id;
}

class _RecipeDetailsControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          RecipeDetailsController,
          RecipeEntity
        >
    with RecipeDetailsControllerRef {
  _RecipeDetailsControllerProviderElement(super.provider);

  @override
  int get id => (origin as RecipeDetailsControllerProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
