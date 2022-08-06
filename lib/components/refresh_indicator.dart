import 'dart:io';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class CustomRefresh {
  static Widget customRefreshIndicator({
    required Widget child,
    required Future<void> Function() onRefresh,
    double additionalPaddingTop = 0,
    double paddingTop = 30,
    double paddingBottom = 0,
    bool Function(ScrollNotification)? notificationPredicate,
  }) {
    return CustomRefreshIndicator(
      offsetToArmed: 50,
      notificationPredicate: (notification) {
        if (notificationPredicate != null) {
          return notificationPredicate(notification);
        }

        return notification.depth == 0;
      },
      builder:
          (BuildContext context, Widget child, IndicatorController controller) {
        return Stack(
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, _) {
                return (controller.value > 0)
                    ? Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: paddingTop + additionalPaddingTop,
                          bottom: paddingBottom,
                        ),
                        height: controller.value * 50,
                        child: OverflowBox(
                          maxHeight: 40,
                          minHeight: 40,
                          maxWidth: 40,
                          minWidth: 40,
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Platform.isIOS
                                    ? Colors.grey
                                    : Colors.blueGrey,
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.grey[400] ?? Colors.grey,
                                ),
                                value:
                                    controller.isDragging || controller.isArmed
                                        ? controller.value.clamp(0.0, 1.0)
                                        : null,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container();
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * 50),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
      onRefresh: onRefresh,
      child: child,
    );
  }
}
