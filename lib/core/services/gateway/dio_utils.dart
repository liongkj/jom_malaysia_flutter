import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/services/gateway/exception/api_exception.dart';
import 'package:jom_malaysia/core/services/gateway/json_parser.dart';

import 'intercept.dart';

class DioUtils {
  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal() {
    String _webapi = "https://jommalaysiaapi.azurewebsites.net/";
    // ignore: unused_local_variable
    String _local = "http://10.0.2.2:5000/";
    var options = BaseOptions(
      connectTimeout: 30000, //15000
      receiveTimeout: 15000,
      responseType: ResponseType.json,

      baseUrl: "${_webapi}api/",
    );
    _dio = Dio(options);

    /// add cache for offline access
    _dio.interceptors.add(
        CacheInterceptor(CacheConfig(baseUrl: options.baseUrl)).interceptor);

    /// Refresh token

    // /// 统一添加身份验证请求头
    // _dio.interceptors.add(AuthInterceptor());

    // /// 刷新Token

    // _dio.interceptors.add(TokenInterceptor());

    /// 打印Log(生产模式去除)
    if (!Constant.inProduction) {
      _dio.interceptors.add(LoggingInterceptor());
    }
  }

  // 数据返回格式统一，统一处理异常
  Future<T> request<T, K>(
    Method method,
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    String m = _getRequestMethod(method);
    try {
      Response response = await _dio.request(url,
          data: data,
          queryParameters: queryParameters,
          options: _checkOptions(m, options),
          cancelToken: cancelToken);

      return JsonParser.fromJson<T, K>(response.data);
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on DioError catch (e) {
      if (e.response != null) {
        throw ApiException(e.response.statusCode, e.response.statusMessage);
      }
      throw SocketException(e.message);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw SocketException("unkown exception");
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;

    return options;
  }

  requestNetwork<T, K>(
    Method method,
    String url, {
    Function(T t) onSuccess,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
    bool isList: false,
  }) {
    return request<T, K>(method, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then(
      (result) {
        if (onSuccess != null) {
          onSuccess(result);
        }
      },
    );
  }

  String _getRequestMethod(Method method) {
    String m;
    switch (method) {
      case Method.get:
        m = "GET";
        break;
      case Method.post:
        m = "POST";
        break;
      case Method.put:
        m = "PUT";
        break;
      case Method.patch:
        m = "PATCH";
        break;
      case Method.delete:
        m = "DELETE";
        break;
      case Method.head:
        m = "HEAD";
        break;
    }
    return m;
  }
}

enum Method { get, post, put, patch, delete, head }
