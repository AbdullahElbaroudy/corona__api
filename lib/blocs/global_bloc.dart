import 'dart:async';

import 'package:covid_19/api/global_api.dart';
import 'package:covid_19/models/global_model.dart';

class GlobalBloc {
  
  Global global;

  final StreamController<Global> _globalStreamController =
      StreamController<Global>();
  Stream<Global> get globalStream => _globalStreamController.stream;
  StreamSink<Global> get globalSink => _globalStreamController.sink;

  final StreamController<Global> _addGlobalStreamController =
      StreamController<Global>();
  Stream<Global> get addGlobalStream => _globalStreamController.stream;
  StreamSink<Global> get addGlobalSink => _globalStreamController.sink;


addGlobal(Global global){
  globalSink.add(global);
}

  GlobalBloc() {
    global = Global(
        newConfirmed: 0,
        newDeaths: 0,
        newRecovered: 0,
        totalDeaths: 0,
        totalConfirmed: 0,
        totalRecovered: 0);
    _globalStreamController.add(global);

  _addGlobalStreamController.stream.listen(addGlobal);

  }

  dispose() {
      _globalStreamController.close();
    _addGlobalStreamController.close();
  }
}
