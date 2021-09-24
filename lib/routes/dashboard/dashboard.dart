import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:osumpi/routes/dashboard/search_bar.dart';
import 'package:osumpi/shared/sidebar/sidebar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();

  static _DashboardState? of(BuildContext context) =>
      context.findAncestorStateOfType<_DashboardState>();
}

class _DashboardState extends State<Dashboard> {
  // final _pageController = PageController();

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
      tooltip: 'BakeCode Engine',
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

  set selectedIndex(int value) {
    if (selectedIndex != value) {
      assert(selectedIndex < destinations.length);
      setState(() => _selectedIndex = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Sidebar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(200, 20, 200, 8),
                child: SearchBar(),
              ),
            ),
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
