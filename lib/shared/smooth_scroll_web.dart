/*
Created by Hobbister

Copyright (c) 2019 Hobbister.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 * Neither the name of the Hobbister nor the names of its contributors may
   be used to endorse or promote products derived from this software without 
   specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Hobbister BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/* 
Original source:
  1) https://pub.dev/packages/smooth_scroll_web/
  2) https://gitlab.com/dezso15/smoothscrollweb

Null safe source:
  1) https://gitlab.com/ciriousjoker/smoothscrollweb/-/tree/ciriousjoker-master-patch-93756/smooth_scroll_web/

Modified by osumpi devs to follow Dart conventions.
*/

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const int kDefaultNormalScrollAnimationLengthMs = 250;
const int kDefaultScrollSpeed = 130;

class SmoothScrollWeb extends StatefulWidget {
  const SmoothScrollWeb({
    required this.controller,
    required this.child,
    this.scrollSpeed = kDefaultScrollSpeed,
    this.scrollAnimationLength = kDefaultNormalScrollAnimationLengthMs,
    this.curve = Curves.linear,
  });

  /// Same ScrollController as the child widget's.
  final ScrollController controller;

  /// Child scrollable widget.
  final Widget child;

  /// Scroll speed px/scroll.
  final int scrollSpeed;

  /// Scroll animation length in milliseconds.
  final int scrollAnimationLength;

  /// Curve of the animation.
  final Curve curve;

  @override
  State<SmoothScrollWeb> createState() => _SmoothScrollWebState();
}

class _SmoothScrollWebState extends State<SmoothScrollWeb> {
  double scroll = 0;

  @override
  Widget build(final BuildContext context) {
    if (widget.controller.hasClients) {
      widget.controller.addListener(() {
        if (!widget.controller.position.isScrollingNotifier.value) {
          scroll = widget.controller.position.extentBefore;
        }
      });
    }

    return Listener(
      onPointerSignal: (final pointerSignal) {
        if (widget.controller.hasClients) {
          var millis = widget.scrollAnimationLength;
          if (pointerSignal is PointerScrollEvent) {
            if (pointerSignal.scrollDelta.dy > 0) {
              scroll += widget.scrollSpeed;
            } else {
              scroll -= widget.scrollSpeed;
            }
            if (scroll > widget.controller.position.maxScrollExtent) {
              scroll = widget.controller.position.maxScrollExtent;
              millis = widget.scrollAnimationLength ~/ 2;
            }
            if (scroll < 0) {
              scroll = 0;
              millis = widget.scrollAnimationLength ~/ 2;
            }

            widget.controller.animateTo(
              scroll,
              duration: Duration(milliseconds: millis),
              curve: widget.curve,
            );
          }
        }
      },
      child: widget.child,
    );
  }
}
