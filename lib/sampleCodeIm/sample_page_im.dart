import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SamplePageIm extends StatefulWidget {
  @override
  _SamplePageImState createState() => _SamplePageImState();
}

class _SamplePageImState extends State<SamplePageIm> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  List<CameraDescription>? cameras;

  int _currentStep = 1; // 현재 표시할 step을 추적하는 변수

  @override
  void initState() {
    super.initState();
    _initializeCamera();
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
      setState(() {}); // FutureBuilder를 새로고침하여 초기화 상태를 반영
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // 화면 터치 시 step을 업데이트하는 함수
  void _nextStep() {
    setState(() {
      print('터치 감지');
      _currentStep = _currentStep % 6 + 1; // 1~6까지 반복
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 카메라 초기화 완료 시, 카메라 프리뷰 표시
            return GestureDetector(
              onTap: (){
                print('터치 감지');
                _nextStep();
              },
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                        child: Positioned.fill(
                          child: CameraPreview(_controller!),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          print('카메라 터치 ');
                          _nextStep();

                        },
                        child: Container(
                          color: Colors.transparent, // 터치 영역을 전체 화면으로 확장
                        ),
                      ),
                    ],
                  ),
                  // GestureDetector를 Stack의 상단에 위치시켜 터치를 감지하게 함
                  _getCurrentStepWidget(),
                  // 상단 왼쪽 날짜 및 시간
                  Positioned(
                    top: 62,
                    left: 62,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SUNDAY, April 3rd",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          width: 169,
                          height: 2,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "06:30 ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 43,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "PM",
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
              ),
            );
          } else {
            // 로딩 중일 때 로딩 표시
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }


  // 현재 step에 따라 표시할 위젯을 반환하는 함수
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
      default:
        return _buildStep1();
    }
  }

  Widget _buildStep1() {
    return Positioned(
      top: 56,
      right: 40,
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
          Container(
            width: 280,
            height: 438,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Image.asset(
                "assets/test_icon/center_icon.png",
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "영역 안에 칫솔을 인식해 주세요",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
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
                child: Image.asset(
                  'assets/test_icon/mouth_brushing.png', // 실제 이미지 경로로 변경
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
                        '87',
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
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
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
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '린이다',
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
                          style: TextStyle(color: Colors.grey),
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
                      '린이다',
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
                      height: 16,
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
