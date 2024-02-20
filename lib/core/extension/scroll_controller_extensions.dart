import 'package:flutter/material.dart';

extension ScrollControlleerExtensions on ScrollController {
  void onScrollEndsListener(
    final void Function() callback, {
    double offset = 0,
  }) {
    addListener(() {
      final maxScroll = position.maxScrollExtent;
      final currentScroll = position.pixels - offset;

      if (currentScroll == maxScroll) {
        callback();
      }
    });
  }
}
