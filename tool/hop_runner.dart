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
  addTask('analyze_lib', createDartAnalyzerTask(['lib/stats.dart']));

  //
  // Unit test headless browser
  //
  addTask('headless_test', createUnitTestTask(test_dump_render_tree.testCore));

  //
  // Doc generation
  //
  addTask('docs', getCompileDocsFunc('gh-pages', 'packages/', _getLibs));

  //
  // Hop away!
  //
  runHopCore();
}

void _assertKnownPath() {
  // since there is no way to determine the path of 'this' file
  // assume that Directory.current() is the root of the project.
  // So check for existance of /bin/hop_runner.dart
  final thisFile = new File('tool/hop_runner.dart');
  assert(thisFile.existsSync());
}

Future<List<String>> _getLibs() {
  return new Directory('lib').list()
      .where((FileSystemEntity fse) => fse is File)
      .map((File file) => file.path)
      .toList();
}