import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:test_project/sampleCodeIm/sample_page_im.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());

  runApp(MaterialApp(home: SamplePageIm()));
}
