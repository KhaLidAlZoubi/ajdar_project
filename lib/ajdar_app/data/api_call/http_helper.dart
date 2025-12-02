import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ajder_project/conest.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../url/user_url/info_url.dart';
import 'package:http_parser/http_parser.dart'; // مهم جداً
import 'package:path/path.dart';
import 'package:mime/mime.dart';

class HttpHelper {
  static Future<StreamedResponse> postDataWithImage({
    required String url,
    required Map<String, String> body,
    required String fileKey,
    required String filePath,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}',
    };
    MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseURL$url'),
    );
    request.fields.addAll(body);
    if (filePath != '') {
      request.files.add(await http.MultipartFile.fromPath(fileKey, filePath));
    }

    request.headers.addAll(headers);

    return await request.send();
  }

  static Future<Response> getDat({required String url}) async {
    return await http.get(
      Uri.parse('$baseURL$url'),
      // headers: {
      //   'Accept': 'application/json',
      //   // 'Authorization': 'Bearer ${box.read('token')}',
      // },
    );
  }

  static Future<Response> getData({required String url}) async {
    return await http.get(
      Uri.parse('$baseURL$url'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
  }

  static Future<Response> postData({
    required String url,
    required Object body,
  }) async {
    return await http.post(
      Uri.parse('$baseURL$url'),
      body: body,
      headers: {
        'Authorization': 'Bearer ${box.read('token')}',
        'Accept': 'application/json',
      },
    );
  }

  static Future<StreamedResponse> postMultiData({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}',
      // 'lang': box.read('lang')
    };
    var request = http.Request('POST', Uri.parse('$baseURL$url'));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  }

  static Future<StreamedResponse> putMultiData({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}',
      // 'lang': box.read('lang')
    };
    var request = http.Request('PUT', Uri.parse('$baseURL$url'));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  }

  static Future<Response> deleteData({required String url}) async {
    return await http.delete(
      Uri.parse(baseURL + url),
      headers: {
        'Authorization': 'Bearer ${box.read('token')}',
        'Accept': 'application/json',
      },
    );
  }

  static String baseURL = 'https://api.syriaopenstore.com/api/';
  static Future<http.Response> uploadWithImages({
    required String url,
    required Map<String, dynamic> fields,
    List<File>? imageUrl,
    Map<String, String>? headers,
    void Function(double progress)? onProgress, // النسبة 0.0 - 1.0
  }) async {
    final defaultHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}',
    };
    if (headers != null) defaultHeaders.addAll(headers);

    var request = http.MultipartRequest("POST", Uri.parse('$baseURL$url'));

    // إضافة الحقول
    fields.forEach((key, value) {
      if (value != null) {
        if (value is String || value is num || value is bool) {
          request.fields[key] = value.toString();
        } else {
          // print("request: ${request.fields}");
          request.fields[key] = json.encode(value);
          print("request: ${request.fields[key]}");
        }
      } else {
        print("null");
      }
    });

    // رفع الصور
    if (imageUrl != null) {
      for (var img in imageUrl) {
        final mimeType = lookupMimeType(img.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'imageUrl',
            img.path,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
            filename: basename(img.path),
          ),
        );
      }
    }

    request.headers.addAll(defaultHeaders);

    final streamedResponse = await request.send();

    if (onProgress != null) {
      final totalBytes = streamedResponse.contentLength ?? 0;
      int bytesReceived = 0;

      // StreamTransformer مع تحديد النوع List<int>
      final stream = streamedResponse.stream.transform(
        StreamTransformer<List<int>, List<int>>.fromHandlers(
          handleData: (data, sink) {
            bytesReceived += data.length;
            double progress = totalBytes != 0 ? bytesReceived / totalBytes : 0;
            onProgress(progress); // تحديث التقدم
            sink.add(data);
          },
        ),
      );

      final response = await http.Response.fromStream(
        http.StreamedResponse(
          stream,
          streamedResponse.statusCode,
          headers: streamedResponse.headers,
        ),
      );
      return response;
    } else {
      return await http.Response.fromStream(streamedResponse);
    }
  }

  static Future<http.Response> uploadWithImagesAndData({
    required String url,
    required Map<String, dynamic> fields,
    List<File>? imageUrl,
    Map<String, String>? headers,
    void Function(double progress)? onProgress, // النسبة 0.0 - 1.0
  }) async {
    final defaultHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}',
    };
    if (headers != null) defaultHeaders.addAll(headers);

    var request = http.MultipartRequest("POST", Uri.parse('$baseURL$url'));

    // ✅ إضافة الحقول العادية + معالجة خاصة لـ fieldValues
    fields.forEach((key, value) {
      if (key == "fieldValues" && value is List) {
        for (int i = 0; i < value.length; i++) {
          final item = value[i];
          if (item is Map) {
            if (item.containsKey("dynamicFieldId")) {
              request.fields["fieldValues[$i].DynamicFieldId"] =
                  item["dynamicFieldId"].toString();
            }
            if (item.containsKey("value")) {
              request.fields["fieldValues[$i].Value"] = item["value"]
                  .toString();
            }
          }
        }
      } else {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      }
    });

    // ✅ رفع الصور
    if (imageUrl != null) {
      for (var img in imageUrl) {
        final mimeType = lookupMimeType(img.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'imageUrl', // 👈 لاحظ S capital حتى يطابق الباك
            img.path,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
            filename: basename(img.path),
          ),
        );
      }
    }

    request.headers.addAll(defaultHeaders);

    final streamedResponse = await request.send();

    if (onProgress != null) {
      final totalBytes = streamedResponse.contentLength ?? 0;
      int bytesReceived = 0;

      final stream = streamedResponse.stream.transform(
        StreamTransformer<List<int>, List<int>>.fromHandlers(
          handleData: (data, sink) {
            bytesReceived += data.length;
            double progress = totalBytes != 0 ? bytesReceived / totalBytes : 0;
            onProgress(progress);
            sink.add(data);
          },
        ),
      );

      final response = await http.Response.fromStream(
        http.StreamedResponse(
          stream,
          streamedResponse.statusCode,
          headers: streamedResponse.headers,
        ),
      );
      return response;
    } else {
      return await http.Response.fromStream(streamedResponse);
    }
  }

  static Future<Response> putData({
    required String url,
    required Object body,
  }) async {
    return await http.put(
      Uri.parse('$baseURL$url'),
      body: body,
      headers: {
        'Authorization': 'Bearer ${box.read('token')}',
        'Accept': 'application/json',
      },
    );
  }
}

// String? token;
String urlIMG = 'http://192.168.229.167:8000';
