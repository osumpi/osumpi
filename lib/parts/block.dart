import 'package:flutter/material.dart';

class ReceipeBlockPort extends StatelessWidget {
  const ReceipeBlockPort({
    final Key? key,
    this.onTap,
    this.onLongPressStart,
  }) : super(key: key);

  final GestureTapCallback? onTap;

  final GestureLongPressStartCallback? onLongPressStart;

  static const size = 12.0;

  @override
  Widget build(final BuildContext context) {
    // TODO: add device specific size changes to make it more accessible in tablets
    // const size = 12.0;
    return GestureDetector(
      onTap: onTap,
      onLongPressStart: onLongPressStart,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class RecipeBlock extends StatelessWidget {
  const RecipeBlock({
    final Key? key,
    required this.heading,
    this.gradient = _kDefaultGradient,
  }) : super(key: key);

  static const _kDefaultGradient = LinearGradient(
    colors: [
      Color(0xff000046),
      Color(0xff1CB5E0),
    ],
  );

  final Text heading;
  final LinearGradient gradient;

  @override
  Widget build(final BuildContext context) {
    final borderRadius = BorderRadius.circular(23);
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(ReceipeBlockPort.size / 2),
            child: Material(
              elevation: 6,
              shadowColor: Colors.grey.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: borderRadius,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {},
                  child: heading
                    ..style?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          left: 0,
          child: ReceipeBlockPort(),
        ),
        const Positioned(
          right: 0,
          child: ReceipeBlockPort(),
        ),
      ],
    );
  }
}
