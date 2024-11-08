import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDialogWidget extends StatefulWidget {
  final Animation<double> animation;

  const CustomDialogWidget({Key? key, required this.animation}) : super(key: key);

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget>
    with TickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animation = widget.animation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 308,
      height: 121,
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(_animation.value),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/check_alert.svg'),

          SizedBox(
            height: 14,
          ),

          Text(
            '저장되었습니다!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

