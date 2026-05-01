import 'package:flutter/material.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/presentation/pages/categories_page.dart';
import 'package:otakukitchen/features/recipes/presentation/pages/favourite_recipes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        bottomNavigationBar: _buildBottomNavBar(context),
        body: <Widget>[
          const CategoriesPage(),
          const Placeholder(),
          const FavouriteRecipesPage(),
        ][currentPageIndex],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.secondary : AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border(
          top: BorderSide(
            color: isDarkMode ? AppColors.primaryColor : AppColors.background,
            width: 5,
          ),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        ),
        child: NavigationBar(
          height: 70,
          elevation: 0,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: [
            _buildNavDest(
              'assets/icons/menu.png',
              'assets/icons/menu.png',
              isDarkMode,
            ),
            _buildNavDest(
              'assets/icons/search.png',
              'assets/icons/search.png',
              isDarkMode,
            ),
            _buildNavDest(
              'assets/icons/favourite.png',
              'assets/icons/favourite.png',
              isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  NavigationDestination _buildNavDest(
    String selectedPath,
    String idlePath,
    bool isDarkMode,
  ) {
    return NavigationDestination(
      label: '',
      selectedIcon: Image.asset(
        selectedPath,
        width: 45,
        height: 45,
        color: AppColors.primaryColor,
      ),
      icon: Image.asset(
        idlePath,
        width: 45,
        height: 45,
        color: isDarkMode ? AppColors.surface : AppColors.secondary,
      ),
    );
  }
}
