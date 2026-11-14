import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/presentation/pages/recipes_page.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/categories_provider.dart';
import 'package:url_launcher/url_launcher.dart';


class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final categoriesAsync = ref.watch(categoriesProvider);

    return SafeArea(
      top: false,
      child: Scaffold(
        body: categoriesAsync.when(
          data: (categories) => Padding(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
            child: Column(
              children: [
                ...categories.map((category) {
                  return Expanded(
                    child: _buildMenuCard(
                      context: context,
                      title: category.name,
                      iconPath: 'assets/icons/${category.icon}.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipesPage(category: category),
                          ),
                        );
                      },
                    ),
                  );
                }),
                Expanded(
                  child: _buildMenuCard(
                    context: context,
                    title: 'Поддержать проект',
                    iconPath: 'assets/icons/support.png',
                    onTap: () => _showSupportDialog(context),
                  ),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Ошибка: $err')),
        ),
      ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: isDarkMode
              ? AppColors.primaryColor
              : AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 24,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Поддержать проект',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: isDarkMode ? Colors.white : AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/icons/clear.png',
                        width: 25,
                        height: 25,
                        color: isDarkMode
                            ? AppColors.surface
                            : AppColors.primaryColor,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _buildMenuCard(
                  context: context,
                  title: 'ko-fi',
                  isDialog: true,
                  onTap: () {
                    _openExternalUrl('https://ko-fi.com/otakukitchen');
                  },
                ),
                _buildMenuCard(
                  context: context,
                  title: 'boosty',
                  isDialog: true,
                  onTap: () {
                    _openExternalUrl('https://boosty.to/otakukitchen/donate');
                  },
                ),
                _buildMenuCard(
                  context: context,
                  title: 'подписаться в TikTok',
                  isDialog: true,
                  onTap: () {
                    _openExternalUrl('https://www.tiktok.com/@otakukitchen?_t=8rG4UWP9rZY&_r=1');
                  },
                ),
                _buildMenuCard(
                  context: context,
                  title: 'подписаться в Telegram',
                  isDialog: true,
                  onTap: () {
                    _openExternalUrl('https://t.me/otakukitchen');
                  },
                ),
                _buildMenuCard(
                  context: context,
                  title: 'поставить 5 звезд',
                  isDialog: true,
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _openStoreReview();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuCard({
    required BuildContext context,
    required String title,
    String? iconPath,
    required VoidCallback onTap,
    bool isDialog = false,
  }) {
    final double iconSize = isDialog ? 40 : 100;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: isDialog ? 12 : 15,
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style:
                        (isDialog
                                ? Theme.of(context).textTheme.titleLarge
                                : Theme.of(context).textTheme.headlineLarge)!
                            .copyWith(color: AppColors.textPrimary),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (iconPath != null)
                Image.asset(
                  iconPath,
                  width: iconSize,
                  height: iconSize,
                  color: AppColors.primaryColor,
                )
              else
                SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openStoreReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    try {
      await inAppReview.openStoreListing();
    } catch (e) {
      debugPrint('Не удалось открыть магазин приложений: $e');
    }
  }
  Future<void> _openExternalUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      final bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        debugPrint('Не удалось открыть ссылку: $urlString');
      }
    } catch (e) {
      debugPrint('Ошибка при открытии ссылки $urlString: $e');
    }
  }
}
