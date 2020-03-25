import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/core/services/image/cloudinary/cloudinary_upload_request.dart';
import 'package:jom_malaysia/core/services/image/cloudinary/cloudinary_upload_response.dart';
import 'package:jom_malaysia/core/services/image/i_image_service.dart';

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
    FormData formData = FormData.fromMap({
      CloudinaryUploadRequest.file: imagedata,
      CloudinaryUploadRequest.uploadPreset:
          CloudinaryUploadRequest.defaultPreset,
      CloudinaryUploadRequest.folder: "comment_image"
    });
    var result;
    await _httpService.requestNetwork<CloudinaryUploadResponse, Null>(
      Method.post,
      url: "",
      params: formData,
      options: options,
      isShow: false,
      onSuccess: (data) {
        result = data.secure_url;
      },
    );
    return result;
  }
}
