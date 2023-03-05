// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

import 'package:tamannaah/darkknight/utils.dart';

import 'rainbow.dart';

const Widget empty = SizedBox();

const EdgeInsets
    //Edges
    e0 = EdgeInsets.zero,
    e2 = EdgeInsets.all(2),
    e4 = EdgeInsets.all(4),
    e6 = EdgeInsets.all(6),
    e8 = EdgeInsets.all(8),
    e12 = EdgeInsets.all(12),
    e16 = EdgeInsets.all(16),
    e20 = EdgeInsets.all(20),
    e24 = EdgeInsets.all(24),
    e32 = EdgeInsets.all(32),
    //
    e2h = EdgeInsets.symmetric(horizontal: 2),
    e4h = EdgeInsets.symmetric(horizontal: 4),
    e6h = EdgeInsets.symmetric(horizontal: 6),
    e8h = EdgeInsets.symmetric(horizontal: 8),
    e12h = EdgeInsets.symmetric(horizontal: 12),
    e16h = EdgeInsets.symmetric(horizontal: 16),
    e20h = EdgeInsets.symmetric(horizontal: 20),
    e24h = EdgeInsets.symmetric(horizontal: 24),
    e32h = EdgeInsets.symmetric(horizontal: 32),
    //
    e2v = EdgeInsets.symmetric(vertical: 2),
    e4v = EdgeInsets.symmetric(vertical: 4),
    e6v = EdgeInsets.symmetric(vertical: 6),
    e8v = EdgeInsets.symmetric(vertical: 8),
    e12v = EdgeInsets.symmetric(vertical: 12),
    e16v = EdgeInsets.symmetric(vertical: 16),
    e20v = EdgeInsets.symmetric(vertical: 20),
    e24v = EdgeInsets.symmetric(vertical: 24),
    e32v = EdgeInsets.symmetric(vertical: 32),
    //
    e8h4v = EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    e24h8v = EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    e48h8v = EdgeInsets.symmetric(horizontal: 48, vertical: 8);

BorderRadius brRgen({required double W, required int ltrb}) {
  assert(ltrb < 1112 && ltrb > -1);
  ltrb = 10000 + ltrb;
  bool bl = (ltrb % 10) == 0 ? false : true;
  ltrb = ltrb ~/ 10;
  bool br = (ltrb % 10) == 0 ? false : true;
  ltrb = ltrb ~/ 10;
  bool tr = (ltrb % 10) == 0 ? false : true;
  ltrb = ltrb ~/ 10;
  bool tl = (ltrb % 10) == 0 ? false : true;

  return BorderRadius.only(
    topLeft: tl ? Radius.circular(W) : Radius.zero,
    topRight: tr ? Radius.circular(W) : Radius.zero,
    bottomRight: br ? Radius.circular(W) : Radius.zero,
    bottomLeft: bl ? Radius.circular(W) : Radius.zero,
  );
}

const BorderRadius brR_no = BorderRadius.zero;
final BorderRadius
    //BorderRadius
    brR_a_2 = brRgen(W: 2, ltrb: 1111),
    brR_a_4 = brRgen(W: 4, ltrb: 1111),
    brR_a_6 = brRgen(W: 6, ltrb: 1111),
    brR_a_8 = brRgen(W: 8, ltrb: 1111),
    brR_a_10 = brRgen(W: 10, ltrb: 1111),
    brR_a_16 = brRgen(W: 16, ltrb: 1111),
    brR_a_24 = brRgen(W: 24, ltrb: 1111),
    brR_a_32 = brRgen(W: 32, ltrb: 1111),
    brR_t_10 = brRgen(W: 10, ltrb: 1100),
    brR_b_10 = brRgen(W: 10, ltrb: 0011),
    brR_l_10 = brRgen(W: 10, ltrb: 1001),
    brR_r_10 = brRgen(W: 10, ltrb: 0110),
    brR_tr_10 = brRgen(W: 10, ltrb: 0100),
    brR_lb_tr_10 = brRgen(W: 10, ltrb: 0101);

final List<BoxShadow>
    //
    sdw1 = [
  const BoxShadow(
    color: Colors.black,
    spreadRadius: 3,
    blurRadius: 5,
    offset: Offset(0, 4),
  ),
];

// @immutable
class Deco {
  final int accent;
  final int? inv;

  //Dimensions
  final double? W, H;
  final EdgeInsets? pad, mar;

  //
  final Alignment? align;
  final BoxFit? fit;

  //Decoration
  final Gradient? grad;
  final Color? B;
  final Color? S;
  final BorderRadius? brR;
  Border? br;
  BorderSide bs;
  double bW;
  Color? bC;
  int ltrb;

  final bool bevel;
  final List<BoxShadow>? sdw;
  final double? elv;

  //Font
  final TextStyle? fgf;
  final double? fs;
  final double? fls;
  final FontWeight? fw;
  final int? fml;
  final TextOverflow? fto;
  final Color? F;

