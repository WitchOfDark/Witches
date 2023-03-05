import 'package:tamannaah/darkknight/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../forms/orca_field.dart';
import '../decoration.dart';
import '../primitive.dart';

T? searchWidget<T>(BuildContext context) {
  T? detective;
  context.visitChildElements((element) {
    // lava('${element.widget.runtimeType} : ${element.widget is T}   :   $T');

    if (element.widget is T) {
      detective = element.widget as T;
    } else {
      detective = searchWidget<T>(element) ?? detective;
    }
  });
  // dino(detective);
  return detective;
}

class LionLink {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final OrcaField? orcaField;
  final Widget? widget;
  final void Function()? fn;
  final Deco deco;

  LionLink({
    required this.deco,
    required this.title,
    this.subtitle,
    this.icon,
    this.orcaField,
    this.widget,
    this.fn,
  });

  Widget build() {
    final Deco d = deco.disable(fn == null);
    return box(
      deco: Deco(5, B: Colors.transparent, H: 55, mar: d.mar),
      child: btn(
        deco: d.cp(elv: 0),
        fn: fn != null
            ? () {
                BuildContext? childContext = cast<GlobalKey>(orcaField?.key)?.currentContext;
                if (childContext != null) {
                  // print(childContext);
                  // GestureDetector? detector = searchWidget<GestureDetector>(childContext);
                  // if (detector?.onTap != null) detector?.onTap!();

                  Actions? act = searchWidget<Actions>(childContext);
                  act?.actions.entries.elementAt(0).value.invoke(const ActivateIntent());

                  // print(" ::::  ${formKey.currentState.value}");
                  // print(
                  //     " ::::  ${formKey.currentState?.fields[e.value?.name]?.transformedValue}");
                  // formKey.currentState?.fields[e.value?.name]?.didChange(
                  //     (!formKey.currentState?.fields[e.value?.name]?.transformedValue));

                  CupertinoSwitch? s = searchWidget<CupertinoSwitch>(childContext);
                  s?.onChanged!(!s.value);

                  // print(s);

                  FocusScope.of(childContext).unfocus();
                  // FocusScope.of(Scaffold.of(childContext).context).requestFocus();

                  if (fn != null) fn!();
                }
              }
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (icon != null) ico(icon, deco: deco, label: title),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  empty,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      (subtitle == null)
                          ? tx(title, deco: d)
                          : Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tx(title, deco: d),
                                if (subtitle != null) tx(subtitle ?? 'sub', deco: d.cp(fs: (d.fs ?? 17) - 5)),
                              ],
                            ),
                      const Spacer(),
                      widget ?? empty,
                      const SizedBox(width: 10),
                      orcaField?.build() ?? empty,
                      if (orcaField == null) ico(CupertinoIcons.chevron_forward, deco: d)
                    ],
                  ),
                  const Divider(height: 5, thickness: 0, color: Color.fromARGB(45, 55, 55, 55)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppleBox extends StatelessWidget {
  const AppleBox({Key? key, required this.lions, required this.deco}) : super(key: key);

  final List<LionLink> lions;
  final Deco deco;

  @override
  Widget build(BuildContext context) {
    assert(lions.isNotEmpty);
    return box(
      deco: deco,
      child: Column(
        children: lions.map((e) => e.build()).toList(),
      ),
    );
  }
}
