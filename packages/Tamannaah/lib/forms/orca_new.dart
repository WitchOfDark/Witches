// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:reorderables/reorderables.dart';

// import '../tools/utils.dart';
// import '../ui/d_theme.dart';
// import '../ui/lego.dart';
// import '../ui/primitive.dart';
// import '../ui/simple/popup_btns.dart';
// import 'form_lion.dart';
// import 'orca_field.dart';

// Future<Map<String, dynamic>?> showLionDialog(
//   BuildContext context,
//   // List<OrcaField> orcas,
//   OrcaBuilder orcaBuilder, {
//   Map<String, dynamic>? initValue,
// }) async {
//   final formkey = lionKey();

//   return await showDialog<Map<String, dynamic>?>(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         child: LionForm(
//           key: Key(randomString(5)),
//           formKey: formkey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 width: 300,
//                 height: 300,
//                 child:
//                     //  d0.orcaBox(orcas, initialValue: initValue);
//                     orcaBuilder(formkey, initValue),
//                 //  builder(formkey, null),
//               ),
//               Lego(
//                 deco: dBtn8,
//                 name: 'Submit',
//                 fn: () {
//                   Navigator.pop(context, formkey.value());
//                 },
//               ).txBtn(),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// List<T> emptyTFunction<T>(List<String> s) {
//   return [];
// }

// class OrcaGrow<T> extends OrcaField {
//   final List<Map<String, dynamic>> initialValue;
//   final OrcaBuilder orcaBuilder;

//   OrcaGrow({
//     required super.deco,
//     required super.name,
//     required super.hint,
//     super.enabled,
//     required this.orcaBuilder,
//     this.initialValue = const [],
//   });

//   @override
//   Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
//     return FormBuilderField<List<Map<String, dynamic>>>(
//       name: name,
//       initialValue: cast<List<Map<String, dynamic>>>(initValue) ?? initialValue,
//       builder: (field) {
//         return StatefulBuilder(builder: (context, setState) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ReorderableWrap(
//                 spacing: 8.0,
//                 runSpacing: 4.0,
//                 onReorder: ((oldIndex, newIndex) {
//                   setState(() {
//                     final n = field.value ?? [];
//                     final o = n.removeAt(oldIndex);
//                     n.insert(newIndex, o);
//                     field.didChange(n);
//                   });
//                 }),
//                 onNoReorder: (int index) {
//                   // debugPrint(
//                   //     '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
//                 },
//                 onReorderStarted: (int index) {
//                   // debugPrint(
//                   //     '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
//                 },
//                 children: (field.value ?? []).asMap().entries.map((e) {
//                   final index = e.key;
//                   LionFormKey indexFormKey = lionKey();
//                   return box(
//                     deco: dT.cp(bW: 1),
//                     // width: .4.sw,
//                     child: Stack(
//                       children: [
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: popupMenu(
//                             [
//                               Lego(
//                                 name: 'Delete',
//                                 deco: dPopup8,
//                                 icon: Icons.delete,
//                                 fn: () {
//                                   final n = field.value ?? [];
//                                   n.removeAt(index);
//                                   field.didChange(n);
//                                 },
//                               ),
//                               Lego(
//                                 name: 'Update',
//                                 deco: dPopup8,
//                                 icon: Icons.color_lens,
//                                 fn: () async {
//                                   List<Map<String, dynamic>> n = field.value ?? [];

//                                   final hello = await showLionDialog(
//                                       context,
//                                       // orcas,
//                                       initValue: n[index],
//                                       orcaBuilder);

//                                   if (hello != null) n[index] = hello;
//                                   field.didChange(n);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             mapToWidget((field.value ?? [])[index]),
//                             LionForm(
//                               key: Key(randomString(5)),
//                               formKey: indexFormKey,
//                               update: ((fKey) {
//                                 final n = field.value ?? [];
//                                 n[index] = fKey.value();
//                                 field.didChange(n);
//                               }),
//                               // child: d0.orcaBox(orcas, initialValue: (field.value ?? [])[index]),
//                               child: orcaBuilder(indexFormKey, (field.value ?? [])[index]),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   txbtn('Dialog', fn: () async {
//                     final hello = await showLionDialog(
//                         context,
//                         // orcas,
//                         orcaBuilder);

//                     List<Map<String, dynamic>> n = (field.value ?? []);
//                     if (hello != null) field.didChange([...n, hello]);
//                   }),
//                   txbtn('Add', fn: () async {
//                     List<Map<String, dynamic>> n = (field.value ?? []);
//                     field.didChange([...n, {}]);
//                   }),
//                 ],
//               ),
//             ],
//           );
//         });
//       },
//     );
//   }
// }
