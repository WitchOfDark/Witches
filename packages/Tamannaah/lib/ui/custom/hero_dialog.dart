import 'package:flutter/material.dart';

import 'dart:ui';

class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    Rect? begin,
    Rect? end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);

    return Rect.fromLTRB(
      lerpDouble(begin?.left, end?.left, elasticCurveValue)!,
      lerpDouble(begin?.top, end?.top, elasticCurveValue)!,
      lerpDouble(begin?.right, end?.right, elasticCurveValue)!,
      lerpDouble(begin?.bottom, end?.bottom, elasticCurveValue)!,
    );
  }
}

const String _heroAddTodo = 'add-todo-hero';

class AddTodoButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const AddTodoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              barrierDismissible: true,
              opaque: false,
              barrierColor: Colors.transparent,
              pageBuilder: (context, _, __) {
                return _AddTodoPopupCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const FlutterLogo(),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'New todo',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                      ),
                      const Divider(color: Colors.white, thickness: 0.2),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Write a note',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                        maxLines: 6,
                      ),
                      const Divider(color: Colors.white, thickness: 0.2),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        child: Hero(
          // flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
          //   switch (flightDirection) {
          //     case HeroFlightDirection.push:
          //       return ScaleTransition(
          //         scale: animation.drive(
          //           Tween<double>(
          //             begin: 0.0,
          //             end: 1.0,
          //           ).chain(
          //             CurveTween(
          //               curve: Curves.fastOutSlowIn,
          //             ),
          //           ),
          //         ),
          //         child: toHeroContext.widget,
          //       );
          //     case HeroFlightDirection.pop:
          //       return fromHeroContext.widget;
          //     // default:
          //   }
          // },
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.white10,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.add_rounded,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _AddTodoPopupCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          // flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
          //   switch (flightDirection) {
          //     case HeroFlightDirection.push:
          //       return ScaleTransition(
          //         scale: animation.drive(
          //           Tween<double>(
          //             begin: 0.0,
          //             end: 1.0,
          //           ).chain(
          //             CurveTween(
          //               curve: Curves.fastOutSlowIn,
          //             ),
          //           ),
          //         ),
          //         child: toHeroContext.widget,
          //       );
          //     case HeroFlightDirection.pop:
          //       return fromHeroContext.widget;
          //     // default:
          //   }
          // },
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.purple,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
