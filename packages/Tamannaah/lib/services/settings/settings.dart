import 'package:darkknight/debug_functions.dart';
import 'package:darkknight/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamannaah/forms/v3_basic.dart';
import 'package:tamannaah/services/settings/settings_bloc.dart';
import 'package:tamannaah/ui/d_theme.dart';
import 'package:tamannaah/ui/primitive.dart';
import 'package:tamannaah/ui/rainbow.dart';
import 'package:tamannaah/ui/widgets/cards.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
        SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
        // TamannaahNotifier? notifier = TamannaahInheritedNotifier.of(context);
        // TSettings? settings = notifier?.data;
        TSettings? settings = cast<SSettingsLoaded>(settingsBloc.state)?.settings;
        // dino(settings?.toMap().toString() ?? '');

        return SafeScuffy(
          title: 'Settings',
          mobile: settings == null
              ? const CircularProgressIndicator()
              : Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          tx(beautifyMap(settings.toMap()).toString()),
                          if ((settings.supportedLocales.isNotEmpty))
                            v3DropDown(
                              name: 'Locale',
                              deco: dDropDown11.cp(W: 150, bevel: true, bW: 10),
                              headText: 'Locale',
                              initialValue: settings.locale,
                              values: settings.supportedLocales,
                              builder: (obj, d) => tx(obj, deco: d),
                              onChanged: (loc) {
                                settingsBloc.add(
                                  ESettingsUpdate(
                                    settings: settings.copyWith(locale: loc),
                                    // notifier: notifier,
                                  ),
                                );
                              },
                            ),
                          v3DropDown(
                            name: 'Theme',
                            headText: 'Theme',
                            deco: dDropDown11.cp(W: 150, bW: 1),
                            values: bows,
                            initialValue: bows[Grain.oneRainbow],
                            builder: (obj, d) => tx('${obj.logo}   ${obj.name}', deco: d),
                            onChanged: (loc) {
                              if (loc != null) {
                                settingsBloc.add(
                                  ESettingsUpdate(
                                    settings: settings.copyWith(theme: bows.indexOf(loc)),
                                    // notifier: notifier,
                                  ),
                                );
                              }
                            },
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
                    ),
                  ),
                ),
        );
      },
    );
  }
}
