import 'package:flutter/material.dart';

class InheritWidget extends InheritedWidget {
  const InheritWidget({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static InheritWidget of(BuildContext context) {
    final InheritWidget? result = context.dependOnInheritedWidgetOfExactType<InheritWidget>();
    assert(result != null, 'No Inherit found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritWidget oldWidget) {
    return true;
  }
  static InheritWidget? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritWidget>();
  }

  static InheritWidget? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<InheritWidget>()
        ?.widget;
    return widget is InheritWidget ? widget : null;
  }
}