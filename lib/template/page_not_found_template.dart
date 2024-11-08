
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../util/default_color.dart';
import '../util/default_icon.dart';

class PageNotFountTemplate extends StatelessWidget {
  const PageNotFountTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsIcon.alertGrayRounded,
              width: 80,
              height: 80,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20,),
            const Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: "현재 접근은 잘못된 접근입니다.\n",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: RedColor.red90,
                    ),
                  ),
                  TextSpan(
                    text: "SMS",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: PrimaryColor.blue90,
                    ),
                  ),
                  TextSpan(
                    text: " 또는 ",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: GrayColor.gray20,
                    ),
                  ),
                  TextSpan(
                    text: "메일",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: PrimaryColor.blue90,
                    ),
                  ),
                  TextSpan(
                    text: "의 모바일 주소를 통하여 접속하여 주세요.",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: GrayColor.gray20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
