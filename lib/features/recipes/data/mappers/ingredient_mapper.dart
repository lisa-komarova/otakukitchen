import 'package:otakukitchen/features/recipes/domain/entities/ingredient_group_entity.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_group_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_in_recipe_model.dart';

class IngredientMapper {
  static List<IngredientGroupEntity> mapGroups(
    List<IngredientGroupModel> groups,
    List<IngredientInRecipeModel> items,
  ) {
    return groups.map((group) {
      final groupItems = items.where((i) => i.groupId == group.id).map((i) {
        final quantityStr = i.quantity ?? '';
        final unitStr = i.unit ?? '';
        final fullAmount = '$quantityStr $unitStr'.trim();

        return IngredientEntity(
          id: i.ingredientId,
          name: i.displayName,
          amount: fullAmount.isEmpty ? 'по вкусу' : fullAmount,
          note: i.note,
        );
      }).toList();

      return IngredientGroupEntity(title: group.title, ingredients: groupItems);
    }).toList();
  }
}
