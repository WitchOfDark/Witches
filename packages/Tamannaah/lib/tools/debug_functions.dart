import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stack_trace/stack_trace.dart';

const String
    //
    reset = "\x1B[0m",
    fBlack = "\x1B[30m",
    fRed = "\x1B[31m",
    fGreen = "\x1B[32m",
    fYellow = "\x1B[33m",
    fBlue = "\x1B[34m",
    fMagenta = "\x1B[35m",
    fCyan = "\x1B[36m",
    fWhite = "\x1B[37m",
    bBlack = "\x1B[40m",
    bRed = "\x1B[41m",
    bGreen = "\x1B[42m",
    bYellow = "\x1B[43m",
    bBlue = "\x1B[44m",
    bMagenta = "\x1B[45m",
    bCyan = "\x1B[46m",
    bWhite = "\x1B[47m";

const List<String> color = [
  //
  bRed + fWhite,
  bMagenta + fYellow,
  bWhite + fBlack,
  bYellow + fBlack,
  bBlue + fWhite,
  bGreen + fBlack,
  bBlack + fYellow,
];

List<Map<String, String>> logs = [];

// Timer? _debounce;
// StreamController<Map<String, String>> logStream = StreamController<Map<String, String>>()
//   ..stream.listen(
//     (event) {
//       if (_debounce?.isActive ?? false) _debounce?.cancel();
//       _debounce = Timer(
//         const Duration(milliseconds: 2000),
//         () {
//           log('$bRed${fWhite}_______________________________________________$reset');
//           _debounce?.cancel();
//         },
//       );
//     },
//   );

void dividerline() {
  log('${fWhite}  ■  ∙  ÷  =  ≡  ─  ×  ☼  ■  ∙  ÷  =  ≡  ─  ×  ☼  $reset');
}

StreamController<Map<String, String>> logStream =
    StreamController<Map<String, String>>()
      ..stream.debounceTime(const Duration(seconds: 2)).listen(
        (event) {
          dividerline();
        },
      );

final JsonEncoder _encoder = JsonEncoder.withIndent(
  '  ',
  (object) {
    return object.toString();
  },
);

dynamic beautifyMap(dynamic obj) {
  if (obj is Map /*obj.runtimeType.toString().contains("Map")*/) {
    // final dividerline = {
    //   'Deco': Map.fromEntries(
    //     obj.entries.where((e) => e.value != null).map(
    //           (e) => MapEntry(
    //             e.key,
    //             e.value?.toString(),
    //           ),
    //         ),
    //   ),
    // };

    // return _encoder.convert(dividerline);

    return _encoder.convert(obj);
  }
  return obj.toString();
}

String _stack(bool s) {
  Trace st = Trace.from(StackTrace.current).terse;
  List<String> frame2 = st.frames[2].toString().split(" ");
  String fileHash = color.elementAt(
    (frame2[0]
            .codeUnits
            .fold<int>(0, (previousValue, element) => previousValue + element) %
        color.length),
  );
  if (s) {
    // log("  🍪 ${color['fYellow']} ${st.frames.length > 4 ? "[${st.frames[4].member}] -> " : ""}<${st.frames[3].member}> -> (${st.frames[2].member}) ->${color['bBlack']} ${("${frame2[0]}:${frame2[1].split(":").first}").replaceAll("../../lib", "E:\\_Temp\\tamannaah\\lib").replaceAll("package:monkey", "E:\\_Temp\\cracker\\lib").replaceAll("/", "\\")} $reset");
    log('$fileHash ${("${frame2[0]}:${frame2[1].split(":").first}").replaceAll("../../lib", "E:\\_Temp\\tamannaah\\lib").replaceAll("package:monkey", "E:\\_Temp\\cracker\\lib").replaceAll("/", "\\")} ');
  }
  return '$fileHash ${frame2[0].split('/').last.split('.').first.toUpperCase()} $reset';
}

taco(dynamic obj, {bool stack = false}) {
  log("\x1B[2J\x1B[0;0H");

  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Lava": text});
    logStream.add({"Lava": text});
    log("  🌮 ${_stack(false)} $fBlack $text $reset");
    // log(text);
  }
}

lava(dynamic obj, {bool stack = false}) {
  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Lava": text});
    logStream.add({"Lava": text});
    log("  🌋 ${_stack(false)} $fRed $text $reset");
    // log(text);
  }
}

unicorn(dynamic obj, {bool stack = false}) {
  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Unicorn": text});
    logStream.add({"Lava": text});
    log("  🦄 ${_stack(false)} $fMagenta $text $reset");
    // log(text);
  }
}

dino(dynamic obj, {bool stack = false}) {
  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Dino": text});
    logStream.add({"Lava": text});
    log("  🦖 ${_stack(false)} $fGreen $text $reset");
    // log(text);
  }
}

owl(dynamic obj, {bool stack = false}) {
  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Owl": text});
    logStream.add({"Lava": text});
    log("  🦉 ${_stack(false)} $fCyan $text $reset");
    // log(text);
  }
}
