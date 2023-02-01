import 'package:flutter/material.dart';

import 'primitive.dart' as prim;

import 'd_theme.dart';
import 'decoration.dart';

class Lego {
  final String name;
  final IconData icon;
  final Deco deco;
  final void Function()? fn;

  Lego({
    Deco? deco,
    this.name = '..name..',
    this.icon = Icons.icecream_outlined,
    this.fn,
  }) : deco = deco ?? dBtn8;

  @override
  String toString() {
    return name;
  }

  Widget tx() {
    return prim.tx(name, deco: deco);
  }

  Widget row({MainAxisAlignment align = MainAxisAlignment.spaceAround, bool max = false}) {
    return prim.row(name, icon, align: align, max: max);
  }

  Widget rowrev({MainAxisAlignment align = MainAxisAlignment.spaceAround, bool max = false}) {
    return prim.rowrev(name, icon, align: align, max: max);
  }

  Widget icf() {
    return prim.icf(icon, label: name, deco: deco);
  }

  Widget icc() {
    return prim.icc(icon, label: name, deco: deco);
  }

  Widget ico() {
    return prim.ico(icon, label: name, deco: deco);
  }

  Widget btn({bool max = false, MainAxisAlignment align = MainAxisAlignment.start}) {
    Deco d = deco.disable(fn == null);

    return prim.btn(
      child: prim.box(
        child: prim.rowrev(name, icon, max: max, align: align, deco: d),
        deco: d.cp(
          B: Colors.transparent,
          mar: e0,
        ),
      ),
      fn: fn,
      deco: d.cp(bW: 0),
    );
  }

  Widget txBtn() {
    Deco d = deco.disable(fn == null);

    return prim.txbtn(name, fn: fn, deco: d);
  }

  Widget icfBtn() {
    return prim.icfBtn(icon, fn, label: name, deco: deco.disable(fn == null));
  }

  Widget iccBtn() {
    return prim.iccBtn(icon, fn, label: name, deco: deco.disable(fn == null));
  }

  Widget icoBtn() {
    return prim.icoBtn(icon, fn, label: name, deco: deco.disable(fn == null));
  }

  Widget popup() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(width: 10),
        ico(),
        const SizedBox(width: 20),
        tx(),
      ],
    );
  }
}
