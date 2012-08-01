stats.dart
==========

#### Dart Performance Monitor ####

This class provides a simple info box that will help you monitor your code performance.

* **FPS** Frames rendered in the last second. The higher the number the better.
* **MS** Milliseconds needed to render a frame. The lower the number the better.

### Screenshots ###

![stats_js_fps.png](http://mrdoob.github.com/stats.js/assets/stats_js_fps.png)
![stats_js_ms.png](http://mrdoob.github.com/stats.js/assets/stats_js_ms.png)

### Usage ###

```dart
#import('dart:html');
#import('../../src/stats.dart');
void main() {
  Stats stats = new Stats();
  document.body.elements.add(stats.container);
  CanvasElement canvas = new CanvasElement();
  canvas.width = 512;
  canvas.height = 512;
  document.body.elements.add(canvas);
  CanvasRenderingContext2D context = canvas.getContext( '2d' );
  context.fillStyle = 'rgba(127,0,255,0.05)';
  
  draw(t) {
    var time = t;
    context.clearRect( 0, 0, 512, 512 );

    stats.begin();

    for ( var i = 0; i < 2000; i ++ ) {

      var x = Math.cos( time + i * 0.01 ) * 196 + 256;
      var y = Math.sin( time + i * 0.01234 ) * 196 + 256;

      context.beginPath();
      context.arc( x, y, 10, 0, Math.PI * 2, true );
      context.fill();

    }

    stats.end();
    window.requestAnimationFrame(draw);
  }
  
  window.requestAnimationFrame(draw);
}
```