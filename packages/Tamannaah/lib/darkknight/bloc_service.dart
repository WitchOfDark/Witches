import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ToWidget {
  Widget toWidget();
}

abstract class ToMap {
  Map<String, dynamic> toMap();
}

abstract class Service {
  bool initialized = false;
  Future<void> init([dynamic obj]) async {}
}

class BlocService {
  final Service? service;

  //Probably no need to use Multirepository provider, access service only through bloc
  // final RepositoryProvider Function() serviceProvider;
  final BlocProvider Function() blocProvider;

  // final BlocConsumer Function(Widget child)? blocConsumer;

  BlocService({
    this.service,
    // required this.serviceProvider,
    required this.blocProvider,
    // this.blocConsumer,
  });
}
