import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:osumpi/shared/hexcolor.dart';

class ThemeSetting extends StatelessWidget {
  /// The setting widget builds the appropriate setting by checking the
  /// [value] in the theme json. It will trigger callback logic [onChanged].
  const ThemeSetting({
    required this.value,
    required this.onChanged,
  });

  /// The value in the setting.
  final String value;

  /// The callback to trigger when the value changes.
  final void Function(dynamic) onChanged;

  /// Show the color picker UI with the [pickedColor], and an [onChanged] callback to
  /// trigger when color value is changed. Also pass the current [context] to
  /// show the dialog.
  void changeColor(
    Color pickedColor,
    final BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (final _) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickedColor,
            onColorChanged: (final color) => pickedColor = color,
          ),
        ),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('Close'),
            onPressed: () {
              onChanged(pickedColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    // Check if value is hex color string.
    if (value.startsWith('#')) {
      return OutlinedButton(
        onPressed: () => changeColor(
          HexSupportForColor.fromHexString(value),
          context,
        ),
        child: Text(value),
      );
    } else {
      switch (value) {
        // Check for boolean value setting.
        case 'false':
        case 'true':
          return SwitchListTile(
            value: value == 'true',
            onChanged: onChanged,
          );
        // Check for dark/light value setting and put them as readonly for now
        // because they break the theme schema.
        //
        // TODO: Fix this dark/light assertion issue?
        case 'dark':
        case 'light':
          return TextFormField(
            enabled: false,
            readOnly: true,
            style: const TextStyle(color: Colors.grey),
            initialValue: value,
          );
        // Other setting just show them as text field.
        default:
          return TextFormField(
            initialValue: value,
            onChanged: onChanged,
          );
      }
    }
  }
}
