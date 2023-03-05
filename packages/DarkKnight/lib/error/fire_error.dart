import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show BuildContext, Navigator, immutable;
import 'package:flutter/services.dart';

import 'package:tamannaah/ui/d_theme.dart';
import 'package:tamannaah/ui/mario/mario.dart';
import 'package:tamannaah/ui/primitive.dart';

@immutable
class FireError with EquatableMixin {
  final String title;
  final String text;

  FireError({
    required this.title,
    required this.text,
  });

  @override
  List<Object?> get props => [title, text];

  Map<String, Map> toMap() {
    return {
      'FireError': {
        'title': title,
        'text': text,
      }
    };
  }

  Future<void> showAlert(BuildContext context) {
    return showGenericDialog<bool>(
      context: context,
      title: title,
      content: text,
      actions: [
        txbtn('Ok', fn: () => Navigator.pop(context)),
      ],
      deco: dError,
    );
  }

  static setMode(AttackMode mode) {
    fire = mode;
  }
}

typedef AttackMode = Future<FireError?> Function(Future<FireError?> Function() v);

AttackMode fire = goblinFire;

AttackMode goblinFire = (Future<FireError?> Function() v) async {
  try {
    return (await v());
  } on FileSystemException catch (e) {
    return FireError(
      title: 'File System Exception',
      text: '🍄 ${e.message}',
    );
  } on FormatException catch (e) {
    return FireError(
      title: 'Format Exception',
      text: '🍨 ${e.message}',
    );
  } on TimeoutException catch (e) {
    return FireError(
      title: 'Timeout Exception',
      text: '🥗 ${e.message}',
    );
  } on SocketException catch (e) {
    return FireError(
      title: 'Socket Exception',
      text: '🍒 ${e.message}',
    );
  } on PlatformException catch (e) {
    return FireError(
      title: 'Platform Exception',
      text: '☕ ${e.message}',
    );
  } on NoSuchMethodError catch (e) {
    return FireError(
      title: 'No Such Method Exception',
      text: '🍰 $e',
    );
  } on Exception catch (e) {
    return FireError(
      title: 'Error : ${e.runtimeType.toString()}',
      text: '🎂 $e',
    );
  }
};
