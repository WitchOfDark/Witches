import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:tamannaah/darkknight/extensions/build_context.dart';
import 'package:tamannaah/darkknight/utils.dart';

// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tamannaah/forms/form_lion.dart';
import 'package:tamannaah/forms/v6_text.dart';
import 'package:tamannaah/router/router.dart';
import 'package:tamannaah/ui/d_theme.dart';
import 'package:tamannaah/ui/decoration.dart';
import 'package:tamannaah/ui/mario/mario.dart';
import 'package:tamannaah/ui/primitive.dart';
import 'package:tamannaah/ui/widgets/cards.dart';

import 'bloc/fire_auth_bloc.dart';
import 'fire_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LionFormKey formKey = lionKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FireAuthBloc, FireAuthState>(
      listener: (context, state) {
        owl('Listening Login');
        FireAuthBloc firebloc = BlocProvider.of<FireAuthBloc>(context);
        SFireAuthError? sFireError = cast<SFireAuthError>(firebloc.state);
        sFireError?.error?.showAlert(context);

        if (cast<SFireAuthLoading>(firebloc.state) != null) {
          // FireError(title: 'Loading', text: '...').showAlert(context);
          LoadingScreen().show(context: context, text: 'Loading Berry');
        } else {
          LoadingScreen().hide();
        }
      },
      builder: ((context, state) {
        FireAuthBloc firebloc = BlocProvider.of<FireAuthBloc>(context);
        // dino(state.toString());
        // FireUser? user = cast<SFireAuthIn>((firebloc.state))?.user;
        // dino(user?.toMap());
        // FireError? error = cast<SFireAuthError>((firebloc.state))?.error;
        // dino(error?.toMap());
        // unicorn(FireService.user?.toMap());

        return SafeScuffy(
          title: 'Login',
          showAppbar: false,
          mobile: Expanded(
            child: Center(
              child: box(
                deco: Deco(
                  0,
                  sdw: const [
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 25,
                      color: Colors.purple,
                    ),
                  ],
                  W: context.widthPx > 450 ? 450 : context.widthPx * 0.9,
                  brR: brR_a_10,
                  pad: e8, /*sdw: sdw1*/
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //

                      const FlutterLogo(size: 150),
                      tx(megaAppName, deco: dH1),

                      //
                      const SizedBox(height: 10),

                      //
                      LionForm(
                        formKey: formKey,
                        child: Column(
                          children: [
                            V6Text(
                              name: 'username',
                              hint: '_User Name',
                              prefix: const Icon(Icons.account_circle),
                              validator: (value) {
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),
                            V6Text(
                              name: 'password',
                              hint: '_Password',
                              prefix: const Icon(Icons.spa),
                              obscure: '',
                              validator: (value) {
                                if (value.toString().length < 6) {
                                  return 'Password too short';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 10),

                            if (FireService.moons.contains(FireMoon.phone)) const Divider(),

                            //
                            ...authButtons(context, formKey, firebloc),

                            // txbtn(
                            //   'Forgot Password',
                            //   fn: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) {
                            //           return ForgotPasswordScreen();
                            //         },
                            //       ),
                            //     );
                            //   },
                            // ),

                            // txbtn(
                            //   'EmailVerificationScreen',
                            //   fn: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) {
                            //           return EmailVerificationScreen();
                            //         },
                            //       ),
                            //     );
                            //   },
                            // ),

                            // txbtn(
                            //   'Email Signin',
                            //   fn: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) {
                            //           return UniversalEmailSignInScreen();
                            //         },
                            //       ),
                            //     );
                            //   },
                            // ),

                            // txbtn(
                            //   'Phone Number',
                            //   fn: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) {
                            //           return Scaffold(
                            //             backgroundColor: Colors.white,
                            //             body: SingleChildScrollView(
                            //               child: Column(
                            //                 mainAxisAlignment: MainAxisAlignment.center,
                            //                 children: const [
                            //                   SizedBox(
                            //                     height: 400,
                            //                     width: 400,
                            //                     child: PhoneInputScreen(),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           );
                            //         },
                            //       ),
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),

                      //
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

List<Widget> authButtons(BuildContext context, LionFormKey formKey, FireAuthBloc firebloc) {
  return FireService.providers.entries.map(
    (e) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          txbtn(
            '${e.key.name} Login',
            deco: dBtn8,
            fn: () async {
              // if (formKey.currentState?.saveAndValidate() ?? false) {
              final f = formKey.currentState?.value;

              unicorn(f);

              firebloc.add(
                EFireAuthLogIn(
                  method: e.key,
                  email: f!['username'],
                  password: f['password'],
                ),
              );
              // formKey.currentState?.validate();

              // //Reset
              // formKey.currentState?.reset();

              // FocusScope.of(context).unfocus();
            },
            // },
          ),
          const SizedBox(width: 10),
          if (e.key == FireMoon.custom || e.key == FireMoon.email)
            txbtn(
              '${e.key.name} Sign Up',
              deco: dBtn8,
              fn: () {
                // if (formKey.currentState?.saveAndValidate() ?? false) {
                final f = formKey.currentState?.value;

                unicorn(f);

                firebloc.add(
                  EFireAuthSignIn(
                    method: e.key,
                    email: f!['username'],
                    password: f['password'],
                  ),
                );
                // }
              },
            ),
        ],
      );
    },
  ).toList();
}

void logout(BuildContext context) async {
  LoadingScreen().show(context: context, text: 'Loading Berry');

  await FireService.logOut();
  LoadingScreen().hide();
  // firebloc.add(
  //   EFireAuthLogOut(
  //     method: e.key,
  //   ),
  // );
}

Widget logoutBtn(BuildContext context, {bool onlyIcon = false}) {
  if (onlyIcon) {
    return IconButton(
      icon: const Icon(Icons.logout_rounded),
      onPressed: () {
        logout(context);
      },
    );
  }
  return btn(
    deco: dBtn8,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(Icons.logout_rounded),
        tx(' Log out', deco: dBtn8),
      ],
    ),
    fn: () {
      logout(context);
    },
  );
}
