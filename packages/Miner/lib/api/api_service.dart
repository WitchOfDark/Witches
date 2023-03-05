// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

// import 'package:dio/dio.dart';
import 'package:darkknight/debug_functions.dart';
import 'package:darkknight/extensions/build_context.dart';
import 'package:darkknight/utils.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../db_helper.dart';
import '../hive_constants.dart';

part 'api_service.g.dart';

@HiveType(typeId: apiBoxNum)
class Api extends HiveObject implements DbHelp {
  @HiveField(0)
  final String url;
  @HiveField(1)
  final String data;
  @HiveField(2)
  final int expire; // store till

  Api({
    required this.url,
    required this.data,
    this.expire = -1,
  });

  Api copyWith({
    String? url,
    String? data,
    int? expire,
  }) {
    return Api(
      url: url ?? this.url,
      data: data ?? this.data,
      expire: expire ?? this.expire,
    );
  }

  bool get isExpired {
    return expire < DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget toWidget() {
    unicorn("${url.substring(0, 21)}  $expire");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(url),
        Text(data),
        Text("Type : ${data.split(".").last}"),
        Text("Expire : ${DateTime.fromMillisecondsSinceEpoch(expire)}"),
        // EpochTimer(expire: expire, sec: 1),
      ],
    );
  }

  @override
  Map<String, Map> toMap() {
    return {
      "Api": {
        'url': url,
        'data': data,
        'expire': expire,
      }
    };
  }
}

class ApiService implements HDbService {
  @override
  bool initialized = false;

  late Box<Api> _apiBox;

  @override
  Box<Api> get pbox {
    return _apiBox;
  }

  final HashMap<String, Api> _apiMap = HashMap<String, Api>();

  @override
  HashMap<String, Api> get pmap {
    return _apiMap;
  }

  late Directory _tempDir;

  // late Dio _dioByte;

  @override
  Future<void> init([dynamic obj]) async {
    if (!initialized) {
      Hive.registerAdapter(ApiAdapter());
      _apiBox = await Hive.openBox<Api>(apiBoxName);

      if (!Device.isWeb) _tempDir = await getTemporaryDirectory();
      // _tempDir = await getApplicationSupportDirectory();

      // _dioByte = Dio(BaseOptions(responseType: ResponseType.bytes));
    }

    initialized = true;
    dino("ApiService initialized");
  }

  //1 : Memory : If available in memory and not expired, if expired call network, if network fails return memory
  //2 : Disk : If available in disk, Only used when network call fail
  //3 : Network
  //
  //Find in memory
  //  If in memory
  //    If expired : fetchNcache; If success return fetchNCache
  //    return inMem
  //Not Found in memory
  //Find in disk
  //  Even if in disk : fetchNcache; If success return fetchNCache
  //  return inDisk
  //Not Found in disk
  //return fetchNcache
  Future<Api?> get(
    String url, {
    String ext = "",
    int mem = -1, //cache for min
    int disk = -1, //cache for min
  }) async {
    final key = "${url.toLowerCase()}🔥$ext";

    final m = _apiMap[key];
    if (m != null) {
      if (m.isExpired) {
        Api? n = await fetchNcache(url, ext: ext, mem: mem, disk: disk);
        if (n != null) {
          unicorn("$ext Mem.expired -> fetchNcache");
          return n;
        }
      }
      unicorn("$ext Memory");
      return m;
    }

    Api? n = await fetchNcache(url, ext: ext, mem: mem, disk: disk);
    Api? d = _apiBox.get(key);
    if (n != null) {
      unicorn("$ext Disk -> fetchNcache");
      return n;
    } else {
      unicorn("$ext Disk");
      return d;
    }
  }

  //Network call and saving in disk or memory, if fails returns null and saves nothing
  Future<Api?> fetchNcache(
    String url, {
    String ext = "",
    int mem = -1,
    int disk = -1,
  }) async {
    final key = "${url.toLowerCase()}🔥$ext";

    // final Response n = await _dioByte.get(url);
    final http.Response res = await http.get(Uri.parse(url));

    // ext = ((res.headers['content-type']?.split('/')[1])) ?? ext;

    //content-type, age, cache-control max-age

    if (res.statusCode == 200) {
      final Api d;
      final time = DateTime.now().millisecondsSinceEpoch;
      disk = disk * 60000 + time;
      mem = mem * 60000 + time;
      if (ext == "") {
        d = Api(
          url: url,
          // data: utf8.decode(n.data),
          data: res.body,
          expire: max(mem, disk),
        );
      } else {
        // unicorn(file2.statSync().toString());

        d = Api(
          url: url,
          data: await res.imgFilePath(url, _tempDir, ext),
          expire: max(mem, disk),
        );
      }

      // Cache in disk for specified time
      if (disk > time) {
        unicorn("$ext Cached in disk with key : key");
        await _apiBox.put(key, d.copyWith(expire: disk));
      }

      // Cache in mem for specified time
      if (mem > time) {
        unicorn("$ext Cached in mem with key : key");
        return _apiMap.update(
          key,
          (value) => value = d.copyWith(expire: mem),
          ifAbsent: () => d.copyWith(expire: mem),
        );
      }

      return d;
    }
    return null;
  }
}

extension on http.Response {
  Future<String> imgFilePath(String url, Directory tempDir, String ext) async {
    // final img = n.data;
    final img = bodyBytes;

    String fileName = md5sum(url);
    String filePath = path.join(tempDir.path, ext, "$fileName.$ext");

    await Directory(path.join(tempDir.path, ext)).create(recursive: true);
    // lava(await Directory(path.join(_tempDir.path, ext))
    //     .statSync()
    //     .toString());
    File file2 = File(filePath);
    file2.writeAsBytesSync(img);

    return filePath;
  }
}
