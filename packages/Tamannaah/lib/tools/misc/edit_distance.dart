import 'dart:math';

int editDistance(String s1, String s2) {
  if (s1 == s2) {
    return 0;
  }

  if (s1.isEmpty) {
    return s2.length;
  }

  if (s2.isEmpty) {
    return s1.length;
  }

  List<int> v0 = List<int>.generate(s2.length + 1, (i) => i, growable: false);
  List<int> v1 = List<int>.filled(s2.length + 1, 0, growable: false);
  List<int> vtemp;

  for (var i = 0; i < s1.length; i++) {
    v1[0] = i + 1;

    for (var j = 0; j < s2.length; j++) {
      int cost = 1;
      if (s1.codeUnitAt(i) == s2.codeUnitAt(j)) {
        cost = 0;
      }
      v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
    }

    vtemp = v0;
    v0 = v1;
    v1 = vtemp;
  }

  return v0[s2.length];
}

double normEditDistance(String s1, String s2) {
  int maxLength = max(s1.length, s2.length);
  if (maxLength == 0) {
    return 0.0;
  }
  return editDistance(s1, s2) / maxLength;
}
