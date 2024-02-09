import 'package:flutter/material.dart';
import 'package:footrade_mvvm/components/custom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../view_models/home_view_model.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  // TODO: Add pages when implemented
  final List<Widget> _pages = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
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
                    // TODO: Implement search
                    print('Search');
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
                              Icons.home,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            title: Text(
                              'For Me',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.mail_outline,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Inbox',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Settings',
                              style: TextStyle(
                                color: Colors.white,
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
                        Icons.logout,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
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