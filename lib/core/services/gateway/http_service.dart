import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/dio_utils.dart';

class HttpService {
  CancelToken _cancelToken;

  HttpService() {
    _cancelToken = CancelToken();
  }

  ///sync request
  Future requestNetwork<T, K>(
    Method method, {
    @required String url,
    bool isShow: true,
    bool isClose: true,
    Function(T t) onSuccess,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    // if (isShow) view.showProgress();
    await DioUtils.instance.requestNetwork<T, K>(
      method,
      url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSuccess: (data) {
        // if (isClose) view.closeProgress();
        if (onSuccess != null) {
          onSuccess(data);
        }
      },
    );
  }

  ///async request
  Future<T> asyncRequestNetwork<T, K>(
    Method method, {
    @required String url,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) {
    return DioUtils.instance.request<T, K>(
      method,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
  }
}
