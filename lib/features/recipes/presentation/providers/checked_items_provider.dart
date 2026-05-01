import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checked_items_provider.g.dart';

@riverpod
class CheckedItems extends _$CheckedItems {
  @override
  Set<String> build() => {};

  void toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }
   void clearAll() {
    state = {};
  }
}
