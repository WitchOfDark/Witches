import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tamannaah/darkknight/debug_functions.dart';

class Creeper extends BlocObserver {
  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   super.onEvent(bloc, event);
  //   unicorn('${bloc.runtimeType} $event');
  // }

  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   owl('${bloc.runtimeType} $change');
  // }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    dino(
        // '${bloc.runtimeType}
        '${transition.event.runtimeType} : ${transition.currentState.runtimeType} -> ${transition.nextState.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    lava('${bloc.runtimeType} $error $stackTrace');
  }

  @override
  void onClose(BlocBase bloc) {
    lava('${bloc.runtimeType} Closed');
    super.onClose(bloc);
  }
}