  Deco(
    this.accent, {
    this.inv,

    //Dimensions
    this.W,
    this.H,
    this.pad,
    this.mar,
    this.align,
    this.fit,

    //Decoration
    this.grad,
    this.B,
    this.S,
    this.bW = 0,
    this.bC,
    this.ltrb = 1111,
    this.bevel = false,
    this.brR,
    this.br,
    this.bs = BorderSide.none,
    this.sdw,
    this.elv,

    //Font
    this.fgf,
    this.fs,
    this.fls,
    this.fw,
    this.fml,
    this.fto,
    this.F,
  }) {
    assert((accent < Grain.maxAccent && accent >= 0) && ((inv ?? 0) < Grain.maxAccent && (inv ?? 0) >= 0));

    int _ltrb = ltrb;
    if (brR != null) {
      _ltrb = _ltrb == 1111 ? 1111 : 0000;
    }

    if (bW != 0) {
      bs = BorderSide(width: bW, color: bC ?? S ?? gS);

      assert(_ltrb < 1112 && _ltrb > -1);
      _ltrb = 10000 + _ltrb;
      bool b = (_ltrb % 10) == 0 ? false : true;
      _ltrb = ltrb ~/ 10;
      bool r = (_ltrb % 10) == 0 ? false : true;
      _ltrb = _ltrb ~/ 10;
      bool t = (_ltrb % 10) == 0 ? false : true;
      _ltrb = _ltrb ~/ 10;
      bool l = (_ltrb % 10) == 0 ? false : true;

      br = Border(
        left: l ? bs : BorderSide.none,
        top: t ? bs : BorderSide.none,
        right: r ? bs : BorderSide.none,
        bottom: b ? bs : BorderSide.none,
      );
    } else {
      br = null;
    }
  }

  Deco operator +(covariant Deco d) {
    final add = Deco(
      accent,
      inv: d.inv ?? inv,

      //Dimensions
      W: d.W ?? W,
      H: d.H ?? H,
      pad: d.pad ?? pad,
      mar: d.mar ?? mar,
      align: d.align ?? align,
      fit: d.fit ?? fit,

      //Decoration
      grad: d.grad ?? grad,
      B: d.B ?? B,
      S: d.S ?? S,
      br: d.br ?? br,
      bs: d.bs != BorderSide.none ? d.bs : bs,
      brR: d.brR ?? brR,
      bevel: d.bevel,
      sdw: d.sdw ?? sdw,
      elv: d.elv ?? elv,

      //Font
      fgf: d.fgf ?? fgf,
      fs: d.fs ?? fs,
      fls: d.fls ?? fls,
      fw: d.fw ?? fw,
      fml: d.fml ?? fml,
      fto: d.fto ?? fto,
      F: d.F ?? F,
    );

    return add;
  }

  Map<String, Map> toMap() {
    final map = {
      'accent': accent,
      'alt': inv,
      'W': W,
      'H': H,
      'pad': pad,
      'mar': mar,
      'align': align,
      'fit': fit,
      'grad': grad,
      'B': B?.value,
      'S': S?.value,
      'br': br,
      'brR': brR,
      'bs': bs,
      'ltrb': ltrb,
      'bW': bW,
      'bevel': bevel,
      'sdw': sdw?.length,
      'elv': elv,
      'fgf': fgf,
      'fs': fs,
      'fls': fls,
      'fw': fw,
      'fml': fml,
      'fto': fto,
      'F': F?.value,
    };

    return {
      'Deco': maptoJson(map, removeNull: true),
    };
  }

  Deco cp({
    int? accent,
    int? alt,
    double? W,
    double? H,
    EdgeInsets? pad,
    EdgeInsets? mar,
    Alignment? align,
    BoxFit? fit,
    Gradient? grad,
    Color? B,
    Color? S,
    Border? br,
    BorderRadius? brR,
    BorderSide? bs,
    int? ltrb,
    Color? bC,
    double? bW,
    bool? bevel,
    List<BoxShadow>? sdw,
    double? elv,
    TextStyle? fgf,
    double? fs,
    double? fls,
    FontWeight? fw,
    int? fml,
    TextOverflow? fto,
    Color? F,
  }) {
    final add = Deco(
      accent ?? this.accent,
      inv: alt ?? this.inv,

      //Dimensions
      W: W ?? this.W,
      H: H ?? this.H,
      pad: pad ?? this.pad,
      mar: mar ?? this.mar,
      align: align ?? this.align,
      fit: fit ?? this.fit,

      //Decoration
      grad: grad ?? this.grad,
      B: B ?? this.B,
      S: S ?? this.S,
      br: br ?? this.br,
      bs: bs ?? this.bs,
      bC: bC ?? this.bC,
      bW: bW ?? this.bW,
      ltrb: ltrb ?? this.ltrb,
      brR: brR ?? this.brR,
      bevel: bevel ?? this.bevel,
      sdw: sdw ?? this.sdw,
      elv: elv ?? this.elv,

      //Font
      fgf: fgf ?? this.fgf,
      fs: fs ?? this.fs,
      fls: fls ?? this.fls,
      fw: fw ?? this.fw,
      fml: fml ?? this.fml,
      fto: fto ?? this.fto,
      F: F ?? this.F,
    );

    return add;
  }

  Color get gB => rain[accent].B;
  Color get gF => rain[accent].F;
  Color get gS => rain[accent].S;
  Color get hB => B ?? gB;
  Color get hF => F ?? gF;
  Color get hS => S ?? gS;

  Deco get BFS => cp(F: hB, B: hF, S: hS);
  Deco get SFB => cp(F: hS, B: hF, S: hB);
  Deco get BSF => cp(F: hB, B: hS, S: hF);
  Deco get SBF => cp(F: hS, B: hB, S: hF);
  Deco get FSB => cp(F: hF, B: hS, S: hB);

  Deco get iBS => cp(F: hF.i);
  Deco get FiS => cp(B: hB.i);
  Deco get FBi => cp(S: hS.i);
  Deco get Fii => cp(B: hB.i, S: hS.i);
  Deco get iBi => cp(F: hF.i, S: hS.i);
  Deco get iiS => cp(F: hF.i, B: hB.i);
  Deco get iii => cp(F: hF.i, B: hB.i, S: hS.i);

  Deco get act => cp(F: hF, B: hB, S: hS);
  Deco get alt => inv != null ? cp(accent: inv) : iii;
}
