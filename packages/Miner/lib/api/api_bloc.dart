// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:tamannaah/darkknight/bloc_service.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:tamannaah/darkknight/error/fire_error.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api_service.dart';

//
//
//          State
//
//
abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class SApiInitial extends ApiState {}

class SApiData extends ApiState {
  final dynamic data;

  const SApiData(this.data);

  @override
  List<Object> get props => [data];
}

class SApiLoading extends ApiState {}

class SApiError extends ApiState {
  final FireError error;
  const SApiError(this.error);

  @override
  List<Object> get props => [error];
}

//
//
//          Event
//
//
abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object> get props => [];
}

class EApiGet extends ApiEvent {
  final String url;
  final Function(String s)? decoder;

  final String ext;
  final int mem;
  final int disk;

  const EApiGet(this.url, {this.decoder, this.ext = "", this.mem = -1, this.disk = -1});

  Map<String, Map> toMap() {
    return {
      'EApiGet': {
        "url": url,
        "ext": ext,
        "mem": mem,
        "disk": disk,
      }
    };
  }
}

//
//
//          Bloc
//
//
class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiService _apiService;

  ApiBloc(this._apiService) : super(SApiInitial()) {
    //Events
    on<EApiGet>((event, emit) async {
      dino(event.toMap());

      emit(SApiLoading());

      FireError? error = await fire(() async {
        Api? api = await _apiService.get(
          event.url,
          ext: event.ext,
          mem: event.mem,
          disk: event.disk,
        );

        if (api == null) {
          lava('Api Error');
          emit(SApiError(FireError(text: '...', title: 'Api error 🍄')));
        } else {
          if (event.decoder == null) {
            emit(SApiData(api.data /*, api*/));
          } else {
            dynamic data = await event.decoder!(api.data);
            if (data != null) {
              emit(SApiData(data));
            }
          }
        }

        return null;
      });
      if (error != null) {
        lava(error.toMap());

        emit(SApiError(error));
      }
    });
  }
}

BlocService apiBlocService() {
  ApiService apiService = ApiService();

  return BlocService(
    service: apiService,
    // serviceProvider: () {
    //   return RepositoryProvider<ApiService>(
    //     create: (context) => apiService,
    //   );
    // },
    blocProvider: () {
      return BlocProvider<ApiBloc>(
        create: (context) => ApiBloc(apiService),
      );
    },
  );
}
