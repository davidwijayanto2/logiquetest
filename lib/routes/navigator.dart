import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logique_techtest/screen/detail_user/detail_user_screen.dart';
import 'package:logique_techtest/utils/common_strings.dart';

replaceToHomeScreen(BuildContext context) async {
  Navigator.of(context, rootNavigator: true)
      .pushNamedAndRemoveUntil(CommonString.HOME_ROUTE, (route) => false);
}

goToDetailUserScreen<R>(
  BuildContext context, {
  FutureOr<R> Function(dynamic)? afterOpen,
  required String id,
  required String name,
}) async {
  if (afterOpen != null) {
    return Navigator.of(context, rootNavigator: true)
        .pushNamed(
          CommonString.DETAIL_USER_ROUTE,
          arguments: DetailUserScreen(id: id, name: name),
        )
        .then(afterOpen);
  } else {
    return Navigator.of(context, rootNavigator: true).pushNamed(
      CommonString.DETAIL_USER_ROUTE,
      arguments: DetailUserScreen(id: id, name: name),
    );
  }
}
