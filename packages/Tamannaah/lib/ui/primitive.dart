// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tamannaah/darkknight/utils.dart';
import 'package:flutter/material.dart';

import '../forms/orca_field.dart';
import 'd_theme.dart';
import 'decoration.dart';

extension Kajal on Deco {
  Decoration bDeco() {
    if (brR == brR_no) {
      return BoxDecoration(
        color: hB,
        border: br,
        gradient: grad,
        shape: BoxShape.circle,
      );
    }
    return BoxDecoration(
      color: hB,
      border: br,
      boxShadow: sdw,
      gradient: grad,
      borderRadius: brR,
    );
  }

  InputDecoration iDeco({
    String? hintText,
    Widget? prefix,
    Widget? suffix,
    Widget? label,
  }) {
    if (bevel) {
      return InputDecoration(
        border: UnderlineInputBorder(
          borderSide: bs.copyWith(
              color: Colors
                  .blue), // ?? const BorderSide(width: 1, color: Color.fromARGB(255, 103, 122, 246)), //BorderSide.none,
          borderRadius: brR ?? brR_no,
        ),
        // enabledBorder: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: bs.copyWith(
              color: Colors
                  .purple), // ?? const BorderSide(width: 1, color: Color.fromARGB(255, 221, 221, 221)), //BorderSide.none,
          borderRadius: brR ?? brR_no,
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 244, 244, 244)), //BorderSide.none,
          borderRadius: brR ?? brR_no,
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 255, 84, 65)), //BorderSide.none,
          borderRadius: brR ?? brR_no,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 255, 239, 68)), //BorderSide.none,
          borderRadius: brR ?? brR_no,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: bs.copyWith(
              color: Colors.orange), // ?? BorderSide(width: 1, color: S ?? const Color.fromARGB(255, 167, 167, 167)),
          borderRadius: brR ?? brR_no,
        ),

        isDense: true,
        fillColor: hB,
        filled: true, //B != null ? true : false,

        //label icon + text
        //prefix as icon + label as text + hinttext
        // prefix: prefix,0
        prefixIcon: prefix,
        // prefixText: 'Hello',

        label: label ?? (hintText != null && hintText.startsWith('_') ? Text(hintText.substring(1)) : null),
        hintText: label == null && prefix == null && !(hintText?.startsWith('_') ?? false) ? hintText : null,

        hintStyle: cp(F: hS).ts(),

        contentPadding: pad ?? e12,
        errorMaxLines: 1,
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12, height: 0.8),

        suffixIcon: suffix,
      );
    }
    return InputDecoration /*collapsed*/ (
      border: OutlineInputBorder(
        borderSide: bs.copyWith(
            color: Colors
                .blue), // ?? const BorderSide(width: 1, color: Color.fromARGB(255, 103, 122, 246)), //BorderSide.none,
        borderRadius: brR ?? brR_no,
      ),
      // enabledBorder: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderSide: bs.copyWith(
            color: Colors
                .purple), // ?? const BorderSide(width: 1, color: Color.fromARGB(255, 221, 221, 221)), //BorderSide.none,
        borderRadius: brR ?? brR_no,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 244, 244, 244)), //BorderSide.none,
        borderRadius: brR ?? brR_no,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 255, 84, 65)), //BorderSide.none,
        borderRadius: brR ?? brR_no,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 255, 239, 68)), //BorderSide.none,
        borderRadius: brR ?? brR_no,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: bs.copyWith(
            color: Colors.orange), // ?? BorderSide(width: 1, color: S ?? const Color.fromARGB(255, 167, 167, 167)),
        borderRadius: brR ?? brR_no,
      ),
      isDense: true,
      fillColor: hB,
      filled: true, //B != null ? true : false,

      //label icon + text
      //prefix as icon + label as text + hinttext
      // prefix: prefix,0
      prefixIcon: prefix,
      // prefixText: 'Hello',

      label: label ?? (hintText != null && hintText.startsWith('_') ? Text(hintText.substring(1)) : null),
      hintText: label == null && prefix == null && !(hintText?.startsWith('_') ?? false) ? hintText : null,

      hintStyle: cp(F: hS).ts(),

      contentPadding: pad ?? e12,
      errorMaxLines: 1,
      errorStyle: const TextStyle(color: Colors.red, fontSize: 12, height: 0.8),

      suffixIcon: suffix,
    );
  }

  TextStyle ts() {
    return (fgf ?? const TextStyle()).copyWith(
      fontSize: fs,
      fontWeight: fw,
      color: hF,
      letterSpacing: fls,
      overflow: fto,
    );
  }

  List<Deco> gen() {
    return [
      this,
      BFS,
      BSF,
      FSB,
      SFB,
      SBF,
      FBi,
      BFS.FBi,
      BSF.FBi,
      FSB.FBi,
      SFB.FBi,
      SBF.FBi,
      iBS,
      BFS.iBS,
      BSF.iBS,
      FSB.iBS,
      SFB.iBS,
      SBF.iBS,
      FiS,
      BFS.FiS,
      BSF.FiS,
      FSB.FiS,
      SFB.FiS,
      SBF.FiS,
      Fii,
      BFS.Fii,
      BSF.Fii,
      FSB.Fii,
      SFB.Fii,
      SBF.Fii,
      iBi,
      BFS.iBi,
      BSF.iBi,
      FSB.iBi,
      SFB.iBi,
      SBF.iBi,
      iiS,
      BFS.iiS,
      BSF.iiS,
      FSB.iiS,
      SFB.iiS,
      SBF.iiS,
      iii,
      BFS.iii,
      BSF.iii,
      FSB.iii,
      SFB.iii,
      SBF.iii,
    ];
  }

  Widget genWidget(String name, IconData icono, void Function() fn) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: gen()
          .map(
            (d) => btn(
              child: Column(
                children: [
                  tx(name),
                  ico(icono),
                ],
              ),
              fn: fn,
              deco: d.cp(
                fs: 18,
                pad: e12,
                mar: e32,
              ),
            ),
          )
          .toList(),
    );
  }

  Deco disable(bool condition) {
    return condition
        ? cp(
            F: const Color.fromARGB(255, 174, 174, 174),
            B: const Color.fromARGB(255, 255, 255, 255),
            S: const Color.fromARGB(255, 182, 182, 182),
          )
        : this;
  }
}

