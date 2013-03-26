library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:bot/bot.dart';
import 'package:bot/hop.dart';
import 'package:bot/hop_tasks.dart';
import '../test/test_dump_render_tree.dart' as test_dump_render_tree;

void main() {
  //
  // Assert were being called from the proper location.
  //
  _assertKnownPath();

  //
  // Analyzer
  //
  addTask('analyze', createDartAnalyzerTask(['lib/stats.dart',
                                             'example/basic/statsdart.dart',
                                             'example/theming/theming.dart',
                                             'test/tests_browser.dart',
                                             //'test_dump_render_tree.dart',
                                             'tool/hop_runner.dart'
                                             ]));

  //
  // Unit test headless browser
  //
  addTask('headless_test', createUnitTestTask(test_dump_render_tree.testCore));

  //
  // Hop away!
  //
  runHop();
}

void _assertKnownPath() {
  // since there is no way to determine the path of 'this' file
  // assume that Directory.current() is the root of the project.
  // So check for existance of /bin/hop_runner.dart
  final thisFile = new File('tool/hop_runner.dart');
  assert(thisFile.existsSync());
}