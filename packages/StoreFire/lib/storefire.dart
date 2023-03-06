// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:inferno/fire_service.dart';

import 'package:tamannaah/darkknight/debug_functions.dart';

typedef CloudListRef = List<Reference>;

class FireStore {
  static final firestore = FirebaseStorage.instance;
  static final fireuserref = firestore.ref(FireService.user?.id);

  static Future<String?> upload(
    String filename, {
    String? url,
    Uint8List? bytes,
  }) async {
    if (url != null) {
      final res = await http.get(Uri.parse(url));

      final hello = await fireuserref
          .child(filename)
          // .child('$filename.${(res.headers['content-type']?.split('/')[1])}')
          .putData(
            res.bodyBytes,
            SettableMetadata(
              contentType: res.headers['content-type'],
              customMetadata: res.headers,
            ),
          );

      unicorn(res.toString());
      lava(await hello.ref.getDownloadURL());

      return await hello.ref.getDownloadURL();
    }

    if (bytes != null) {
      final hello = await fireuserref.child(filename).putData(bytes);

      lava(await hello.ref.getDownloadURL());

      return await hello.ref.getDownloadURL();
    }

    return null;
  }

  static Future<void> delete(String name) async {
    return fireuserref.child(name).delete();
  }

  static Future<List<Reference>> listFolder() async {
    // fireuserref.list(ListOptions(maxResults: , pageToken: ,));
    return await fireuserref.listAll().then((value) => value.items);
  }

  Stream<ListResult> listAllPaginated(Reference storageRef) async* {
    String? pageToken;
    do {
      final listResult = await storageRef.list(ListOptions(
        maxResults: 100,
        pageToken: pageToken,
      ));
      yield listResult;
      pageToken = listResult.nextPageToken;
    } while (pageToken != null);
  }

  static void progress(UploadTask uploadTask, void Function(double progress) work) {
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          owl("Upload is $progress% complete.");
          work(progress);
          break;
        case TaskState.paused:
          owl("Upload is paused.");
          break;
        case TaskState.canceled:
          owl("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          // ...
          break;
      }
    });
  }
}
