import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../services/fire_auth/bloc/fire_auth_bloc.dart';
import '../../services/fire_auth/fire_service.dart';
import '../../tools/debug_functions.dart';
import '../../ui/d_theme.dart';
import '../../ui/mario/mario.dart';
import '../../ui/widgets/cards.dart';

import '../../services/settings/settings_bloc.dart';
import '../../services/settings/settings_service.dart';
import '../../tools/utils.dart';

import '../../ui/decoration.dart';
import '../../ui/primitive.dart';
import '../../ui/rainbow.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
/*
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

*/

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);
        Settings? settings = cast<SSettingsLoaded>((bloc.state))?.settings;

        return SafeScuffy(
          title: 'Settings',
          mobile: (settings == null)
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: bows.map((e) => e.toWidget()).toList()),

                    Text(settings.toMap().toString()),

                    box(
                      deco: Deco(0, H: 150),
                      child: ListView.builder(
                        itemCount: bows.length,
                        itemBuilder: (_, id) {
                          return Center(
                            child: txbtn(
                              bows[id].name,
                              fn: () {
                                bloc.add(
                                  ESettingsUpdate(
                                    settings.copyWith(theme: id),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

/*
                        UserAvatar(),

                        txbtn('Logout', fn: (() {
                          firebloc.add(
                            EFireAuthLogOut(),
                          );
                        })),
                        if (FireService.user?.user != null)
                          txbtn('Profile', fn: (() {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) {
                              return ProfileScreen(
                                appBar: AppBar(title: Text('Profile')),
                              );
                            })));
                          })),
                        SignOutButton(),

                        DeleteAccountButton(),

                        txbtn('Update', fn: (() async {
                          await FirebaseAuth.instance.currentUser?.updateDisplayName(randomString(8));
                          await FirebaseAuth.instance.currentUser?.updatePhotoURL(

                              //url needed
                              'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7');

                          //Requires Recent Login
                          await FirebaseAuth.instance.currentUser?.updatePassword('KingAslan');

                          // await FirebaseAuth.instance.currentUser?.delete();
                        })),
*/
                  ],
                ),
        );
      },
      // );
      // }),
    );
  }
}
