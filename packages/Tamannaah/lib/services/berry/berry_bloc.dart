import 'package:darkknight/debug_functions.dart';
import 'package:darkknight/utils.dart';
import 'package:darkknight/error/fire_error.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../ui/mario/mario.dart';

//
//
//          State
//
//
@immutable
abstract class BerryState {
  const BerryState();
}

class SBerryInitial extends BerryState {}

class SBerryData extends BerryState with EquatableMixin {
  final dynamic data;

  const SBerryData(this.data);

  @override
  List<Object?> get props => [data];
}

class SBerryLoading extends BerryState {}

class SBerryError extends BerryState with EquatableMixin {
  final FireError error;
  const SBerryError(this.error);

  @override
  List<Object> get props => [error];
}

//
//
//          Event
//
//
@immutable
abstract class BerryEvent {
  const BerryEvent();
}

class EBerryDo extends BerryEvent {
  final Function() function;

  const EBerryDo(this.function);
}

//
//
//          Bloc
//
//
class BerryBloc extends Bloc<BerryEvent, BerryState> {
  BerryBloc() : super(SBerryInitial()) {
    //
    on<EBerryDo>((event, emit) async {
      emit(SBerryLoading());

      FireError? error = await fire(() async {
        final data = await event.function();
        dino(data.runtimeType);
        emit(SBerryData(data));
        return null;
      });
      if (error != null) {
        lava(error.toMap());

        emit(SBerryError(error));
      }
    });
  }
}

//
//
//          Widget
//
//
class BerryWidget<D> extends StatelessWidget {
  const BerryWidget({Key? key, this.berryBloc, required this.builder, required this.init}) : super(key: key);

  final Widget Function(BerryBloc bloc, D? data) builder;
  final void Function(BerryBloc bloc) init;
  final BerryBloc? berryBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BerryBloc>(
      create: (context) => berryBloc ?? BerryBloc(),
      child: BlocConsumer<BerryBloc, BerryState>(
        listener: (context, state) {
          // owl('Listening Berry');
          BerryBloc berryBloc = BlocProvider.of<BerryBloc>(context);
          SBerryError? sBerryError = cast<SBerryError>(berryBloc.state);
          sBerryError?.error.showAlert(context);

          if (cast<SBerryLoading>(berryBloc.state) != null) {
            // FireError(title: 'Loading', text: '...').showAlert(context);
            LoadingScreen().show(context: context, text: 'Loading Berry');
          } else {
            LoadingScreen().hide();
          }
        },
        listenWhen: (previous, current) {
          // owl('listenWhen Berry');
          return true;
        },
        buildWhen: (previous, current) {
          // owl('buildWhen Berry');
          return cast<SBerryData>(current) != null;
        },
        builder: (context, snapshot) {
          BerryBloc berryBloc = BlocProvider.of<BerryBloc>(context);
          SBerryData? sBerryData = cast<SBerryData>(berryBloc.state);

          dino('Builder Berry ${berryBloc.state.runtimeType}');

          if (cast<SBerryInitial>(berryBloc.state) != null) {
            dino("Init Function");
            init(berryBloc);
          }

          D? data = cast<D>(sBerryData?.data);

          return builder(berryBloc, data);
        },
      ),
    );
  }
}

extension RuntimeTypeContext on BuildContext {
  Type? get blocType => cast<SBerryData>(BlocProvider.of<BerryBloc>(this).state)?.data.runtimeType;
}

extension RuntimeTypeBloc on BerryBloc {
  Type? get blocType => cast<SBerryData>(state)?.data.runtimeType;
}
