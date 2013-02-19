import 'dart:html';
import 'dart:math';
import 'package:stats/stats.dart';

void main() {
  Stats stats = new Stats();
  document.body.append(stats.container);

  CanvasElement canvas = new CanvasElement();
  canvas.width = 512;
  canvas.height = 512;
  document.body.append(canvas);

  CanvasRenderingContext2D context = canvas.getContext('2d');
  context.fillStyle = 'rgba(127, 0, 255, 0.05)';

  draw (num time) {
    window.requestAnimationFrame(draw);
    context.clearRect(0, 0, canvas.width, canvas.height);

    stats.begin();
    double t = new DateTime.now().millisecondsSinceEpoch * 0.001;

    for (int i = 0; i < 2000; i++) {
      double x = cos(t + i * 0.01) * 196 + 256;
      double y = sin(t + i * 0.01234) * 196 + 256;
      context.beginPath();
      context.arc(x, y, 10, 0, PI * 2, true);
      context.fill();
    }
    stats.end();
  }

  window.requestAnimationFrame(draw);
}
