import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'remote_event.dart';
part 'remote_state.dart';

class RemoteBloc {
  var state = RemoteState(70);

  final eventController = StreamController<RemoteEvent>();

  final stateController = StreamController<RemoteState>();

  RemoteBloc() {
    eventController.stream.listen(
      (RemoteEvent event) {

        if (event is IncrementEvent) {
          state = RemoteState(state.volume + event.increment);
        }
        else if (event is DecrementEvent){
          state = RemoteState(state.volume - event.decrement);
        }
        else {
          state = RemoteState(0);
        }

        stateController.sink.add(state);
      }
    );
  }
  void dispose () {
    stateController.close();
    eventController.close();
  }
}