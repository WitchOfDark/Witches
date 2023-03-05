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
  final bool dark;

  final List<Accent> accent;

  const Rainbow({
    required this.name,
    required this.logo,
    required this.accent,
    required this.dark,
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
      dark: r.dark,
      accent: [
        ...r.accent,
        ...accent.sublist(r.accent.length),
      ],
    );
  }

  @override
  String toString() => 'Rainbow(name: $name, logo: $logo, dark: $dark, accent : ${accent.length})';
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

  static int get oneRainbow => _oneRainbow;

  static set oneRainbow(int id) {
    _oneRainbow = id;
  }
}

List<Rainbow> get bows => _globalRainbows;
List<Accent> get rain => _globalRainbows[_oneRainbow].accent;

// List<Accent> get rain => _dummy;

const List<Rainbow> darkSun = [
  Rainbow(name: 'Sunlight', logo: '🌞', dark: false, accent: [
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
      F: Colors.blue,
      B: Color.fromARGB(255, 244, 244, 244),
      S: Color.fromARGB(255, 83, 83, 83),
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
      S: Color.fromARGB(255, 221, 143, 199),
    ),
    Accent(
      //11
      F: Color.fromARGB(255, 54, 54, 54),
      B: Color.fromARGB(255, 238, 238, 238),
      S: Color.fromARGB(255, 70, 16, 71),
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
  ]),
  Rainbow(name: 'DarkNight', logo: '♣', dark: true, accent: [
    Accent(
      //0
      F: Color.fromARGB(255, 239, 239, 239),
      B: Color.fromARGB(255, 39, 39, 39),
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
      F: Color.fromARGB(255, 235, 235, 235),
      B: Color.fromARGB(255, 63, 63, 63),
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
      S: Color.fromARGB(255, 244, 244, 244),
      B: Color.fromARGB(255, 83, 83, 83),
      F: Colors.blue,
    ),
    Accent(
      //7
      F: Color.fromARGB(255, 33, 28, 33),
      B: Color.fromARGB(255, 255, 255, 255),
      S: Color.fromARGB(255, 255, 62, 62),
    ),
    Accent(
      //8
      F: Colors.blue,
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
      B: Color.fromARGB(255, 94, 10, 10),
      S: Color.fromARGB(255, 221, 143, 199),
    ),
    Accent(
      //11
      F: Color.fromARGB(255, 235, 235, 235),
      B: Color.fromARGB(255, 45, 10, 51),
      S: Color.fromARGB(255, 21, 3, 24),
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
List<Accent> _dummy = const [
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
