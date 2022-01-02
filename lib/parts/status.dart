import 'package:flutter/material.dart';

/// Handles the status bar logic for osumpi.
///
/// For extensions to communicate
/// pass information in the `osumpi/editor/status/<action>` mqtt topic.
///
class StatusBar extends StatelessWidget {
  const StatusBar({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text("Hi"),
    );
  }
}
