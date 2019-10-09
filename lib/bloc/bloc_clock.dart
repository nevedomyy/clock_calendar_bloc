import 'dart:async';
import 'dart:math' as math;


class BLoCClock{
  final _controller = StreamController<List<double>>();
  static Timer _timer;
  List<double> _angle = List(2);

  Stream<List<double>> get stream => _controller.stream;

  update() async{
    if(_timer!=null && _timer.isActive) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      _angle[0] = -math.pi+(double.tryParse(DateTime.now().minute.toString())*6*math.pi/180 ?? 0);
      _angle[1] = -math.pi+(double.tryParse(DateTime.now().hour.toString())*30*math.pi/180 ?? 0);
      _controller.sink.add(_angle);
    });
  }

  timerClose() => _timer.cancel();

  dispose() => _controller.close();
}