import 'package:flutter/material.dart';
import 'package:osumpie/osumpie.dart';
import 'package:osumpie/routes/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

void main() => runApp(OsumPieApp());

class OsumPieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      // Injects the OsumPie Manager
      value: OsumPie.create(),

      builder: (context, _) {
        final op = OsumPie.of(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: op.title,
          themeMode: op.themeMode,
          theme: op.theme,
          darkTheme: op.darkTheme,
          home: const DashboardPage(),
        );
      },
    );
  }
}
