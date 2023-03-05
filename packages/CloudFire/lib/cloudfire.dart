import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:inferno/fire_service.dart';

abstract class CloudConvert {
  Map<String, dynamic> toMap();
}

class CloudStore {
  static final FirebaseFirestore cloudstore = FirebaseFirestore.instance;
  static final cloudusercol = cloudstore.collection(FireService.user?.id ?? 'nouid');

// //FirebaseFirestore.instance.settings = Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
// //await FirebaseFirestore.instance.disableNetwork()

  static CollectionReference<T> convUpload<T extends CloudConvert>({
    required String doc,
    required T Function(Map<String, dynamic> map) fromMap,
  }) {
    return cloudstore.collection(doc).withConverter<T>(
          fromFirestore: (snapshot, _) => fromMap(snapshot.data()!),
          toFirestore: (movie, _) => movie.toMap(),
        );
  }

  static Future<Map<String, dynamic>?> uploadgive() async {
    final hello = await cloudusercol.add({});

    final bye = await hello.get();

    return bye.data();
  }

  static Future<List<Map<String, dynamic>>?> list() async {
    final hello = (await cloudusercol.get()).docs;

    return hello.map(
      (e) {
        return e.data();
      },
    ).toList();
  }
}
