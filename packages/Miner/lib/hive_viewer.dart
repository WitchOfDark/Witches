import 'package:darkknight/debug_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:miner/api/api_bloc.dart';
import 'package:miner/api/api_service.dart';
import 'package:miner/db_helper.dart';
import 'package:tamannaah/services/settings/settings_bloc.dart';
import 'package:miner/settings/settings_service.dart';

class HivePage {
  final Widget tab;
  final BlocConsumer tabView;

  HivePage({
    required this.tab,
    required this.tabView,
  });
}

class Boxy extends StatefulWidget {
  const Boxy({Key? key, required this.type, required this.service}) : super(key: key);

  final String type;
  final HDbService service;

  @override
  State<Boxy> createState() => BoxyState();
}

class BoxyState extends State<Boxy> {
  @override
  Widget build(BuildContext context) {
    unicorn("SetState");

    final map = widget.type == "box" ? widget.service.pbox!.toMap() : widget.service.pmap;

    return Expanded(
      child: Column(
        children: [
          Text(widget.type),
          Expanded(
            child: ListView.builder(
              itemCount: map?.length,
              itemBuilder: (BuildContext context, int index) {
                final v = map?.entries.elementAt(index);

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (widget.type == "box") {
                              unicorn("Delete box");
                              await widget.service.pbox!.deleteAt(index);
                            }
                            if (widget.type == "map") {
                              widget.service.pmap!.removeWhere((key, value) => key == v?.key);
                            }
                            setState(() {});
                          },
                          icon: const Icon(Icons.dangerous_outlined),
                        ),
                        Text(v?.key),
                      ],
                    ),
                    v!.value.toWidget(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget hiveView(List<DropdownMenuItem<int>> buttons, HDbService service) {
  Box<DbHelp> box = service.pbox!;
  return Column(
    children: [
      DropdownButtonFormField<int>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 3, color: Colors.red),
          ),
        ),
        value: 1,
        items: buttons,
        icon: const Icon(Icons.flutter_dash),
        onChanged: (t) {},
      ),
      Expanded(
        child: Row(
          children: [
            StreamBuilder(
              stream: box.watch(),
              builder: (context, event) {
                unicorn("StreamBuilder update");
                return Expanded(
                  child: Row(
                    children: [
                      Boxy(type: "box", service: service),
                      Boxy(type: "map", service: service),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}

List<HivePage> hiveViewerInit(List<HivePage> hivePage) {
  hivePage.addAll(
    [
      HivePage(
        tab: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            HiveSettingsService service = RepositoryProvider.of<HiveSettingsService>(context);

            Box<Settings> box = service.pbox;
            return Tab(
              text: "${box.name}  ${box.length}",
              icon: const Icon(Icons.cloud_outlined),
            );
          },
        ),
        tabView: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {},
          builder: (context, state) {
            SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);

            HiveSettingsService service = RepositoryProvider.of<HiveSettingsService>(context);

            List<DropdownMenuItem<int>> buttons = [
              DropdownMenuItem(
                value: 0,
                child: const Text("Box Clear"),
                onTap: () {
                  service.pbox.clear();
                  service.pmap.clear();
                },
              ),
              DropdownMenuItem(
                value: 1,
                child: const Text("Box Delete"),
                onTap: () {
                  service.pbox.deleteFromDisk();
                },
              ),
              DropdownMenuItem(
                value: 2,
                child: const Text("Toggle theme"),
                onTap: () {
                  Settings settings = toHive((bloc.state as SSettingsLoaded).settings);
                  // bloc.add(
                  //   ESettingsUpdate(
                  //     fromHive(settings.copyWith(theme: settings.theme == 0 ? 1 : 0)),
                  //   ),
                  // );
                },
              ),
            ];

            unicorn("Bloc update");

            return hiveView(buttons, service);
          },
        ),
      ),
      HivePage(
        tab: BlocBuilder<ApiBloc, ApiState>(
          builder: (context, state) {
            ApiService service = RepositoryProvider.of<ApiService>(context);

            Box<Api> box = service.pbox;
            return Tab(
              text: "${box.name}  ${box.length}",
              icon: const Icon(Icons.add_to_queue_sharp),
            );
          },
        ),
        tabView: BlocConsumer<ApiBloc, ApiState>(
          listener: (context, state) {},
          builder: (context, state) {
            ApiBloc bloc = BlocProvider.of<ApiBloc>(context);

            ApiService service = RepositoryProvider.of<ApiService>(context);

            List<DropdownMenuItem<int>> buttons = [
              DropdownMenuItem(
                value: 0,
                child: const Text("Box Clear"),
                onTap: () {
                  service.pbox.clear();
                  service.pmap.clear();
                },
              ),
              DropdownMenuItem(
                value: 1,
                child: const Text("Box Delete"),
                onTap: () {
                  service.pbox.deleteFromDisk();
                },
              ),
              DropdownMenuItem(
                value: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Icon(Icons.add), Text("Image")],
                ),
                onTap: () {
                  bloc.add(
                    const EApiGet(
                      ext: "jpg",
                      disk: 5020,
                      "https://booknvolume.files.wordpress.com/2015/08/gargoyle.jpg",
                    ),
                  );
                },
              ),
              DropdownMenuItem(
                value: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Icon(Icons.add), Text("Json")],
                ),
                onTap: () {
                  bloc.add(
                    const EApiGet(
                      ext: "json",
                      disk: 52,
                      "https://zenquotes.io/api/random",
                    ),
                  );
                },
              ),
              DropdownMenuItem(
                value: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Icon(Icons.add), Text("Api")],
                ),
                onTap: () {
                  bloc.add(
                    const EApiGet(
                      "https://zenquotes.io/api/random",
                      mem: 1,
                      disk: 60,
                    ),
                  );
                },
              ),
            ];

            unicorn("Bloc update");

            return hiveView(buttons, service);
          },
        ),
      ),
    ],
  );

  return hivePage;
}

class HiveViewer extends StatelessWidget {
  const HiveViewer(this.panda, {Key? key}) : super(key: key);

  final List<HivePage> panda;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: panda.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Widget'),
          bottom: TabBar(
            tabs: panda.map((p) => p.tab).toList(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: panda.map((p) => p.tabView).toList(),
          ),
        ),
      ),
    );
  }
}
