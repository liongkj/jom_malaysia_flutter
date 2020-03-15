import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/interfaces/i_image_service.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/core/services/image/cloudinary/cloudinary_upload_request.dart';
import 'package:jom_malaysia/core/services/image/cloudinary/cloudinary_upload_response.dart';

class CloudinaryImageService implements IImageService {
  HttpService _httpService;
  CloudinaryImageService({@required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<String> uploadFile(
      String path, List<int> file, String filename) async {
    final Options options = buildCacheOptions(Duration(days: 7),
        options: new RequestOptions(
          baseUrl: CloudinaryEndPoint.upload,
        ));
    var imagedata = MultipartFile.fromBytes(file, filename: filename);
    debugPrint(imagedata.toString());
    FormData formData = FormData.fromMap({
      CloudinaryUploadRequest.file: imagedata,
      CloudinaryUploadRequest.uploadPreset:
          CloudinaryUploadRequest.defaultPreset,
      CloudinaryUploadRequest.folder: "comment_image"
    });

//    formData.files
//      ..add(MapEntry(
//          CloudinaryUploadRequest.file, MultipartFile.fromBytes(file)));
//    formData.fields
//      ..add(MapEntry(CloudinaryUploadRequest.uploadPreset,
//          CloudinaryUploadRequest.defaultPreset))
//      ..add(MapEntry(CloudinaryUploadRequest.folder, "comment_image"));
    await _httpService.requestNetwork<CloudinaryUploadResponse, Null>(
        Method.post,
        url: "",
        params: formData,
        options: options,
        isShow: false, onSuccess: (data) {
      if (data != null) {
        return data.secure_url;
      }
      return null;
    }, onError: (_, __) {
      return null;
    });
    return null;
  }
}
