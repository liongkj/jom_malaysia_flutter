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
  Future<String> uploadFile(String path, List<int> file, String filename) {
    var param = CloudinaryUploadRequest(folder: path, file: file);
    _httpService.asyncRequestNetwork<CloudinaryUploadResponse, Null>(
        Method.post,
        url: CloudinaryEndPoint.upload,
        params: param,
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
