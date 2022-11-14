import 'package:flutter/material.dart';

mixin GlobalKeyWidgetMixin on Widget {
  final GlobalKey<State<StatefulWidget>> globalKey =
  GlobalKey<State<StatefulWidget>>();

  State<StatefulWidget>? get container => globalKey.currentState;

  BuildContext? getContext() {
    return globalKey.currentState?.context ?? globalKey.currentContext;
  }
}
