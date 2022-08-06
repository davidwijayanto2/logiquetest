import 'dart:io';

import 'package:flutter/material.dart';

class CircularProgress {
  static Widget inicator() {
    return CircularProgressIndicator.adaptive(
      backgroundColor: Platform.isIOS ? Colors.grey : Colors.blueGrey,
      strokeWidth: 2.5,
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.grey[400] ?? Colors.grey,
      ),
    );
  }
}