Widget mapToWidget(Map<String, dynamic> map) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: map.entries
        .map(
          (e) => Text('${e.key} : ${e.value}'),
        )
        .toList(),
  );
}

class Soup<T> extends StatefulWidget {
  const Soup({Key? key, required this.initValue, required this.builder, this.dispose = emptyFunction})
      : super(key: key);

  final T initValue;
  final Widget Function(T initState, void Function(T value) soupState) builder;
  final void Function(T state) dispose;

  @override
  State<Soup<T>> createState() => _SoupState<T>();
}

class _SoupState<T> extends State<Soup<T>> {
  late T initValue;

  @override
  void initState() {
    super.initState();
    initValue = widget.initValue;
  }

  @override
  void dispose() {
    widget.dispose(initValue);
    super.dispose();
  }

  void soupState(T fn) {
    setState(() {
      initValue = fn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(initValue, soupState);
  }
}

class Diw extends InheritedWidget {
  final Deco? deco;

  const Diw(
    this.deco, {
    super.key,
    required super.child,
  });

  static Deco? ofd(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Diw>()?.deco;
  }

  @override
  bool updateShouldNotify(covariant Diw oldWidget) {
    return deco != oldWidget.deco;
  }
}

class DataCon<T> {
  T? data;
  DataCon({this.data});

  void set(T d) {
    data = d;
  }
}

class DataBox<T> extends InheritedWidget {
  final DataCon<T> data;

  const DataBox({super.key, required this.data, required super.child});

  static DataCon<T>? of<T>(BuildContext context) {
    return cast<DataCon<T>>(context.dependOnInheritedWidgetOfExactType<DataBox<T>>()?.data);
  }

  @override
  bool updateShouldNotify(covariant DataBox oldWidget) {
    return data != oldWidget.data;
  }
}

Widget box({final Widget? child, final Deco? deco}) {
  if (deco?.fit != null) {
    return FittedBox(
      fit: deco?.fit ?? BoxFit.contain,
      child: child,
    );
  }

  return Container(
    decoration: deco?.bDeco(),
    padding: deco?.pad,
    margin: deco?.mar,
    width: deco?.W,
    height: deco?.H,
    alignment: deco?.align,
    child: child,
  );
}

extension Texty on Text {
  Text cp(Deco? deco) {
    return tx(data ?? '', deco: deco);
  }
}

Text tx(String s, {Deco? deco}) {
  // Deco d = deco ?? dH3;

  return Text(
    s,
    style: deco?.ts(), //d.ts(),
    maxLines: deco?.fml, //d.fml,
    semanticsLabel: s,
    textScaleFactor: 1,
  );
}

Widget txb(String s, {Deco? deco}) {
  return box(child: tx(s, deco: deco), deco: deco);
}

Widget rowCol({
  required final List<Widget> children,
  required final bool row,
  final MainAxisSize mainAxisSize = MainAxisSize.min,
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
}) {
  return row
      ? Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        )
      : Column(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
}

Widget header({
  required Widget title,
  required Widget child,
  bool showHeader = true,
  required bool row,
  bool rev = false,
}) {
  return showHeader
      ? row
          ? Row(
              mainAxisSize: MainAxisSize.max,
              children: rev
                  ? [
                      title,
                      Expanded(
                        child: child,
                      ),
                    ].reversed.toList()
                  : [
                      title,
                      Expanded(
                        child: child,
                      ),
                    ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rev ? [title, child].reversed.toList() : [title, child],
            )
      : child;
}

Widget ico(IconData? icon, {String? label, Deco? deco}) {
  if (icon == null) return empty;

  Deco d = deco ?? dIc7;

  return Icon(
    icon,
    size: (d.fs ?? 20) + 4,
    color: d.hS,
    semanticLabel: label,
    shadows: d.sdw,
  );
}

Widget icc(IconData? icon, {String? label, Deco? deco}) {
  if (icon == null) return empty;

  Deco d = deco ?? dIc7;

  return box(
    child: Icon(
      icon,
      size: (d.fs ?? 20) + 4,
      color: d.hS,
      semanticLabel: label,
      shadows: d.sdw,
    ),
    deco: d.cp(B: Colors.transparent),
  );
}

Widget icf(IconData? icon, {String? label, Deco? deco}) {
  if (icon == null) return empty;

  Deco d = deco ?? dIc7;

  return box(
    child: Icon(
      icon,
      size: (d.fs ?? 20) + 4,
      color: d.hS,
      semanticLabel: label,
      shadows: d.sdw,
    ),
  );
}

Widget icfBtn(IconData icon, void Function()? fn, {String? label, Deco? deco}) {
  Deco d = deco ?? dIc7;

  return inky(
    child: icf(icon, label: label, deco: d.cp(B: Colors.transparent, bW: 0, mar: e0)),
    onTap: fn,
    deco: d,
  );
}

Widget iccBtn(IconData icon, void Function()? fn, {String? label, Deco? deco}) {
  Deco d = deco ?? dIc7;

  return inky(
    child: icc(icon, label: label, deco: d.cp(bW: 0, mar: e0)),
    onTap: fn,
    deco: d.cp(B: Colors.transparent, bW: 0, elv: 0),
  );
}

Widget icoBtn(IconData icon, void Function()? fn, {String? label, Deco? deco}) {
  Deco d = deco ?? dIc7;

  return IconButton(
    icon: ico(icon, label: label, deco: d),
    onPressed: fn,
    iconSize: (d.fs ?? 20) + 4,
    padding: d.pad ?? e2,
    tooltip: label,
    color: d.hF,
    splashColor: d.hS,
    splashRadius: (d.fs ?? 20) + 4,
  );
}

Widget inky({required Widget child, void Function()? onTap, void Function()? onPress, Deco? deco}) {
  return Container(
    height: deco?.H,
    width: deco?.W,
    // padding: deco?.pad,
    margin: deco?.mar,
    decoration: deco?.bDeco(),
    alignment: deco?.align,
    child: Material(
      shape: deco?.brR == brR_no
          ? CircleBorder(side: deco?.bs ?? BorderSide.none)
          : RoundedRectangleBorder(
              side: deco?.bs ?? BorderSide.none,
              borderRadius: deco?.brR ?? brR_no,
            ),
      elevation: deco?.elv ?? 0,
      color: Colors.transparent, //deco?.B,
      shadowColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onPress,
        child: Ink(
          child: child,
        ),
      ),
    ),
  );
}

Widget mBox({required Widget child, Deco? deco}) {
  return Container(
    margin: deco?.mar,
    child: Material(
      shape: deco?.brR == brR_no
          ? CircleBorder(side: deco?.bs ?? BorderSide.none)
          : RoundedRectangleBorder(
              side: deco?.bs ?? BorderSide.none,
              borderRadius: deco?.brR ?? brR_no,
            ),
      elevation: deco?.elv ?? 0,
      color: deco?.B,
      clipBehavior: Clip.antiAlias,
      child: box(
        deco: deco?.cp(B: Colors.transparent, mar: e0),
        child: child,
      ),
    ),
  );
}

Widget txbtn(String name, {void Function()? fn, Deco? deco}) {
  // Deco d = deco ?? dBtn8;

  return TextButton(onPressed: fn, child: tx(name, deco: deco));

  // return btn(
  //   child: txb(name, deco: d.cp(B: Colors.transparent, bW: 0, mar: e0, align: Alignment.center)),
  //   deco: d,
  //   fn: fn,
  // );
}

Widget row(String name, IconData icon,
    {MainAxisAlignment align = MainAxisAlignment.spaceAround, bool max = false, Deco? deco}) {
  return Row(
    mainAxisSize: max ? MainAxisSize.max : MainAxisSize.min,
    mainAxisAlignment: align,
    children: [
      const SizedBox(width: 10),
      tx(name, deco: deco),
      const SizedBox(width: 10),
      ico(icon, deco: deco),
      const SizedBox(width: 10),
    ],
  );
}

Widget rowrev(String name, IconData icon,
    {MainAxisAlignment align = MainAxisAlignment.spaceAround, bool max = false, Deco? deco}) {
  return Row(
    mainAxisSize: max ? MainAxisSize.max : MainAxisSize.min,
    mainAxisAlignment: align,
    children: [
      const SizedBox(width: 10),
      ico(icon, deco: deco),
      const SizedBox(width: 10),
      tx(name, deco: deco),
      const SizedBox(width: 10),
    ],
  );
}

Widget btn({required Widget child, void Function()? fn, Deco? deco}) {
  Deco d = deco?.disable(fn == null) ?? dBtn8;
  return Container(
    margin: d.mar,
    child: ElevatedButton(
      onPressed: fn,
      style: ElevatedButton.styleFrom(
        side: d.bs,
        padding: EdgeInsets.zero,
        // padding: d.pad,
        // minimumSize: Size.zero,
        shape: d.brR != null
            ? (d.bevel
                ? BeveledRectangleBorder(borderRadius: d.brR ?? brR_no)
                : RoundedRectangleBorder(borderRadius: d.brR ?? brR_no))
            : null,
        foregroundColor: d.hF,
        backgroundColor: d.hB,
        // disabledBackgroundColor: const Color.fromARGB(255, 233, 233, 233),
        // disabledBackgroundColor: Colors.transparent,
        textStyle: d.ts(),
        alignment: d.align,
        elevation: d.elv,
      ),
      child: child,
    ),
  );
}

Widget badge({required String name, required Widget child, required Alignment align}) {
  return Stack(
    alignment: align,
    children: [
      child,
      txb(name),
    ],
  );
}
