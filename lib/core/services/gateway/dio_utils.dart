import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/services/gateway/json_parser.dart';
import 'package:rxdart/rxdart.dart';

import 'error_handle.dart';
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
    var options = BaseOptions(
      connectTimeout: 30000, //15000
      receiveTimeout: 15000,
      responseType: ResponseType.json,
      // validateStatus: (status) {
      //   // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
      //   return true;
      // },
      baseUrl: "https://jommalaysiaapi.azurewebsites.net/api/",
      // baseUrl: "https://localhost:44368/api/",
//      contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
    );
    _dio = Dio(options);

    /// 统一添加身份验证请求头
    _dio.interceptors.add(AuthInterceptor());

    /// 刷新Token
    _dio.interceptors.add(TokenInterceptor());

    /// 打印Log(生产模式去除)
    if (!Constant.inProduction) {
      _dio.interceptors.add(LoggingInterceptor());
    }

    /// 适配数据(根据自己的数据结构，可自行选择添加)
    // _dio.interceptors.add(AdapterInterceptor());
  }

  // 数据返回格式统一，统一处理异常
  Future<T> _request<T, K>(String method, String url,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    Response response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    try {
      /// 集成测试无法使用 isolate
      return JsonParser.fromJson<T, K>(response.data);
    } catch (e) {
      throw e;
      //  return BaseEntity(ExceptionHandle.parse_error, "数据解析错误", null);
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  // Future requestNetwork<T, K>(Method method, String url,
  //     {Function(T t) onSuccess,
  //     Function(List<T> list) onSuccessList,
  //     Function(int code, String msg) onError,
  //     dynamic params,
  //     Map<String, dynamic> queryParameters,
  //     CancelToken cancelToken,
  //     Options options,
  //     bool isList: false}) async {
  //   String m = _getRequestMethod(method);
  //   return await _request<T, K>(m, url,
  //           data: params,
  //           queryParameters: queryParameters,
  //           options: options,
  //           cancelToken: cancelToken)
  //       .then((BaseEntity<T, K> result) {
  //     if (result.code == 0) {
  //       if (isList) {
  //         if (onSuccessList != null) {
  //           onSuccessList(result.listData);
  //         }
  //       } else {
  //         if (onSuccess != null) {
  //           onSuccess(result.data);
  //         }
  //       }
  //     } else {
  //       _onError(result.code, result.message, onError);
  //     }
  //   }, onError: (e, _) {
  //     _cancelLogPrint(e, url);
  //     NetError error = ExceptionHandle.handleException(e);
  //     _onError(error.code, error.msg, onError);
  //   });
  // }

  /// 统一处理(onSuccess返回T对象，onSuccessList返回List<T>)
  asyncRequestNetwork<T, K>(Method method, String url,
      {Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    String m = _getRequestMethod(method);
    Observable.fromFuture(_request<T, K>(m, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result) {
      if (onSuccess != null) {
        onSuccess(result);
      }
    }, onError: (e) {
      _cancelLogPrint(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      logger.i("取消请求接口： $url");
    }
  }

  _onError(int code, String msg, Function(int code, String mag) onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = "Unknown Error";
    }
    logger.e("接口请求异常： code: $code, mag: $msg");
    if (onError != null) {
      onError(code, msg);
    }
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

Map<String, dynamic> parseData(dynamic data) {}

enum Method { get, post, put, patch, delete, head }
