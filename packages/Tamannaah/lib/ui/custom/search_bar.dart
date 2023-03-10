import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../forms/v6_text.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';

import '../../ui/d_theme.dart';

import '../primitive.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with SingleTickerProviderStateMixin {
  late AnimationController _con;
  late TextEditingController _textEditingController;
  int toggle = 0;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _con = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 90, 123, 254),
      child: Center(
        child: Container(
          height: 70.0,
          width: 250.0,
          color: Colors.red,
          alignment: const Alignment(-1.0, 0.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 375),
            height: 48.0,
            width: (toggle == 0) ? 48.0 : 250.0,
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: -10.0,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 375),
                  top: 6.0,
                  right: 7.0,
                  curve: Curves.easeOut,
                  child: AnimatedOpacity(
                    opacity: (toggle == 0) ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F3F7),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: AnimatedBuilder(
                        builder: (context, widget) {
                          return Transform.rotate(
                            angle: _con.value * 2.0 * pi,
                            child: widget,
                          );
                        },
                        animation: _con,
                        child: const Icon(
                          Icons.mic,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 375),
                  left: (toggle == 0) ? 20.0 : 40.0,
                  curve: Curves.easeOut,
                  top: 11.0,
                  child: AnimatedOpacity(
                    opacity: (toggle == 0) ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      height: 23.0,
                      color: Colors.yellow,
                      width: 180.0,
                      child: TextField(
                        controller: _textEditingController,
                        cursorRadius: const Radius.circular(10.0),
                        cursorWidth: 2.0,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Search...',
                          labelStyle: const TextStyle(
                            color: Color(0xff5B5B5B),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  child: IconButton(
                    splashRadius: 19.0,
                    padding: const EdgeInsets.all(12.0),
                    icon: const Icon(Icons.add_alarm_outlined),
                    onPressed: () {
                      setState(
                        () {
                          if (toggle == 0) {
                            toggle = 1;
                            _con.forward();
                          } else {
                            toggle = 0;
                            _textEditingController.clear();
                            _con.reverse();
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchAnimate extends StatefulWidget {
  const SearchAnimate({Key? key}) : super(key: key);

  @override
  State<SearchAnimate> createState() => _SearchAnimateState();
}

class _SearchAnimateState extends State<SearchAnimate> with SingleTickerProviderStateMixin {
  late final TextEditingController textCon;

  late final AnimationController con;
  late final Tween<double> tween;
  late final Animation<double> anim;

  @override
  void initState() {
    super.initState();
    textCon = TextEditingController();
    con = AnimationController(vsync: this, duration: 375.ms);
    tween = Tween<double>(begin: 0, end: 1);
    anim = tween.animate(con);
  }

  @override
  void dispose() {
    con.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: con,
      builder: (context, child) => mBox(
        deco: dError,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icoBtn(
              Icons.alarm_add,
              deco: dIc7.cp(fs: 22),
              () async {
                if (con.isCompleted || con.isAnimating) {
                  await con.reverse();
                } else {
                  await con.forward();
                }
              },
            ),
            SizedBox(
              width: anim.value * 150,
              child: V6Text(
                name: 'name',
                hint: 'hint',
                deco: dError.cp(fs: 20),
                controller: textCon,
              ),
            ),
            Container(
              width: anim.value * 40,
              height: anim.value * 40,
              transformAlignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(anim.value * 2 * pi),
              child: icoBtn(
                Icons.mic,
                () {
                  lava(textCon.text);
                },
                deco: dIc7.cp(
                  S: Colors.blue.withOpacity(anim.value),
                  fs: anim.value * 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
