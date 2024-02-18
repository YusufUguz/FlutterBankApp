import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

PageTransition<dynamic> scaleAnimation(Widget screen) {
    return PageTransition(
        child: screen,
        type: PageTransitionType.scale,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500));
  }