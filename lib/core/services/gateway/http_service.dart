import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/dio_utils.dart';

class HttpService {
  CancelToken _cancelToken;

  HttpService() {
    _cancelToken = CancelToken();
  }

  ///async request
  void asyncRequestNetwork<T, K>(
    Method method, {
    @required String url,
    bool isShow: true,
    bool isClose: true,
    Function(T t) onSuccess,
    Function(int code, String msg) onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) {
    // if (isShow) view.showProgress();
    DioUtils.instance.asyncRequestNetwork<T, K>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? _cancelToken, onSuccess: (data) {
      // if (isClose) view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }
    }, onError: (code, msg) {
      // _onError(code, msg, onError);
    });
  }
}
