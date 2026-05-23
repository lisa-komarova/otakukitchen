// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checked_items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$checkedItemsHash() => r'94737f15d7f83c58b64017cae6d18e5d9cc5a4c4';

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

abstract class _$CheckedItems extends BuildlessNotifier<Set<String>> {
  late final String recipeId;

  Set<String> build(String recipeId);
}

/// See also [CheckedItems].
@ProviderFor(CheckedItems)
const checkedItemsProvider = CheckedItemsFamily();

/// See also [CheckedItems].
class CheckedItemsFamily extends Family<Set<String>> {
  /// See also [CheckedItems].
  const CheckedItemsFamily();

  /// See also [CheckedItems].
  CheckedItemsProvider call(String recipeId) {
    return CheckedItemsProvider(recipeId);
  }

  @override
  CheckedItemsProvider getProviderOverride(
    covariant CheckedItemsProvider provider,
  ) {
    return call(provider.recipeId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'checkedItemsProvider';
}

/// See also [CheckedItems].
class CheckedItemsProvider
    extends NotifierProviderImpl<CheckedItems, Set<String>> {
  /// See also [CheckedItems].
  CheckedItemsProvider(String recipeId)
    : this._internal(
        () => CheckedItems()..recipeId = recipeId,
        from: checkedItemsProvider,
        name: r'checkedItemsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$checkedItemsHash,
        dependencies: CheckedItemsFamily._dependencies,
        allTransitiveDependencies:
            CheckedItemsFamily._allTransitiveDependencies,
        recipeId: recipeId,
      );

  CheckedItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipeId,
  }) : super.internal();

  final String recipeId;

  @override
  Set<String> runNotifierBuild(covariant CheckedItems notifier) {
    return notifier.build(recipeId);
  }

  @override
  Override overrideWith(CheckedItems Function() create) {
    return ProviderOverride(
      origin: this,
      override: CheckedItemsProvider._internal(
        () => create()..recipeId = recipeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recipeId: recipeId,
      ),
    );
  }

  @override
  NotifierProviderElement<CheckedItems, Set<String>> createElement() {
    return _CheckedItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckedItemsProvider && other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckedItemsRef on NotifierProviderRef<Set<String>> {
  /// The parameter `recipeId` of this provider.
  String get recipeId;
}

class _CheckedItemsProviderElement
    extends NotifierProviderElement<CheckedItems, Set<String>>
    with CheckedItemsRef {
  _CheckedItemsProviderElement(super.provider);

  @override
  String get recipeId => (origin as CheckedItemsProvider).recipeId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
