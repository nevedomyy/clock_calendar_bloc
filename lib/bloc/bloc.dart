import 'package:hijri/umm_alqura_calendar.dart';
import '../data/data.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'dart:async';


class BLoC{
  final _controller = StreamController<List<String>>();
  final AppData _data = AppData();
  List<String> _list = List(9);

  Stream<List<String>> get stream => _controller.stream;

  update() async{
    int delta = int.tryParse(DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays.toString()) ?? 0;
    int delta2 = int.tryParse(DateTime.now().difference(DateTime(DateTime.now().year, 8, 24)).inDays.toString()) ?? 0;
    _list[0] = DateFormat.d().add_MMM().add_y().format(DateTime.now());
    _list[1] = ummAlquraCalendar.now().toFormat("MMMM dd yyyy");
    _list[2] = _getFromList3(delta);
    _list[3] = _getFromList1(delta);
    _list[4] = _getFromList4(delta);
    _list[5] = _getFromList2(delta2);
    _list[6] = _data.bottomText1;
    _list[7] = _data.bottomText2;
    _list[8] = (-math.pi+(360*(365-delta)/365)*math.pi/180).toString();
    _controller.sink.add(_list);
  }

  String _getFromList1(int current){
    if(current<=39 && current>=14) return _data.list1[3];
    if(current<=65 && current>=40) return _data.list1[4];
    if(current<=90 && current>=66) return _data.list1[5];
    if(current<=116 && current>=91) return _data.list1[6];
    if(current<=155 && current>=117) return _data.list1[7];
    if(current<=168 && current>=156) return _data.list1[8];
    if(current<=181 && current>=169) return _data.list1[9];
    if(current<=194 && current>=182) return _data.list1[10];
    if(current<=207 && current>=195) return _data.list1[11];
    if(current<=220 && current>=208) return _data.list1[12];
    if(current<=233 && current>=221) return _data.list1[13];
    if(current<=285 && current>=234) return _data.list1[0];
    if(current<=338 && current>=286) return _data.list1[1];
    return _data.list1[2];
  }

  String _getFromList2(int current){
    if(current<0) current += 365;
    if(current>=360 && current<=364) return '';
    if(current>=10) {
      int tmp = int.tryParse(current.toString()[(current>=100?1:0)]) ?? 0;
      return _data.list2[tmp];
    }
    return _data.list2[0];
  }

  String _getFromList3(int current){
    if(current<=48 && current>=20) return _data.list3[10];
    if(current<=78 && current>=49) return _data.list3[11];
    if(current<=107 && current>=79) return _data.list3[0];
    if(current<=138 && current>=108) return _data.list3[1];
    if(current<=170 && current>=139) return _data.list3[2];
    if(current<=201 && current>=171) return _data.list3[3];
    if(current<=232 && current>=202) return _data.list3[4];
    if(current<=263 && current>=233) return _data.list3[5];
    if(current<=294 && current>=264) return _data.list3[6];
    if(current<=325 && current>=295) return _data.list3[7];
    if(current<=354 && current>=326) return _data.list3[8];
    return _data.list3[9];
  }

  String _getFromList4(int current){
    if(current<=149 && current>=59) return _data.list4[3];
    if(current<=241 && current>=150) return _data.list4[0];
    if(current<=333 && current>=242) return _data.list4[1];
    return _data.list4[2];
  }

  dispose() => _controller.close();
}