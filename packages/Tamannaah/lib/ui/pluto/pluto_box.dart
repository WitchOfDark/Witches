import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:tamannaah/darkknight/utils.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';

class GridController<T> {
  String search;
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;
  PlutoGridStateManager? stateManager;
  List<T> data;

  GridController({
    this.stateManager,
    required this.columns,
    required this.rows,
    this.search = '',
    this.data = const [],
  });
}

Widget plutoBox(BuildContext context, GridController con,
    {bool showLoading = false,
    PlutoOnSelectedEventCallback? onSelected,
    Map<ShortcutActivator, PlutoKeyAction>? shortcuts}) {
  return PlutoGrid(
    columns: con.columns,
    rows: con.rows,
    mode: PlutoGridMode.select,
    onSelected: onSelected,
    onChanged: (PlutoGridOnChangedEvent event) {
      owl(event);
    },
    onLoaded: (PlutoGridOnLoadedEvent event) {
      con.stateManager = event.stateManager;
      con.stateManager?.setShowLoading(showLoading);
    },
    configuration: PlutoGridConfiguration(
      scrollbar: PlutoGridScrollbarConfig(
        isAlwaysShown: true,
      ),
      style: PlutoGridStyleConfig(
        oddRowColor: Color.fromARGB(255, 236, 236, 236),
        evenRowColor: Color.fromARGB(255, 246, 246, 246),
      ),
      shortcut: PlutoGridShortcut(
        actions: {
          ...PlutoGridShortcut.defaultActions,
          ...?shortcuts,
        },
      ),
    ),
  );
}

PlutoRow toPlutoCell(Map<String, dynamic> m, List<PlutoColumn> columns) {
  Map<String, PlutoCell> rowcells = {};
  for (var e in columns) {
    rowcells[e.field] = PlutoCell(value: m[e.field].toString());
  }
  return PlutoRow(cells: rowcells);
}

List<PlutoRow> toPlutoRows(List<PlutoColumn> columns, List<Map<String, dynamic>> data) {
  List<PlutoRow> rows = [];
  for (var v in data) {
    rows.add(
      toPlutoCell(v, columns),
    );
  }
  return rows;
}

List<PlutoColumn> toPlutoColumn(Map<String, dynamic> m) {
  return m.entries
      .map((e) => PlutoColumn(
            title: stringSting(e.key),
            field: e.key,
            type: PlutoColumnType.text(),
          ))
      .toList();
}

Future<void> plutoUpdate<T>(GridController<T> con, List<T>? data) async {
  con.data = data ?? [];

  con.rows.clear();
  con.rows.addAll(toPlutoRows(con.columns, clm(con.data)));

  await PlutoGridStateManager.initializeRowsAsync(
    con.columns,
    con.rows,
  ).then((plutorows) {
    con.stateManager?.refRows.clear();
    con.stateManager?.refRows.addAll(plutorows);

    con.stateManager?.setShowLoading(false);
  });
}

class PlutoKeyAction extends PlutoGridShortcutAction {
  final void Function(
    PlutoKeyManagerEvent keyEvent,
    PlutoGridStateManager stateManager,
  ) fn;

  PlutoKeyAction(this.fn);

  @override
  void execute({
    required PlutoKeyManagerEvent keyEvent,
    required PlutoGridStateManager stateManager,
  }) {
    print('Pressed enter key. $keyEvent');
    fn(keyEvent, stateManager);
  }
}
