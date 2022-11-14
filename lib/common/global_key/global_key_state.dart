import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../constants.dart';

mixin GlobalKeyStateMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<State<StatefulWidget>> globalKey =
      GlobalKey<State<StatefulWidget>>();

  State<StatefulWidget>? get container => globalKey.currentState;

  BuildContext? getContext() {
    return globalKey.currentState?.context ?? globalKey.currentContext;
  }

  String getImgUrl(String? path) {
    return path != null ? Constants.baseStatic + path : '';
  }

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Future<File?> getFile(String? url) async {
    if (url != null && url.isNotEmpty) {
      final File imageFile = await DefaultCacheManager().getSingleFile(url);
      return imageFile;
    } else {
      return null;
    }
  }
}
