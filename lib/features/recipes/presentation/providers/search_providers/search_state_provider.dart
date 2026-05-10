import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_state_provider.g.dart';

enum SearchType { byName, byAnime }


class SearchParams {
  final String query;
  final SearchType type;

  SearchParams({this.query = '', this.type = SearchType.byName});

  SearchParams copyWith({String? query, SearchType? type}) {
    return SearchParams(query: query ?? this.query, type: type ?? this.type);
  }
}

@riverpod
class SearchRecipesController extends _$SearchRecipesController {
  @override
  SearchParams build() => SearchParams();

  void updateQuery(String query) {
    state = state.copyWith(query: query);
  }

  void toggleType(SearchType type) {
    state = state.copyWith(type: type);
  }
}

