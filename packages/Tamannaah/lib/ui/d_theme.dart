import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'decoration.dart';

///0 : Scaffold
///1 : H1
///2 : H2
///3 : H3
///4 :
///5 :
///6 : TextField
///7 : IconButton
///8 : Button
///9 : Slider
///10 : Rating
///11 : Dropdown
///12 : Chip
///13 : AltChip
///14: Radio : Checkbox : Switch
///

final
    //Debug
    dDebug = Deco(0, bW: 1, B: Colors.transparent),
    dScaf0 = Deco(0, elv: 0, H: 40, fs: 17),
    dT = Deco(0, B: Colors.transparent, F: Colors.black, S: Colors.amber),

    //Scaffold

    //Text
    dH1 = Deco(1, fs: 50, F: Colors.black, fgf: GoogleFonts.poppins()),
    dH2 = Deco(2, fs: 20, F: Colors.black),
    dH3 = Deco(3, fs: 15),

    //Textfield
    dTxf6 = Deco(
      6,
      mar: e4,
      pad: e6,
      fs: 15,
      brR: brR_a_4,
      fml: 1,
      fto: TextOverflow.ellipsis,
      bW: 1,
      B: const Color.fromARGB(255, 244, 244, 244),
      S: const Color.fromARGB(255, 83, 83, 83),
      F: Colors.blue,
    ),

    //Button
    dIc7 = Deco(
      7,
      brR: brR_no,
      fs: 15,
      pad: e6,
      mar: e6,
    ),
    dBoolButton7 = Deco(
      7,
      B: Colors.yellow,
      S: Colors.red,
      F: Colors.blue,
    ),
    dBtn8 = Deco(
      8,
      brR: brR_a_4,
      fs: 13,
      pad: e4,
      mar: e4,
      fml: 1,
      W: 120,
      S: const Color.fromARGB(255, 10, 48, 216),
      B: const Color.fromARGB(255, 56, 56, 56),
      F: const Color.fromARGB(255, 220, 220, 220),
      elv: 4,
    ),
    dPopup8 = Deco(
      8,
      elv: 4,
      fs: 15,
    ),
    dSlider9 = Deco(9),
    dRating10 = Deco(10),
    dDropDown11 = Deco(11, brR: brR_a_10, fs: 16),
    dChip12 = Deco(12, fs: 16, brR: brR_a_16),
    dSwitchRadioCheck14 = Deco(14, fs: 16),

    //Special
    dIos = Deco(
      4,
      F: const Color.fromARGB(255, 66, 66, 66),
      B: Colors.white,
      S: Colors.blue,
      pad: e8,
      // mar: e8,
      elv: 5,
      brR: brR_a_6,
      fs: 15,
      // inv: 3,
    ),
    dError = Deco(
      0,
      pad: e8,
      mar: e8,
      elv: 5,
      brR: brR_a_6,
      fs: 15,
      F: const Color.fromARGB(255, 211, 47, 47),
      B: const Color.fromARGB(255, 253, 237, 237),
      S: const Color.fromARGB(255, 254, 58, 58),
      inv: 1,
    ),
    dWarning = Deco(
      0,
      pad: e8,
      mar: e8,
      elv: 5,
      brR: brR_a_6,
      fs: 15,
      F: const Color.fromARGB(255, 102, 60, 0),
      B: const Color.fromARGB(255, 253, 244, 229),
      S: const Color.fromARGB(255, 255, 161, 23),
    ),
    dInfo = Deco(
      0,
      pad: e8,
      mar: e8,
      elv: 5,
      brR: brR_a_6,
      fs: 15,
      F: const Color.fromARGB(255, 50, 106, 131),
      B: const Color.fromARGB(255, 229, 246, 253),
      S: const Color.fromARGB(255, 26, 177, 245),
    ),
    dSuccess = Deco(
      0,
      pad: e8,
      mar: e8,
      elv: 5,
      brR: brR_a_6,
      fs: 15,
      F: const Color.fromARGB(255, 34, 73, 36),
      B: const Color.fromARGB(255, 237, 247, 237),
      S: const Color.fromARGB(255, 92, 182, 96),
    );
