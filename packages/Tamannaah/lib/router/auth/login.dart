import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamannaah/forms/v4_text.dart';
import '../../router/router.dart';
import '../../forms/form_lion.dart';
import '../../services/fire_auth/bloc/fire_auth_bloc.dart';
import '../../services/fire_auth/fire_service.dart';
import '../../tools/debug_functions.dart';
import '../../tools/extensions/build_context.dart';
import '../../tools/utils.dart';
import '../../ui/d_theme.dart';
import '../../ui/decoration.dart';
import '../../ui/mario/mario.dart';
import '../../ui/primitive.dart';
import '../../ui/widgets/cards.dart';

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
          mobile: box(
            deco: Deco(
              1,
              W: context.widthPx > 450 ? 450 : context.widthPx * 0.9,
              brR: brR_a_10,
              B: Colors.white,
              pad: e8, /*sdw: sdw1*/
            ),
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
                      V4Text(
                        name: 'username',
                        hint: '_User Name',
                        prefix: const Icon(Icons.account_circle),
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      V4Text(
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

                      txbtn(
                        'Forgot Password',
                        fn: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordScreen();
                              },
                            ),
                          );
                        },
                      ),

                      txbtn(
                        'EmailVerificationScreen',
                        fn: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EmailVerificationScreen();
                              },
                            ),
                          );
                        },
                      ),

                      txbtn(
                        'Email Signin',
                        fn: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UniversalEmailSignInScreen();
                              },
                            ),
                          );
                        },
                      ),

                      txbtn(
                        'Phone Number',
                        fn: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  backgroundColor: Colors.white,
                                  body: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          height: 400,
                                          width: 400,
                                          child: PhoneInputScreen(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                //
                const SizedBox(height: 10),
              ],
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
      return Column(
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
          txbtn(
            '🚧 ${e.key.name} Sign in',
            deco: dBtn8,
            fn: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                final f = formKey.currentState?.value;
                print(f.toString());
                firebloc.add(
                  EFireAuthSignIn(
                    method: e.key,
                    email: f!['username'],
                    password: f['password'],
                  ),
                );
              }
            },
          ),
          const SizedBox(width: 10),
          if (!(e.key == FireMoon.custom))
            btn(
              deco: dBtn8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  tx('${e.key.name} Log out  ', deco: dBtn8),
                  tx('🍄'),
                ],
              ),
              fn: () {
                firebloc.add(
                  EFireAuthLogOut(
                    method: e.key,
                  ),
                );
              },
            ),
        ],
      );
    },
  ).toList();
}
