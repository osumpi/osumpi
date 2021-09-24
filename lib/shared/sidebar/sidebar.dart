library osumpie.sidebar;

import 'package:flutter/material.dart';
import 'package:osumpi/routes/dashboard/dashboard.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboard = Dashboard.of(context)!;
    final navigationRailTheme = Theme.of(context).navigationRailTheme;

    return Material(
      color: navigationRailTheme.backgroundColor,
      elevation: navigationRailTheme.elevation ?? 0,
      child: SizedBox(
        width: 64,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: dashboard.destinations.length,
            itemBuilder: (context, index) {
              final destination = dashboard.destinations.elementAt(index);
              final isSelected = index == dashboard.selectedIndex;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                // TODO: add tooltip without affecting functionality
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () => dashboard.selectedIndex = index,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        iconTheme: isSelected
                            ? navigationRailTheme.selectedIconTheme
                            : navigationRailTheme.unselectedIconTheme,
                      ),
                      child: destination.icon,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          ),
        ),
      ),
    );
  }
}
