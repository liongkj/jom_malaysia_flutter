import 'package:firebase_storage/firebase_storage.dart';
import 'package:jom_malaysia/core/interfaces/i_image_service.dart';

class FirebaseStorageService implements IImageService {
  FirebaseStorage _storage;

  FirebaseStorageService() {
    _storage =
        FirebaseStorage(storageBucket: 'gs://jomn9-1566369147288.appspot.com');
  }
  Future<String> uploadFile(
      String path, List<int> file, String filename) async {
    final storageReference = _storage.ref().child("$path").child(filename);

    final StorageUploadTask uploadTask = storageReference.putData(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }
}
