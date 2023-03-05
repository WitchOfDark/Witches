import 'package:bloc/bloc.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:tamannaah/darkknight/error/fire_error.dart';

import '../fire_service.dart';
import '../fire_user.dart';

//
//
//          State
//
//
@immutable
abstract class FireAuthState {}

class SFireAuthOut extends FireAuthState {}

class SFireAuthIn extends FireAuthState with EquatableMixin {
  final FireUser user;

  SFireAuthIn({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class SFireAuthLoading extends FireAuthState with EquatableMixin {
  final String? loading;

  SFireAuthLoading({this.loading});

  @override
  List<Object?> get props => [loading];
}

class SFireAuthError extends FireAuthState with EquatableMixin {
  final FireError? error;

  SFireAuthError({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

//
//
//          Event
//
//
@immutable
abstract class FireAuthEvent {}

class EFireAuthIn extends FireAuthEvent {}

class EFireAuthOut extends FireAuthEvent {}

class EFireAuthVerify extends FireAuthEvent {}

class EFireAuthLogOut extends FireAuthEvent {
  final FireMoon? method;

  EFireAuthLogOut({this.method});
}

class EFireAuthDelete extends FireAuthEvent {}

class EFireAuthLogIn extends FireAuthEvent {
  final FireMoon method;
  final String? email;
  final String? password;

  EFireAuthLogIn({required this.method, this.email, this.password});
}

class EFireAuthSignIn extends FireAuthEvent {
  final FireMoon method;
  final String email;
  final String password;

  EFireAuthSignIn({required this.method, required this.email, required this.password});
}

class EFireAuthReset extends FireAuthEvent {
  final String email;

  EFireAuthReset({required this.email});
}

//
//
//          Bloc
//
//
class FireAuthBloc extends Bloc<FireAuthEvent, FireAuthState> {
  FireAuthBloc() : super(SFireAuthOut()) {
    // FireService.status.listen((bool loggedIn) {
    //   owl('*************************************************');
    //   lava('I am Silence among secrets $loggedIn');
    //   Future.delayed(const Duration(seconds: 10), () {
    //     lava('I am Delayed Logged In : $loggedIn');
    //     loggedIn ? add(EFireAuthIn()) : add(EFireAuthOut());

    //     lava('*************************************************');
    //   });
    //   owl('*************************************************');
    // });

    // //
    // lava('Bloc Experiment');
    // (FireService.user != null) ? add(EFireAuthIn()) : add(EFireAuthOut());

    on<EFireAuthIn>((event, emit) {
      dino('Logged In : ${FireService.user?.toMap()}');
      dino('*************************************************');

      emit(SFireAuthIn(user: FireService.user!));
    });

    on<EFireAuthOut>((event, emit) {
      unicorn('Logged Out : ${FireService.user?.toMap()}');
      unicorn('*************************************************');

      emit(SFireAuthOut());
    });

    on<EFireAuthLogIn>((event, emit) async {
      emit(SFireAuthLoading(
        loading: 'Logging in',
      ));

      FireError? error =
          await FireService.providers[event.method]?.logIn(email: event.email ?? '', password: event.password ?? '');

      lava('EFireAuthLogIn : ${error?.toMap()}');
      error == null ? emit(SFireAuthIn(user: FireService.user!)) : emit(SFireAuthError(error: error));
    });

    on<EFireAuthLogOut>((event, emit) async {
      emit(SFireAuthLoading(
        loading: 'Logging out',
      ));

      lava('Logout : ${event.method}');
      if (event.method != null) {
        FireError? error = await FireService.providers[event.method]?.logOut();

        error == null ? emit(SFireAuthOut()) : emit(SFireAuthError(error: error));
      } else {
        FireError? error = await FireService.logOut();
        lava(error?.toMap());

        error == null ? emit(SFireAuthOut()) : emit(SFireAuthError(error: error));
      }
    });

    on<EFireAuthSignIn>((event, emit) async {
      emit(SFireAuthLoading(
        loading: 'Signing In',
      ));

      FireError? error =
          await FireService.providers[event.method]?.signIn(email: event.email, password: event.password);

      error == null ? add(EFireAuthVerify()) : emit(SFireAuthError(error: error));
    });

    on<EFireAuthVerify>((event, emit) async {
      emit(SFireAuthLoading(
        loading: 'Sending Email verification mail',
      ));

      FireError? error = await FireService.providers[FireMoon.email]?.verify();
      if (error == null) {
        emit(SFireAuthLoading(loading: 'Sent'));
        Future.delayed(const Duration(seconds: 5), () {
          emit(SFireAuthOut());
        });
      } else {
        emit(SFireAuthError(error: error));
      }
    });

    on<EFireAuthReset>((event, emit) async {
      emit(SFireAuthLoading(
        loading: 'Sending Password Reset mail',
      ));
      FireError? error = await FireService.providers[FireMoon.email]?.reset(email: event.email);
      if (error == null) {
        emit(SFireAuthLoading(loading: 'Sent'));
        Future.delayed(const Duration(seconds: 5), () {
          emit(SFireAuthOut());
        });
      } else {
        emit(SFireAuthError(error: error));
      }
    });

    on<EFireAuthDelete>((event, emit) async {
      emit(SFireAuthLoading(
        loading: 'Deleting account',
      ));

      FireError? error = await FireService.providers[FireMoon.email]?.delete();
      error == null ? emit(SFireAuthOut()) : emit(SFireAuthError(error: error));
    });
  }
}
