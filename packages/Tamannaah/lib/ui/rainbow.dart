import 'package:flutter/material.dart' show Color, Colors, ListView, Row, Widget, immutable;

import '../ui/primitive.dart';

import 'decoration.dart';

@immutable
class Accent {
  final Color F, B, S;

  const Accent({
    required this.F,
    required this.B,
    required this.S,
  });

  Widget toWidget() {
    return box(
      child: Row(
        children: [
          box(deco: Deco(0, W: 30, H: 30, B: F)),
          box(deco: Deco(0, W: 30, H: 30, B: B)),
          box(deco: Deco(0, W: 30, H: 30, B: S)),
        ],
      ),
    );
  }

  Map<String, Map> toMap() => {
        'Accent': {
          'B': B.toString(),
          'F': F.toString(),
          'S': S.toString(),
        }
      };
}

@immutable
class Rainbow {
  final String name;
  final String logo;

  final List<Accent> accent;

  const Rainbow({
    required this.name,
    required this.logo,
    required this.accent,
  });

  Widget toWidget() {
    return box(
      deco: Deco(0, W: 90, H: 160),
      child: ListView.builder(
        itemBuilder: (context, int i) {
          return accent[i].toWidget();
        },
        itemCount: accent.length,
      ),
    );
  }

  Rainbow operator +(covariant Rainbow r) {
    return Rainbow(
      name: r.name,
      logo: r.logo,
      accent: [
        ...r.accent,
        ...accent.sublist(r.accent.length),
      ],
    );
  }

  @override
  String toString() => 'Rainbow(name: $name, logo: $logo, accent : ${accent.length})';
}

late final int _maxAccent;

late final List<Rainbow> _globalRainbows;

int _oneRainbow = 0;

@immutable
class Grain {
  Grain(List<Rainbow> rainbows) {
    final hello = [...rainbows, ...darkSun];

    Rainbow longest = hello.fold<Rainbow>(hello[0], (p, v) => (v.accent.length > p.accent.length) ? v : p);

    _maxAccent = longest.accent.length;

    _globalRainbows = hello.map((e) => longest + e).toList();
  }

  static int get maxAccent => _maxAccent;

  static set oneRainbow(int id) {
    _oneRainbow = id;
  }
}

List<Rainbow> get bows => _globalRainbows;
List<Accent> get rain => _globalRainbows[_oneRainbow].accent;
// List<Accent> get rain => _dummy;

const List<Rainbow> darkSun = [
  Rainbow(name: 'Sunlight', logo: '🌞', accent: [
    Accent(
      //0
      F: Color.fromARGB(255, 76, 76, 76),
      B: Color.fromARGB(255, 87, 248, 125),
      S: Color.fromARGB(255, 62, 194, 255),
    ),
    Accent(
      //1
      F: Color.fromARGB(255, 87, 242, 216),
      B: Color.fromARGB(255, 212, 72, 72),
      S: Color.fromARGB(255, 81, 62, 255),
    ),
    Accent(
      //2
      F: Color.fromARGB(255, 174, 192, 55),
      B: Color.fromARGB(255, 121, 43, 155),
      S: Color.fromARGB(255, 255, 157, 200),
    ),
    Accent(
      //3
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //4
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //5
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color(0xFF2FB2F4),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //6
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //7
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //8
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //9
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
  ]),
  Rainbow(name: 'DarkNight', logo: '♣', accent: [
    Accent(
      //0
      F: Color.fromARGB(255, 239, 239, 239),
      B: Color.fromARGB(255, 75, 75, 75),
      S: Color.fromARGB(255, 32, 180, 99),
    ),
    Accent(
      //1
      F: Color.fromARGB(255, 231, 231, 231),
      B: Color.fromARGB(255, 39, 39, 39),
      S: Color.fromARGB(255, 81, 62, 255),
    ),
    Accent(
      //2
      F: Color.fromARGB(255, 253, 255, 242),
      B: Color.fromARGB(255, 121, 43, 155),
      S: Color.fromARGB(255, 255, 157, 200),
    ),
    Accent(
      //3
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //4
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //5
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //6
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //7
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //8
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //9
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
  ]),
];

///////////////////////////////
///////////////////////////////

void setDummy(List<Accent> newDummy) {
  // unicorn(_dummy);
  _dummy = newDummy;
  // dino(_dummy);
}

///0 : Scaffold
///1 :
///2 :
///3 :
///4 :
///5 :
///6 :
///7 : TextField
///8 : Butto
///9 : Slider
///10 : Rating
///11 : Dropdown
///12 : Chip
///13 : AltChip
///14: Radio : Checkbox : Switch
List<Accent> _dummy = [
  Accent(
    //0
    F: Colors.blue,
    B: Colors.white,
    S: Colors.white,
  ),
  Accent(
    //1
    F: Color.fromARGB(255, 231, 231, 231),
    B: Color.fromARGB(255, 39, 39, 39),
    S: Color.fromARGB(255, 81, 62, 255),
  ),
  Accent(
    //2
    F: Color.fromARGB(255, 253, 255, 242),
    B: Color.fromARGB(255, 121, 43, 155),
    S: Color.fromARGB(255, 255, 157, 200),
  ),
  Accent(
    //3
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //4
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //5
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //6
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //7
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //8
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //9
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
      //10
      F: Color.fromARGB(255, 53, 53, 53),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 221, 143, 199)),
  Accent(
    //11
    F: Color.fromARGB(255, 54, 54, 54),
    B: Color.fromARGB(255, 39, 39, 39),
    S: Color.fromARGB(255, 81, 62, 255),
  ),
  Accent(
    //12
    F: Color.fromARGB(255, 253, 255, 242),
    B: Color.fromARGB(255, 121, 43, 155),
    S: Color.fromARGB(255, 255, 157, 200),
  ),
  Accent(
    //13
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //14
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //15
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //16
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //17
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //18
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
  Accent(
    //19
    F: Color.fromARGB(255, 33, 28, 33),
    B: Color.fromARGB(255, 255, 255, 255),
    S: Color.fromARGB(255, 255, 62, 62),
  ),
];
