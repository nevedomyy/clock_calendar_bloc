import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/bloc_clock.dart';
import '../bloc/bloc.dart';
import 'button.dart';
import 'board.dart';
import 'min_arrow.dart';
import 'hour_arrow.dart';
import 'red_arrow.dart';


class ClockCalendar extends StatefulWidget {
   @override
  _ClockCalendarState createState() => _ClockCalendarState();
}

class _ClockCalendarState extends State<ClockCalendar> with WidgetsBindingObserver{
  final String _url = 'https://github.com/';
  final List<String> _initialList = List.generate(9, (_) => '');
  Offset _scaleDelta = Offset(0, 0);
  double _scaleFactor = 1;
  BLoCClock _blocClock;
  BLoC _bloc;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _blocClock = BLoCClock();
    _bloc = BLoC();
    _blocClock.update();
    _bloc.update();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused) _blocClock.timerClose();
    if(state == AppLifecycleState.resumed) _blocClock.update();
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _blocClock.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double boardSize = 890*(width-32)/1650;
    final double arrowSize = 220*(width-32)/1650;
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: _bloc.stream,
            initialData: _initialList,
            builder: (context, snapshot){
              return Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      snapshot?.data[0] ?? '',
                      style: Theme.of(context).textTheme.body2,
                    )
                  ),
                  Center(
                    child: Text(
                      snapshot?.data[1] ?? '',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        snapshot?.data[2] ?? '',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Spacer(),
                      Text(
                        snapshot?.data[3] ?? '',
                        style: Theme.of(context).textTheme.body1,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        snapshot?.data[4] ?? '',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Spacer(),
                      Text(
                        snapshot?.data[5] ?? '',
                        style: Theme.of(context).textTheme.body1,
                      )
                    ],
                  ),
                  Spacer(flex: 2),
                  GestureDetector(
                    onScaleEnd: (data){
                      _scaleFactor = 1;
                      _scaleDelta = Offset(0, 0);
                      setState(() {});
                    },
                    onScaleUpdate: (data){
                      _scaleFactor = data.scale;
                      _scaleDelta = Offset(data.localFocalPoint.dx-width/2, data.localFocalPoint.dy-width/2);
                      setState(() {});
                    },
                    child: Transform.scale(
                      scale: _scaleFactor,
                      child: Transform.translate(
                        offset: _scaleDelta,
                        child: SizedBox.fromSize(
                            size: Size.square(width),
                            child: StreamBuilder(
                              stream: _blocClock.stream,
                              initialData: List.generate(2, (_) => 0.0),
                              builder: (context, snapshotClock){
                                return Stack(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/watchbbg.png',
                                      fit: BoxFit.cover,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: boardSize/2+arrowSize-32),
                                        child: Transform.rotate(
                                          alignment: Alignment.topCenter,
                                          angle: double.tryParse(snapshot?.data[8]) ?? 0,
                                          child: CustomPaint(
                                            size: Size(arrowSize/3, boardSize/2+arrowSize),
                                            painter: RedArrow(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 32.0),
                                        child: CustomPaint(
                                          size: Size.fromRadius(boardSize/2),
                                          painter: Board(),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: boardSize/2-32),
                                        child: Transform.rotate(
                                          alignment: Alignment.topCenter,
                                          angle: snapshotClock?.data[1] ?? 0,
                                          child: CustomPaint(
                                            size: Size(1, boardSize/2),
                                            painter: HArrow(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: boardSize/2-32),
                                        child: Transform.rotate(
                                          alignment: Alignment.topCenter,
                                          angle: snapshotClock?.data[0] ?? 0,
                                          child: CustomPaint(
                                            size: Size(1, boardSize/2),
                                            painter: MArrow(),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Text(
                      snapshot?.data[6] ?? '',
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                  Center(
                    child: Text(
                      snapshot?.data[7] ?? '',
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                  Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AppButton(
                        caption: 'btn1',
                        onTap: (){},
                      ),
                      AppButton(
                        caption: 'btn2',
                        onTap: (){},
                      ),
                      AppButton(
                        caption: 'btn3',
                        onTap: () async{
                          if (await canLaunch(_url)) {
                            await launch(_url);
                          } else print ('Could not launch');
                        },
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}