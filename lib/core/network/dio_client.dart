import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio}) {
    //dio.options.baseUrl = 'http://192.168.100.19:8080/api';
    dio.options.baseUrl = 'http://44.216.207.182:8080/api';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Response> post(String path, {dynamic data, Options? options}) async {
    return await dio.post(path, data: data, options: options);
  }

  Future<Response> authenticate(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> get(String path, {Options? options}) async {
    return await dio.get(path, options: options);
  }

  Future<Response> patch(String path, {dynamic data, Options? options}) async {
    return await dio.patch(path, data: data, options: options);
  }

  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    return await dio.delete(path, data: data, options: options);
  }
}
