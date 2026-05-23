import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checked_items_provider.g.dart';

@Riverpod(keepAlive: true)
class CheckedItems extends _$CheckedItems {
  @override
  Set<String> build(String recipeId) => {};

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
