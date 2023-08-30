import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sw_finder/core/config/app_colors.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: orangeColor,
            ),
            child: Center(
              child: Image.asset(
                "assets/dashboard/startitle.png",
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
          ),
          // const DrawerListTile(
          //   title: "Movies",
          //   redirectTo: 'FilmList()',
          //   icon: Icons.account_balance,
          // ),
          // const DrawerListTile(
          //   title: "Starships",
          //   redirectTo: 'StarshipList()',
          //   icon: Icons.airplanemode_active,
          // ),
          // const DrawerListTile(
          //   title: "Characters",
          //   redirectTo: 'PersonList()',
          //   icon: Icons.people,
          // ),
          // const DrawerListTile(
          //   title: "Planets",
          //   redirectTo: 'PlanetList()',
          //   icon: Icons.place,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () async {
                    if (context.locale == const Locale('ru')) {
                      await context.setLocale(const Locale('en'));
                    } else {
                      await context.setLocale(const Locale('ru'));
                    }
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.language),
                      context.locale == const Locale('ru')
                          ? const Text(' - EN')
                          : const Text(' - RU'),
                    ],
                  )),
              IconButton(
                icon: (AdaptiveTheme.of(context).theme ==
                        AdaptiveTheme.of(context).darkTheme)
                    ? const Icon(Icons.nightlight_round)
                    : const Icon(Icons.wb_sunny),
                onPressed: () => {toggleThemeMode()},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void toggleThemeMode() {
    if (AdaptiveTheme.of(context).theme ==
        AdaptiveTheme.of(context).darkTheme) {
      AdaptiveTheme.of(context).setLight();
    } else {
      AdaptiveTheme.of(context).setDark();
    }
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.redirectTo,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String redirectTo;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
      onTap: () {
        Navigator.pushNamed(context, redirectTo);
      },
    );
  }
}
