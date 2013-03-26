part of fpsstats;

class Stats {

  Stopwatch _timer = new Stopwatch();

  int _ms = 0,
      _msMin = 1000,
      _msMax = 0,
      _fps = 0,
      _fpsMin = 1000,
      _fpsMax = 0,
      _frames = 0,
      _mode = 0;

  // ui elements
  DivElement container,
             fpsDiv,
             msDiv,
             msText,
             msGraph,
             fpsGraph,
             fpsText;


  void _onContainerMouseDown(MouseEvent e) {
    e.preventDefault();
    mode = ++mode % 2;
  }

  // gui creation
  void _createUi() {
    SpanElement bar;

    container = new DivElement()
      ..id = 'stats'
      ..onMouseDown.listen(_onContainerMouseDown)
      ..style.cssText = 'width:80px;opacity:0.9;cursor:pointer';

    fpsDiv = new DivElement()
      ..id = 'fps'
      ..style.cssText = 'padding:0 0 3px 3px;text-align:left;background-color:#002';

    container.append(fpsDiv);

    fpsText = new DivElement()
      ..id = 'fpsText'
      ..style.cssText = 'color:#0ff;font-family:Helvetica,Arial,sans-serif;font-size:9px;font-weight:bold;line-height:15px'
      ..text = 'FPS';
    fpsDiv.append(fpsText);

    fpsGraph = new DivElement()
      ..id = 'fpsGraph'
      ..style.cssText = 'position:relative;width:74px;height:30px;background-color:#0ff';
    fpsDiv.append(fpsGraph);

    while (fpsGraph.children.length < 74) {
      bar = new SpanElement()
        ..style.cssText = 'width:1px;height:30px;float:left;background-color:#113';
      fpsGraph.append(bar);
    }

    msDiv = new DivElement()
      ..id = 'ms'
      ..style.cssText = 'padding:0 0 3px 3px;text-align:left;background-color:#020;display:none';
    container.append(msDiv);

    msText = new DivElement()
      ..id = 'msText'
      ..style.cssText = 'color:#0f0;font-family:Helvetica,Arial,sans-serif;font-size:9px;font-weight:bold;line-height:15px'
      ..text = 'MS';
    msDiv.append(msText);

    msGraph = new DivElement()
      ..id = 'msGraph'
      ..style.cssText = 'position:relative;width:74px;height:30px;background-color:#0f0';
    msDiv.append(msGraph);

    while (msGraph.children.length < 74) {
      bar = new SpanElement()
        ..style.cssText = 'width:1px;height:30px;float:left;background-color:#131';
      msGraph.append(bar);
    }
  }

  void set mode(int value) {
    if (_mode != value) {
      _mode = value;
      switch (mode) {
        case 0:
          fpsDiv.style.display = 'block';
          msDiv.style.display = 'none';
          break;
        case 1:
          fpsDiv.style.display = 'none';
          msDiv.style.display = 'block';
          break;
      }
    }
  }

  int get mode => _mode;

  Stats() {
    _createUi();
  }

  void updateGraph(Element element, num value) {
    Element first = element.children.first;
    element.children.add(first);
    first.style.height = '${value.toInt()}px';
  }

  void begin() {
    _timer.start();
  }

  int end() {
    int time = _timer.elapsedMilliseconds;

    _ms = _timer.elapsedMilliseconds;
    _msMin = min(_msMin, _ms);
    _msMax = max(_msMax, _ms);
    msText.text = '$_ms MS ($_msMin - $_msMax)';
    updateGraph(msGraph, min(30, 30 - (_ms / 200) * 30));

    _frames++;

    if (time > 1000) {
      _fps =  ((_frames * 1000) / _ms).round().toInt();
      _fpsMin = min(_fpsMin, _fps);
      _fpsMax = max(_fpsMax, _fps);

      fpsText.text = '$_fps FPS ($_fpsMin - $_fpsMax)';

      updateGraph(fpsGraph, min(30, 30 - (_fps / 100) * 30));

      _timer.reset();
      _frames = 0;
    }
    return time;
  }

  void update() {
    end();
  }
}