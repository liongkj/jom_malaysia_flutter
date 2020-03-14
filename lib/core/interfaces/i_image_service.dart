abstract class IImageService {
  Future<String> uploadFile(String path, List<int> file, String filename);
}
