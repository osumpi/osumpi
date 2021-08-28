import 'package:flutter/material.dart';
import 'package:osumpi/osumpi.dart';
import 'package:osumpi/routes/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

void main() => runApp(OsumPiApp());

class OsumPiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      // Injects the OsumPie Manager
      value: OsumPi.create(),

      builder: (context, _) {
        final op = OsumPi.of(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: op.title,
          themeMode: op.themeMode,
          theme: op.theme,
          darkTheme: op.darkTheme,
          home: const Dashboard(),
        );
      },
    );
  }
}
