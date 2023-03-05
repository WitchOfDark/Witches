import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class GoogleClient extends IOClient {
  final Map<String, String> _headers;

  GoogleClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) =>
      super.head(url, headers: headers?..addAll(_headers));
}

class OoogleClient extends IOClient {
  Map<String, String> headers;

  OoogleClient({required this.headers}) : super();

  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) =>
      super.send(request..headers.addAll(headers));
}

class BoogleClient extends http.BaseClient {
  Map<String, String> headers;
  final http.Client _c;

  BoogleClient({required this.headers}) : _c = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _c.send(request..headers.addAll(headers));
  }
}

class DoogleClient extends IOClient {
  final Map<String, String> _headers;

  DoogleClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) {
    return super.send(request..headers.addAll(_headers));
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return super.delete(url,
        headers: headers?..addAll(_headers), body: body, encoding: encoding);
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return super.get(url, headers: headers?..addAll(_headers));
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    return super.head(url, headers: headers?..addAll(_headers));
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return super.patch(url,
        headers: headers?..addAll(_headers), body: body, encoding: encoding);
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return super.post(url,
        headers: headers?..addAll(_headers), body: body, encoding: encoding);
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return super.put(url,
        headers: headers?..addAll(_headers), body: body, encoding: encoding);
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    return super.read(url, headers: headers?..addAll(_headers));
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    return super.readBytes(url, headers: headers?..addAll(_headers));
  }
}
