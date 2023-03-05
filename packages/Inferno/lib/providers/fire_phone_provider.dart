// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import '../../lib/services/fire_auth/fire_error.dart';

// import '../../../tools/debug_functions.dart';
// import '../fire_service.dart';
// import 'fire_provider.dart';

// class FirePhoneProvider extends FireProvider {
//   @override
//   Future<FireError?> delete() {
//     throw UnimplementedError();
//   }

//   @override
//   Future<FireError?> logIn({required String email, required String password}) async {
//     final auth = FirebaseAuth.instance;

//     dino('Entered $email');

//     return fire(
//       () async {
//         await auth.verifyPhoneNumber(
//           timeout: const Duration(seconds: 60),
//           phoneNumber: '+44 7444 555666',
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             final userCredential = await auth.signInWithCredential(credential);

//             lava(userCredential.credential.toString());
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             if (e.code == 'invalid-phone-number') {
//               dino('The provided phone number is not valid.');
//             }
//           },
//           codeSent: (String verificationId, int? resendToken) async {
//             // Update the UI - wait for the user to enter the SMS code
//             String smsCode = '123456';

//             Builder(
//               builder: (context) {
//                 return FutureBuilder(
//                   future: showDialog(
//                     context: context,
//                     builder: (context) {
//                       return Pinput(
//                         defaultPinTheme: defaultPinTheme,
//                         focusedPinTheme: focusedPinTheme,
//                         submittedPinTheme: submittedPinTheme,
//                         validator: (s) {
//                           return s == '2222' ? null : 'Pin is incorrect';
//                         },
//                         pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                         showCursor: true,
//                         onCompleted: (pin) => print(pin),
//                       );
//                     },
//                   ),
//                   builder: (context, snapshot) {
//                     unicorn('Sms Code  :  ' + snapshot.data.toString());
//                     return Text(snapshot.data.toString());
//                   },
//                 );
//               },
//             );

//             // Create a PhoneAuthCredential with the code
//             PhoneAuthCredential credential =
//                 PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

//             // Sign the user in (or link) with the credential
//             final userCredential = await auth.signInWithCredential(credential);
//             unicorn(userCredential.credential.toString());
//           },
//           codeAutoRetrievalTimeout: (String verificationId) {},
//         );

//         return auth.currentUser != null ? null : fireAuthErrorMap['unknown-auth'];
//       },
//     );
//   }

//   @override
//   Future<FireError?> reset({required String email}) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<FireError?> signIn({required String email, required String password}) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<FireError?> verify() {
//     throw UnimplementedError();
//   }

//   @override
//   Future<FireError?> logOut() {
//     return fire(
//       () async {
//         return await FireService.logOut();
//       },
//     );
//   }
// }

// final defaultPinTheme = PinTheme(
//   width: 56,
//   height: 56,
//   textStyle:
//       TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
//   decoration: BoxDecoration(
//     border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
//     borderRadius: BorderRadius.circular(20),
//   ),
// );

// final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
//   borderRadius: BorderRadius.circular(8),
// );

// final submittedPinTheme = defaultPinTheme.copyWith(
//   decoration: defaultPinTheme.decoration?.copyWith(
//     color: Color.fromRGBO(234, 239, 243, 1),
//   ),
// );

// Widget firePhoneInput(LionFormKey formKey, FireAuthBloc firebloc) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         FormBuilderPhoneField(
//           name: 'phone_number',
//           decoration: const InputDecoration(
//             labelText: 'Phone Number',
//             hintText: 'Hint',
//           ),
//           // onChanged: _onChanged,
//           priorityListByIsoCode: const ['In'],
//           validator: (value) {
//             dino(value);

//             if (value == '' ||
//                 value == null ||
//                 !isNumeric(value.replaceAll('+', '').replaceAll('-', ''))) {
//               return 'Wrong';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 15),
//         Wrap(
//           spacing: 16,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 dino(formKey.currentState!.value.toString());
//                 if (formKey.currentState!.saveAndValidate()) {
//                   dino(formKey.currentState!.value.toString());
//                 }

//                 final f = formKey.currentState?.value;

//                 firebloc.add(
//                   EFireAuthLogIn(
//                     method: FireMoon.phone,
//                     email: f!['phone_number'],
//                   ),
//                 );
//               },
//               child: const Text("Submit"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 lava(formKey.currentState!.instantValue.toString());
//                 formKey.currentState?.reset();
//                 lava(formKey.currentState!.instantValue.toString());
//               },
//               child: const Text("Reset"),
//             )
//           ],
//         ),
//       ],
//     ),
//   );
// }
