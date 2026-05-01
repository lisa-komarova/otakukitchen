import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/checked_items_provider.dart';

class CheckableItem extends ConsumerWidget {
  final String id;
  final String text;
  final Color color;
  final Color? textColor;
  const CheckableItem({
    super.key,
    required this.id,
    required this.text,
    required this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(checkedItemsProvider).contains(id);

    return GestureDetector(
      onTap: () {
        ref.read(checkedItemsProvider.notifier).toggle(id);
      },  
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF301659), width: 2),
                borderRadius: BorderRadius.circular(6),
                color: isChecked ? Color(0xFF301659) : color,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                  color: textColor,
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
