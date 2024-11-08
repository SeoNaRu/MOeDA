import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../controller/counts.dart';

final List<SingleChildWidget> providers = <SingleChildWidget>[
  ChangeNotifierProvider.value(value: Counts(),),
];