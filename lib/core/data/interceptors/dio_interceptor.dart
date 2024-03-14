import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  final bool convertFormData;

  DioInterceptor({this.convertFormData = true});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('REQUEST[${options.method}] => PATH: ${options.path}');

    print(options.data);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Api invoked => ${response.requestOptions.path}");
    log("Curl is =>\n");
    _renderCurlRepresentation(response.requestOptions);

    log("\n RESPONSE is =>\n ${jsonEncode(response.data)}");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log("Api invoked => ${err.response?.requestOptions.path}");
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    log("Curl is =>\n");
    _renderCurlRepresentation(err.requestOptions);
    return super.onError(err, handler);
  }

  /// Create Curl
  void _renderCurlRepresentation(RequestOptions requestOptions) {
    // add a breakpoint here so all errors can break
    try {
      log(_cURLRepresentation(requestOptions));
    } catch (err) {
      log('unable to create a CURL representation of the requestOptions');
    }
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      // FormData can't be JSON-serialized, so keep only their fields attributes
      if (options.data is FormData && convertFormData == true) {
        options.data = Map.fromEntries(options.data.fields);
      }

      final data = json.encode(options.data).replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' \\\n\t');
  }
}
