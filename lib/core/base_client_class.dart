import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/core/session.dart';

class BaseClientClass {
  static const int TIME_OUT_DURATION = 30;

  static Future<dynamic> get(String url, String params) async {
    log('url: ${url + params}');

    http.Response response;
    try {
      // UserModel userModel = await MySharedPreferences.getUserSession();

      response = await http.get(
        Uri.parse(url + params),
        headers: {
          "Content-Type": "application/json",
          // 'Authorization': 'Bearer ${userModel.token}',
        },
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));

      printResponse(response);
      return handleResponse(response);
    } on SocketException {
      log('No internet connection');
      return 'No internet connection';
    } on TimeoutException {
      log('Connection timed out');
      return 'Connection timed out';
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print('HTTP Client Exception: $e');
      }
      return 'Network error';
    }
  }

  static Future<dynamic> postFormReq2(String url, Map data,
      {Map? files}) async {
    if (kDebugMode) {
      print('url: $url');
      print('data: $data');
      print('Files: $files');
    }

    // UserModel userModel = await MySharedPreferences.getUserSession();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      //  headers
      Map<String, String> headers = {
        // Uncomment and replace 'your-token' with the actual token
        // 'Authorization': 'Bearer ${userModel.token}',
      };

      //  the file if it exists
      if (files != null) {
        for (var entry in files.entries) {
          request.files
              .add(await http.MultipartFile.fromPath(entry.key, entry.value));
        }
      }

      // Adding form fields
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Adding headers to the request
      request.headers.addAll(headers);

      // Sending the request
      var responsed = await request.send();
      var response = await http.Response.fromStream(responsed);

      if (kDebugMode) {
        printResponse(response);
      }

      return handleResponse(response);
    } on SocketException {
      if (kDebugMode) {
        print('No internet connection');
      }
      return 'No internet connection';
    } on TimeoutException {
      if (kDebugMode) {
        print('Connection timed out');
      }
      return 'Connection timed out';
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
      return 'An error occurred: $e';
    }
  }

  static Future<dynamic> postFormReq(String url, Map data,
      {String? file}) async {
    if (kDebugMode) {
      print('url: $url');
      print('data: $data');
      print('File: $file');
    }

    UserModel userModel = await MySharedPreferences.getUserSession();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Adding headers
      Map<String, String> headers = {
        // Uncomment and replace 'your-token' with the actual token
        'Authorization': 'Bearer ${userModel.token}',
      };

      // Adding the file if it exists
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('image', file));
      }

      // Adding form fields
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Adding headers to the request
      request.headers.addAll(headers);

      // Sending the request
      var responsed = await request.send();
      var response = await http.Response.fromStream(responsed);

      if (kDebugMode) {
        printResponse(response);
      }

      return handleResponse(response);
    } on SocketException {
      if (kDebugMode) {
        print('No internet connection');
      }
      return 'No internet connection';
    } on TimeoutException {
      if (kDebugMode) {
        print('Connection timed out');
      }
      return 'Connection timed out';
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
      return 'An error occurred: $e';
    }
  }

  static Future<dynamic> post(
    String url,
    data,
  ) async {
    print('Url: $url');
    print(data);
    http.Response response;
    UserModel userModel = await MySharedPreferences.getUserSession();

    try {
      response = await http
          .post(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer ${userModel.token}',
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));

      printResponse(response);
      return handleResponse(response);
    } on SocketException {
      print('No internet connection');
      return 'No internet connection';
    } on TimeoutException {
      print('Connection timed out');
      return 'Connection timed out';
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print('HTTP Client Exception: $e');
      }
      return 'Network error';
    }
  }

  static Future<dynamic> put(String url, data) async {
    print('Url: $url');
    print(data);
    http.Response response;
    UserModel userModel = await MySharedPreferences.getUserSession();

    try {
      response = await http
          .put(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer ${userModel.token}',
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      printResponse(response);
      return handleResponse(response);
    } on SocketException {
      if (kDebugMode) {
        print('No internet connection');
      }
      return 'No internet connection';
    } on TimeoutException {
      if (kDebugMode) {
        print('Connection timed out');
      }
      return 'Connection timed out';
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print('HTTP Client Exception: $e');
      }
      return 'Network error';
    }
  }

  static Future<dynamic> delete(String url) async {
    if (kDebugMode) {
      print('Url: $url');
    }
    http.Response response;
    UserModel userModel = await MySharedPreferences.getUserSession();

    try {
      response = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${userModel.token}',
          // 'Authorization': 'Bearer ${SessionController().bearerToken}',
          // 'Authorization': appStore.TOKEN, // Include your authorization token here
        },
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      printResponse(response);
      return handleResponse(response);
    } on SocketException {
      if (kDebugMode) {
        print('Connection Problem');
      }
      return 'Connection Problem';
    } on TimeoutException {
      if (kDebugMode) {
        print('Connection timed out');
      }
      return 'Connection timed out';
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print('HTTP Client Exception: $e');
      }

      return 'Network error';
    }
  }

  static void printResponse(http.Response response) {
    print('######################### START ############################');
    print('Got response');
    log('Body: ${response.body}');

    print('Status Code: ${response.statusCode}');
  }

  static dynamic handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        return response;
      case 401:
        return 'Unauthorized';
      case 404:
        return 'Not-Found';
      case 409:
        return 'Conflict';
      case 500:
        return 'Internal Server Error';
      case 403:
        return 'Forbidden';
      case 429:
        return 'Too Many Requests';

      default:
        return 'Unknown Error';
    }
  }
}
