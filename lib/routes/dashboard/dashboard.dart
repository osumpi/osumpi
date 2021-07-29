import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(53),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('logo'),
                    Text('menus'),
                  ],
                ),
              ),
              Center(
                child: Text('search bar'),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('ecosystem name'),
                    SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
