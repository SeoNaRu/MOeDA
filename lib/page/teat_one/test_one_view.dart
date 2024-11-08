import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../git_project/git_test_project.dart';
import '../test_two/mounted_example_widget.dart';
import '../test_two/test_two_view.dart';
import '../test_two/test_view.dart';

class TestOnePage extends StatelessWidget {
  const TestOnePage({super.key});
  
  @override
  Widget build(BuildContext context) {




    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AttendanceCheckScreen(),
    );
  }
}