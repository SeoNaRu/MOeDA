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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 카메라 초기화 완료 시, 카메라 프리뷰 표시
            return Stack(
              children: [
                // 카메라 프리뷰 배경
                Positioned.fill(
                  child: CameraPreview(_controller!),
                ),
                // 중앙 아이콘과 텍스트
                Center(
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
                ),
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
                // 오른쪽 아이콘 메뉴
                Positioned(
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
                          child: _buildIcon("assets/test_icon/main_icon_1.png", isTopIcon: true),
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
                ),
              ],
            );
          } else {
            // 로딩 중일 때 로딩 표시
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildIcon(String imagePath, {bool isTopIcon = false}) {
    return Image.asset(
      imagePath,
      width: 7,
      height: 7,
      color: isTopIcon ? Colors.black : Colors.white,
    );
  }
}
