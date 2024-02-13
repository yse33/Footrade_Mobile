import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_nav_bar.dart';
import '../components/custom_search_delegate.dart';
import '../view_models/home_view_model.dart';
import '../view_models/shoe_preference_view_model.dart';
import '../view_models/shoe_favorite_view_model.dart';
import 'shoe_preference_view.dart';
import 'shoe_favorite_view.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../constants/app_strings.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final List<Widget> _pages = [
    const ShoePreferenceView(),
    const ShoeFavoriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShoePreferenceViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShoeFavoriteViewModel(),
        ),
      ],
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Icon(
                      AppIcons.menu,
                      color: AppColors.black,
                    ),
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    AppIcons.search,
                    color: AppColors.black,
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                ),
              ],
            ),
            drawer: Drawer(
              backgroundColor: AppColors.drawerBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            dividerTheme: const DividerThemeData(
                              color: Colors.transparent,
                            ),
                          ),
                          child: DrawerHeader(
                            child: Image.asset(
                              'assets/images/logo-transparent.png',
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Divider(
                            color: AppColors.drawerDivider,
                          ),
                        ),

                        // TODO: Add navigation links when implemented

                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: ListTile(
                            leading: Icon(
                              AppIcons.home,
                              color: AppColors.white,
                            ),
                            title: Text(
                              AppStrings.homeTitle,
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: ListTile(
                            leading: Icon(
                              AppIcons.user,
                              color: AppColors.white,
                            ),
                            title: Text(
                              AppStrings.forMeTitle,
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: ListTile(
                            leading: Icon(
                              AppIcons.inbox,
                              color: AppColors.white,
                            ),
                            title: Text(
                              AppStrings.inboxTitle,
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: ListTile(
                            leading: Icon(
                              AppIcons.settings,
                              color: AppColors.white,
                            ),
                            title: Text(
                              AppStrings.settingsTitle,
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
                    child: ListTile(
                      leading: const Icon(
                        AppIcons.logout,
                        color: AppColors.white,
                      ),
                      title: const Text(
                        AppStrings.logoutTitle,
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                      onTap: () async {
                        await viewModel.logoutUser();

                        if (!context.mounted) return;
                        Navigator.pushNamed(context, 'login');
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: _pages[viewModel.currentIndex],
            bottomNavigationBar: CustomNavBar(
              onTabChange: (index) {
                viewModel.setIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}