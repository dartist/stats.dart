import 'package:unittest/html_config.dart';
import 'package:unittest/unittest.dart';
import 'dart:html';
import 'package:stats/stats.dart';

main() {

  group('stats.dart', () {
    test('constructor', () {
      Stats stats = new Stats();
      expect(stats, isNotNull);
    });
    test('container', () {
      Stats stats = new Stats();
      expect(stats, isNotNull);
      expect(stats.container is DivElement, isTrue);
    });

    test('begin/end', () {
      Stats stats = new Stats();
      expect(stats, isNotNull);
      expect(stats.container is DivElement, isTrue);
      stats.begin();
      stats.end();
    });
  });
}

