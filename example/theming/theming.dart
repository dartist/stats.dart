import 'dart:html';
import 'dart:math';
import 'package:stats/stats.dart';

void main() {
  Stats stats = new Stats();
  document.body.children.add(stats.container);
  CanvasElement canvas = new CanvasElement();
  canvas.width = 512;
  canvas.height = 512;
  document.body.children.add(canvas);
  CanvasRenderingContext2D context = canvas.getContext('2d');
  context.fillStyle = 'rgba(127,0,255,0.05)';

  draw(t) {
    var time = t;
    context.clearRect(0, 0, 512, 512);

    stats.begin();

    for ( var i = 0; i < 2000; i ++ ) {

      var x = cos(time + i * 0.01) * 196 + 256;
      var y = sin(time + i * 0.01234) * 196 + 256;

      context.beginPath();
      context.arc( x, y, 10, 0, PI * 2, true );
      context.fill();

    }

    stats.end();
    window.requestAnimationFrame(draw);
  }

  window.requestAnimationFrame(draw);
}
