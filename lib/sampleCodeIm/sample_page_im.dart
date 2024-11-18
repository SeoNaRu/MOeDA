import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class SamplePageIm extends StatefulWidget {
  @override
  _SamplePageImState createState() => _SamplePageImState();
}

class _SamplePageImState extends State<SamplePageIm>
    with TickerProviderStateMixin { // SingleTickerProviderStateMixin -> TickerProviderStateMixin
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  List<CameraDescription>? cameras;
  String formattedDate = '';
  String formattedTime = '';
  String period = '';

  int _currentStep = 1; // 현재 표시할 step을 추적하는 변수
  Timer? _stepTimer; // step 자동 변경을 위한 Timer
  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _iconAnimationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _updateTime();
    _startStepTimer();

    // 애니메이션 초기화
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // 애니메이션 초기화
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // 애니메이션 지속 시간
    );

// 0에서 450까지 스캔 모션 구현
    _iconAnimation = Tween<double>(begin: 0, end: 425).animate(
      CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeInOut,
      ),
    );

// 애니메이션 반복: 0 -> 450 -> 다시 0 -> 450
    _iconAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _iconAnimationController.reset();
        _iconAnimationController.forward();
      }
    });

// 애니메이션 시작
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _stepTimer?.cancel();
    _animationController.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras?.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras!.first,
    );

    if (frontCamera != null) {
      _controller = CameraController(frontCamera, ResolutionPreset.high);
      _initializeControllerFuture = _controller?.initialize();
      setState(() {});
    }
  }

  void _updateTime() {
    Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();

      final dayOfWeek = DateFormat('EEEE').format(now).toUpperCase();
      final monthDay = DateFormat('MMMM d').format(now);
      final daySuffix = _addDaySuffix(now.day);

      setState(() {
        formattedDate = '$dayOfWeek, $monthDay$daySuffix';
        formattedTime = DateFormat('hh:mm').format(now);
        period = DateFormat('a').format(now);
      });
    });
  }

  String _addDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  void _startStepTimer() {
    _stepTimer = Timer.periodic(Duration(seconds: 5), (_) {
      setState(() {
        _currentStep = _currentStep % 7 + 1; // 1~7까지 반복
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(_controller!),
                ),
                _getCurrentStepWidget(),
                // _buildStep3(),
                Positioned(
                  top: 62,
                  left: 62,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      IntrinsicWidth(
                        child: Container(
                          height: 2,
                          color: Colors.white,
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                              color: Colors.transparent,
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formattedTime,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 43,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                period,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }



  Widget _getCurrentStepWidget() {
    switch (_currentStep) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      case 4:
        return _buildStep4();
      case 5:
        return _buildStep5();
      case 6:
        return _buildStep6();
      case 7:
        return _buildStep7();
      default:
        return _buildStep1();
    }
  }

  Widget _buildStep1() {
    return Positioned(
      top: 56,
      right: 62,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Column(
          children: [
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(13),
              child: _buildIcon("assets/test_icon/main_icon_1.png",
                  isTopIcon: true),
            ),
            SizedBox(height: 30),
            _buildIcon("assets/test_icon/main_icon_2.png"),
            SizedBox(height: 37),
            _buildIcon("assets/test_icon/main_icon_3.png"),
            SizedBox(height: 37),
            _buildIcon("assets/test_icon/main_icon_4.png"),
            SizedBox(height: 37),
            _buildIcon("assets/test_icon/main_icon_5.png"),
            SizedBox(height: 26),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String icon, String text) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/test_icon/step6_icon_$icon.png', // 실제 이미지 경로로 변경
                  width: 21,
                  height: 21,
                ),
                SizedBox(width: 19.26),
                Text(text, style: TextStyle(color: Colors.white, fontSize: 13)),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12),
          ],
        ),
        SizedBox(
          height: 24,
        )
      ],
    );
  }

  Widget _buildStep2() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 284,
            height: 444,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 280,
                    height: 438,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/test_icon/center_icon.png",
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/test_icon/top_left_corner.png',
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/test_icon/top_right_corner.png',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/test_icon/bottom_left_corner.png',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/test_icon/bottom_right_corner.png',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "영역 안에 칫솔을 인식해 주세요",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 284,
            height: 444,
            child: Stack(
              children: [
                Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final containerWidth =
                          constraints.maxWidth - 4; // 284 - 패딩 보정값
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 280,
                          height: 438,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 35, bottom: 27),
                                child: Image.asset(
                                  "assets/test_icon/center_icon_1.png",
                                  width: containerWidth, // center_icon_1 크기 고정
                                  fit: BoxFit.contain,
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _iconAnimationController,
                                builder: (context, child) {
                                  return Positioned(
                                    top: _iconAnimation.value,
                                    child: SizedBox(
                                      width: containerWidth + 10,
                                      // center_icon_1과 동일한 가로폭
                                      child: Image.asset(
                                        'assets/test_icon/center_icon_2.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/test_icon/top_left_corner.png',
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/test_icon/top_right_corner.png',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/test_icon/bottom_left_corner.png',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/test_icon/bottom_right_corner.png',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "칫솔 인식 중..",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep4() {
    return Positioned(
      top: 56,
      right: 62,
      child: Container(
        width: 287.25,
        height: 715.45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/test_icon/close_icon.png",
                  ),
                ],
              ),
              SizedBox(
                height: 154.11,
              ),
              Container(
                width: 167.55,
                height: 167.55,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.6)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/test_icon/user_image.png",
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 67.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "김모아",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "님",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Text(
                "맞춤 양치를 시작합니다!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep5() {
    return Positioned(
      top: 56,
      right: 62,
      child: Container(
        width: 287.25,
        height: 715.45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/test_icon/close_icon.png",
                  ),
                ],
              ),
              SizedBox(
                height: 57,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '김모아의 양치',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.7),
                    Divider(color: Colors.white),

                    // 진행률 및 남은 시간
                    SizedBox(height: 20.89),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset(
                                  "assets/test_icon/tooth_top.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 7.57),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '양치 진행률',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                                Text(
                                  '30%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset(
                                  "assets/test_icon/tooth_time.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 7.57),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '남은 시간',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                                Text(
                                  '01:40',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 중앙 이미지
              SizedBox(height: 113.27),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      'assets/test_icon/mouth_brushing_1.png', // 중앙에 위치
                    ),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Positioned(
                          left: -1,
                          // 왼쪽으로 10 이동
                          bottom: -15 + _animation.value,
                          // 아래로 10 이동 후 애니메이션 적용
                          child: Image.asset(
                            'assets/test_icon/mouth_brushing_2.png',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // 하단 텍스트 설명
              Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          "assets/test_icon/tooth_btm.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '음식을 씹는 면을 앞뒤로',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '왕복운동하며 닦아요',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep6() {
    return Positioned(
      top: 56,
      right: 62,
      child: Container(
        width: 287.25,
        height: 715.45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/test_icon/close_icon.png",
                      ),
                    ],
                  ),

                  // 중앙 이미지와 텍스트
                  SizedBox(
                    height: 45.69,
                  ),
                  Column(
                    children: [
                      // 중앙의 원형 아이콘들 (순서대로 위에서 아래로)
                      Image.asset(
                        'assets/test_icon/step5_icon_1.png', // 실제 이미지 경로로 변경
                      ),
                      Image.asset(
                        'assets/test_icon/step5_icon_2.png', // 실제 이미지 경로로 변경
                      ),
                      Image.asset(
                        'assets/test_icon/step5_icon_3.png', // 실제 이미지 경로로 변경
                      ),
                      SizedBox(height: 39),

                      // 오늘의 양치 점수
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            '오늘의 양치',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '92',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white),

                  // MVP 리스트
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 37,
                ),
                Text(
                  '오늘의 MVP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // MVP 사용자 1위
            Container(
              padding: EdgeInsets.symmetric(horizontal: 37, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '김모아',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '92',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 25,
                        // 원하는 너비로 설정하세요.
                        height: 25,
                        // 원하는 높이로 설정하세요.
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/test_icon/step5_icon_4.png'),
                            fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조절하는 옵션
                          ),
                        ),
                        alignment: Alignment.center,
                        // 텍스트 중앙 정렬
                        child: Text(
                          '2',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '김이다',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        '85',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // MVP 사용자 3위
                  Row(
                    children: [
                      Container(
                        width: 25,
                        // 원하는 너비로 설정하세요.
                        height: 25,
                        // 원하는 높이로 설정하세요.
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/test_icon/step5_icon_5.png'),
                            fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조절하는 옵션
                          ),
                        ),
                        alignment: Alignment.center,
                        // 텍스트 중앙 정렬
                        child: Text(
                          '3',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '이모두',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        '76',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep7() {
    return Positioned(
      top: 56,
      right: 62,
      child: Container(
        width: 287.25,
        height: 715.45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Picture
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/test_icon/close_icon.png",
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.39,
                    ),
                    SizedBox(
                      width: 126.55,
                      height: 126.55,
                      child: Stack(
                        children: [
                          Container(
                            width: 116.55,
                            height: 116.55,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/test_icon/user_image.png'),
                                // 프로필 이미지
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    // Name and Date
                    Text(
                      '김모아',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '2012.01.23',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                    SizedBox(height: 22.81),
                    // Options
                    Divider(color: Colors.white),
                    SizedBox(
                      height: 32.15,
                    ),
                    Column(
                      children: [
                        _buildOption('1', '양치질 기록'),
                        _buildOption('2', '칫솔모 검사 결과'),
                        _buildOption('3', '양치질 랭킹'),
                      ],
                    ),
                    SizedBox(height: 9),
                    // MVP Section
                    Divider(color: Colors.white),
                    SizedBox(
                      height: 19,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '오늘의 MVP',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildMVP(
                      '김모아',
                      '1',
                      '4',
                      92,
                    ),
                    _buildMVP(
                      '김이다',
                      '2',
                      '5',
                      85,
                    ),
                    _buildMVP(
                      '이모두',
                      '3',
                      '6',
                      76,
                    ),
                    // Start Button
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.6)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            '양치질 시작하기',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMVP(String name, String rank, String icon, int score) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 25,
                    // 원하는 너비로 설정하세요.
                    height: 25,
                    // 원하는 높이로 설정하세요.
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/test_icon/step6_icon_$icon.png'),
                        fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조절하는 옵션
                      ),
                    ),
                    alignment: Alignment.center,
                    // 텍스트 중앙 정렬
                    child: Text(
                      rank,
                      style: TextStyle(color: Color(0xFF4D4D4D), fontSize: 12),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Text(
                score.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget _buildIcon(String imagePath, {bool isTopIcon = false}) {
    return Image.asset(
      imagePath,
      color: isTopIcon ? Colors.black : Colors.white,
    );
  }
}
