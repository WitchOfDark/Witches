// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';
// import 'dart:collection';
// import 'dart:io';

// import 'package:darkknight/debug_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:isar/isar.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';

// import '../db_helper.dart';

// @collection
// class IsarApi implements DbHelp {
//   Id id = Isar.autoIncrement;
//   final String url;
//   final String data;
//   final int expire; // store till

//   IsarApi({
//     required this.url,
//     required this.data,
//     this.expire = -1,
//   });

//   IsarApi copyWith({
//     String? url,
//     String? data,
//     int? expire,
//   }) {
//     return IsarApi(
//       url: url ?? this.url,
//       data: data ?? this.data,
//       expire: expire ?? this.expire,
//     );
//   }

//   bool get isExpired {
//     return expire < DateTime.now().millisecondsSinceEpoch;
//   }

//   @override
//   Widget toWidget() {
//     unicorn("${url.substring(0, 21)}  $expire");
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(url),
//         Text(data),
//         Text("Type : ${data.split(".").last}"),
//         Text("Expire : ${DateTime.fromMillisecondsSinceEpoch(expire)}"),
//         // EpochTimer(expire: expire, sec: 1),
//       ],
//     );
//   }

//   @override
//   Map<String, Map> toMap() {
//     return {
//       "Api": {
//         'url': url,
//         'data': data,
//         'expire': expire,
//       }
//     };
//   }
// }

// class IsarApiService implements IDbService {
//   @override
//   bool initialized = false;

//   IsarCollection<IsarApi>? _isarApiBox;

//   @override
//   IsarCollection<IsarApi>? get ibox {
//     return _isarApiBox;
//   }

//   final HashMap<String, IsarApi> _apiMap = HashMap<String, IsarApi>();

//   @override
//   HashMap<String, IsarApi> get pmap {
//     return _apiMap;
//   }

//   late Directory _tempDir;

// /*
//   late Dio _dioByte;
// */

//   @override
//   Future<void> init() async {
//     if (!initialized) {
//       _isarApiBox = Isar.getInstance()?.collection<IsarApi>();

//       _tempDir = await getTemporaryDirectory();

// /*
//       _dioByte = Dio(BaseOptions(responseType: ResponseType.bytes));
// */
//     }

//     initialized = true;
//     dino("ApiService initialized $initialized");
//   }

//   //1 : Memory : If available in memory and not expired, if expired call network, if network fails return memory
//   //2 : Disk : If available in disk, Only used when network call fail
//   //3 : Network
//   //
//   //Find in memory
//   //  If in memory
//   //    If expired : fetchNcache; If success return fetchNCache
//   //    return inMem
//   //Not Found in memory
//   //Find in disk
//   //  Even if in disk : fetchNcache; If success return fetchNCache
//   //  return inDisk
//   //Not Found in disk
//   //return fetchNcache
//   Future<IsarApi?> get(
//     String url, {
//     String ext = "",
//     int mem = -1, //cache for min
//     int disk = -1, //cache for min
//   }) async {
//     try {
//       final key = "${url.toLowerCase()}🔥$ext";

//       final m = _apiMap[key];
//       if (m != null) {
//         if (m.isExpired) {
//           IsarApi? n = await fetchNcache(url, ext: ext, mem: mem, disk: disk);
//           if (n != null) {
//             unicorn("$ext Mem.expired : fetchNcache");
//             return n;
//           }
//         }
//         unicorn("$ext return inMem");
//         return m;
//       }

//       IsarApi? n = await fetchNcache(url, ext: ext, mem: mem, disk: disk);
// /*
//       IsarApi? d = await _isarApiBox?.filter().urlContains(key).findFirst();

//       if (n != null) {
//         unicorn("$ext Disk : fetchNcache");
//         return n;
//       } else {
//         unicorn("$ext return inDisk");
//         return d;
//       }
// */
//     } on Exception catch (e) {
//       lava(e);
//       lava("Api Service : Get Exception");
//       return null;
//     }
//   }

//   //Network call and saving in disk or memory, if fails returns null and saves nothing
//   Future<IsarApi?> fetchNcache(
//     String url, {
//     String ext = "",
//     int mem = -1,
//     int disk = -1,
//   }) async {
//     final key = "${url.toLowerCase()}🔥$ext";
//     /*
//     final Response n = await _dioByte.get(url);
//     //   unicorn(n.headers.map["content-type"]!.first
//     //       .split(";")[0]
//     //       .split("/")[1]
//     //       .toString());

//     //content-type, age, cache-control max-age

//     if (n.statusCode == 200) {
//       final IsarApi d;
//       final time = DateTime.now().millisecondsSinceEpoch;
//       disk = disk * 60000 + time;
//       mem = mem * 60000 + time;
//       if (ext == "") {
//         d = IsarApi(
//           url: url,
//           data: utf8.decode(n.data),
//           expire: max(mem, disk),
//         );
//       } else {
//         final img = n.data;

//         String fileName = md5sum(url);
//         String filePath = path.join(_tempDir.path, ext, "$fileName.$ext");

//         await Directory(path.join(_tempDir.path, ext)).create(recursive: true);
//         // lava(await Directory(path.join(_tempDir.path, ext))
//         //     .statSync()
//         //     .toString());
//         File file2 = File(filePath);
//         file2.writeAsBytesSync(img);

//         // unicorn(file2.statSync().toString());

//         d = IsarApi(
//           url: url,
//           data: filePath,
//           expire: max(mem, disk),
//         );
//       }

//       // Cache in disk for specified time
//       if (disk > time) {
//         unicorn("$ext Cached in disk with key : key");
//         await _isarApiBox?.put(d.copyWith(expire: disk));
//       }

//       // Cache in mem for specified time
//       if (mem > time) {
//         unicorn("$ext Cached in mem with key : key");
//         return _apiMap.update(
//           key,
//           (value) => value = d.copyWith(expire: mem),
//           ifAbsent: () => d.copyWith(expire: mem),
//         );
//       }

//       return d;
//     }
// */
//     return null;
//   }
// }
