// import 'dart:convert';
// import 'dart:html' as html;
// import 'dart:js' as js;
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Web Geolocation Example',
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String _location = 'Unknown';
//
//   @override
//   void initState() {
//     super.initState();
//
//     // JavaScript 이벤트 리스너 추가
//     html.window.addEventListener('location', (event) {
//       var customEvent = event as html.CustomEvent;
//       var location = jsonDecode(customEvent.detail);
//       setState(() {
//         _location = '위도: ${location['latitude']}, 경도: ${location['longitude']}';
//       });
//     });
//
//     // JavaScript 함수 호출
//     js.context.callMethod('getCurrentLocation');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('위치 정보 테스트 코드'),
//       ),
//       body: Center(
//         child: Text('Current Location: $_location'),
//       ),
//     );
//   }
// }
