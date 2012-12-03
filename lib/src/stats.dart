part of fpsstats;

class Stats {
  Date startTime;
  Date prevTime;
  Duration ms;
  int msMin = 1000, msMax = 0;
  double fps = 0.0, fpsMin = 1000.0, fpsMax = 0.0;
  int frames = 0, mode = 0;
  DivElement container;
  DivElement fpsDiv;
  DivElement msDiv;
  DivElement msText;
  DivElement msGraph;
  DivElement fpsGraph;
  DivElement fpsText;

  Stats() {
    ms = new Duration();
    startTime = new Date.now();
    prevTime = startTime;

    container = new DivElement();
    container.id = 'stats';
    container.on.mouseDown.add((event) {
      event.preventDefault();
      setMode( ++ mode % 2 );
    });

    container.style.cssText = 'width:80px;opacity:0.9;cursor:pointer';

    fpsDiv = new DivElement();
    fpsDiv.id = 'fps';
    fpsDiv.style.cssText = 'padding:0 0 3px 3px;text-align:left;background-color:#002';
    container.children.add(fpsDiv);

    fpsText = new DivElement();
    fpsText.id = 'fpsText';
    fpsText.style.cssText = 'color:#0ff;font-family:Helvetica,Arial,sans-serif;font-size:9px;font-weight:bold;line-height:15px';
    fpsText.innerHTML = 'FPS';
    fpsDiv.children.add(fpsText);

    fpsGraph = new DivElement();
    fpsGraph.id = 'fpsGraph';
    fpsGraph.style.cssText = 'position:relative;width:74px;height:30px;background-color:#0ff';
    fpsDiv.children.add(fpsGraph);

    while (fpsGraph.children.length < 74) {
      var bar = new SpanElement();
      bar.style.cssText = 'width:1px;height:30px;float:left;background-color:#113';
      fpsGraph.children.add(bar);
    }

    msDiv = new DivElement();
    msDiv.id = 'ms';
    msDiv.style.cssText = 'padding:0 0 3px 3px;text-align:left;background-color:#020;display:none';
    container.children.add(msDiv);

    msText = new DivElement();
    msText.id = 'msText';
    msText.style.cssText = 'color:#0f0;font-family:Helvetica,Arial,sans-serif;font-size:9px;font-weight:bold;line-height:15px';
    msText.innerHTML = 'MS';
    msDiv.children.add(msText);

    msGraph = new DivElement();
    msGraph.id = 'msGraph';
    msGraph.style.cssText = 'position:relative;width:74px;height:30px;background-color:#0f0';
    msDiv.children.add(msGraph);

    while (msGraph.children.length < 74) {
      var bar = new SpanElement();
      bar.style.cssText = 'width:1px;height:30px;float:left;background-color:#131';
      msGraph.children.add(bar);

    }
  }

  void setMode(value) {
    mode = value;

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

  updateGraph(Element element, value) {
    var first = element.children.first;
    element.children.add(first);
    first.style.height = "${value.toInt()}px";
  }

  void begin() {
    startTime = new Date.now();
  }

  Date end() {
    Date time = new Date.now();

    ms = time.difference(startTime);

    msMin = min(msMin, ms.inMilliseconds);
    msMax = max(msMax, ms.inMilliseconds);


    msText.innerHTML = "$ms MS ($msMin - $msMax)";
    updateGraph( msGraph, min(30, 30 - (ms.inMilliseconds / 200) * 30));

    frames++;
    if (time.millisecondsSinceEpoch > prevTime.millisecondsSinceEpoch + 1000) {

      fps =  (( frames * 1000 ) / (time.difference(prevTime).inMilliseconds)).round();
      fpsMin = min(fpsMin, fps);
      fpsMax = max(fpsMax, fps);

      fpsText.innerHTML = "$fps FPS ($fpsMin - $fpsMax)";

      updateGraph(fpsGraph, min(30, 30 - (fps / 100) * 30));

      prevTime = time;
      frames = 0;

    }

    return time;
  }

  void update() {
    startTime = this.end();
  }
}