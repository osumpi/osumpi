import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:osumpi/parts/block.dart';
import 'package:osumpi/parts/sidebar.dart';
import 'package:osumpi/parts/search_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({final Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();

  static _DashboardState? of(final BuildContext context) =>
      context.findAncestorStateOfType<_DashboardState>();
}

class _DashboardState extends State<Dashboard> {
  final destinations = const [
    DashboardDestination(
      icon: Icon(CommunityMaterialIcons.compass),
      tooltip: 'Explore',
      child: Center(child: Text('child')),
    ),
    DashboardDestination(
      icon: Icon(CommunityMaterialIcons.connection),
      tooltip: 'Services',
      child: Center(child: Text('child')),
    ),
    DashboardDestination(
      icon: Icon(CommunityMaterialIcons.code_tags),
      tooltip: 'Recipes',
      child: Center(child: Text('child')),
    ),
    DashboardDestination(
      icon: Icon(CommunityMaterialIcons.gauge),
      tooltip: 'Performance',
      child: Center(child: Text('child')),
    ),
    DashboardDestination(
      icon: Icon(CommunityMaterialIcons.server),
      tooltip: 'Bakecode',
      child: Center(child: Text('child')),
    ),
    DashboardDestination(
      icon: Icon(CommunityMaterialIcons.cogs),
      tooltip: 'Settings',
      child: Center(child: Text('child')),
    ),
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(final int value) {
    if (selectedIndex != value) {
      assert(selectedIndex < destinations.length);
      setState(() => _selectedIndex = value);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Sidebar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      destinations[_selectedIndex].tooltip,
                      style: theme.textTheme.headline6,
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 400,
                      child: SearchBar(),
                    ),
                  ]),
                ),
                Text("Hi"),
                RecipeBlock(
                  heading: Text(
                    "Hi i am very long block ! hehe :)",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DashboardDestination {
  const DashboardDestination({
    required this.icon,
    required this.tooltip,
    required this.child,
  });

  final Icon icon;
  final String tooltip;
  final Widget child;
}
