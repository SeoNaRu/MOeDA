import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void customDialogVoid(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
      barrierDismissible:false,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });

      return Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(seconds: 2),
          tween: Tween<double>(begin: 1, end: 0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 308,
                  height: 121,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/check_alert.svg'),
                      const SizedBox(
                        height: 14,
                      ),
                      const Text(
                        '저장되었습니다!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
