import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import '../tools/debug_functions.dart';

// Widget maskForm(String mask) {
//   return FormBuilderTextField(
//     name: 'Mask',
//     valueTransformer: (value) {
//       dino(maskToReal(value ?? '', mask));
//       return maskToReal(value ?? '', mask);
//     },
//     inputFormatters: [
//       maskInputFormatter(mask),
//     ],
//   );
// }

TextInputFormatter maskInputFormatter(String mask) {
  return TextInputFormatter.withFunction((maskedOld, maskedNew) {
    String mold = maskedOld.text;

    String real = maskToReal(mold, mask);

    // unicorn(mask);
    // dino(mold);
    // lava(real);

    //xxxx xxxx xxxx
    //4515 45155
    //4515 4515 5
    final mChars = maskedNew.text.characters;
    String mnew = realToMask(real + (mChars.isEmpty ? '' : mChars.last), mask);

    // dino(mnew);

    if ((maskedNew.text.length > mold.length) && (maskedNew.text.length <= mask.length)) {
      if (!maskedValid(mnew, mask)) {
        return maskedOld;
      }

      real += mnew.characters.last;
    } else {
      if (real.length > 1) {
        if (maskedNew.text.length != mask.length + 1) {
          real = real.substring(0, real.length - 1);
        }
      } else {
        real = '';
      }
    }

    // lava(real);
    String cN = realToMask(real, mask);
    // dino(cN);

    return TextEditingValue(
      text: cN,
      selection: TextSelection.collapsed(
        offset: cN.length,
      ),
    );
  });
}

///     00xx 00** *0xx      Mask
///     4512a   -> 4512 a
/// no special character = real
/// special character = masked
String realToMask(String real, String mask) {
  String masked = '';
  for (int i = 0, j = 0; i < mask.length && j < real.length; i++) {
    String m = mask[i];

    // dino('-------------$m $i $j $real $masked $mask');

    if (m == 'x' || m == '*' || m == '0') {
      masked += real[j];
      j++;
    } else {
      masked += m;
    }
    // owl('-------------$masked  $i');
  }
  // unicorn('-------------$real  $masked');
  return masked;
}

String demo() {
  // taco('');
  realToMask("1", "0*x0 *00x xx*0");
  realToMask("12", "0*x0 *00x xx*0");
  realToMask("123", "0*x0 *00x xx*0");
  realToMask("1234", "0*x0 *00x xx*0");
  realToMask("12345", "0*x0 *00x xx*0");
  realToMask("123456", "0*x0 *00x xx*0");
  realToMask("1234567", "0*x0 *00x xx*0");
  realToMask("12345678", "0*x0 *00x xx*0");
  realToMask("123456789", "0*x0 *00x xx*0");
  realToMask("123456789a", "0*x0 *00x xx*0");
  realToMask("123456789ab", "0*x0 *00x xx*0");
  realToMask("123456789abc", "0*x0 *00x xx*0");
  realToMask("123456789abcd", "0*x0 *00x xx*0");

  maskToReal("1", "0*x0 *00x xx*0");
  maskToReal("12", "0*x0 *00x xx*0");
  maskToReal("123", "0*x0 *00x xx*0");
  maskToReal("1234", "0*x0 *00x xx*0");
  maskToReal("1234 5", "0*x0 *00x xx*0");
  maskToReal("1234 56", "0*x0 *00x xx*0");
  maskToReal("1234 567", "0*x0 *00x xx*0");
  maskToReal("1234 5678", "0*x0 *00x xx*0");
  maskToReal("1234 5678 9", "0*x0 *00x xx*0");
  maskToReal("1234 5678 9a", "0*x0 *00x xx*0");
  maskToReal("1234 5678 9ab", "0*x0 *00x xx*0");
  maskToReal("1234 5678 9abc", "0*x0 *00x xx*0");
  maskToReal("1234 5678 9abcd", "0*x0 *00x xx*0");

  return 'hello';
}

///     4512 a  -> 4512a
String maskToReal(String masked, String mask) {
  String real = '';

  for (int i = 0; i < masked.length && i < mask.length; i++) {
    String m = mask[i];

    if (m == 'x' || m == '*' || m == '0') {
      real += masked[i];
    }
  }

  // dino('$masked  $real');

  return real;
}

//4512 a
//0000 x
bool maskedValid(String masked, String mask) {
  for (int i = 0; i < masked.length && i < mask.length; i++) {
    // unicorn("${mask[i]}  ${masked[i]}");
    if (mask[i] == '0') {
      if (!RegExp(r'[0-9]').hasMatch(masked[i])) {
        return false;
      }
    }
    if (mask[i] == 'x') {
      if (!RegExp(r'[a-zA-Z]').hasMatch(masked[i])) {
        return false;
      }
    }
    if (mask[i] == '*') {
      if (!RegExp(r'.').hasMatch(masked[i])) {
        return false;
      }
    }
  }
  // lava(true);

  return true;
}
