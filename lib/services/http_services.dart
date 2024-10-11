import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import '../utility/constants.dart';
import 'dart:html' as html;

class HttpService  {
  final String baseUrl = MAIN_URL;
  Map<String, String> _getHeaders() {
    String? getToken() {
      return html.window.localStorage['token'];
    }
    final token = getToken();
    if (token != null) {
      return {
        'Authorization': 'Bearer $token',
      };
    }
    return {
      'Content-Type': 'application/json'
    };
  }
  Future<Response> getItems({required String endpointUrl}) async {
    try {
      return await GetConnect().get('$baseUrl/$endpointUrl',headers: _getHeaders());
    } catch (e) {
      return Response(body: json.encode({'error': e.toString()}), statusCode: 500);
    }
  }


  Future<Response> addItem({required String endpointUrl, required dynamic itemData}) async {
    try {
      final response = await GetConnect().post('$baseUrl/$endpointUrl',itemData,headers: _getHeaders());
      return response;
    } catch (e) {
      return Response(body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }


  Future<Response> updateItem({required String endpointUrl, required String itemId, required dynamic itemData}) async {
    try {
      return await GetConnect().put('$baseUrl/$endpointUrl/$itemId', itemData,headers: _getHeaders());
    } catch (e) {
      return Response(body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> deleteItem({required String endpointUrl, required String itemId}) async {
    try {
      return await GetConnect().delete('$baseUrl/$endpointUrl/$itemId',headers: _getHeaders());
    } catch (e) {
      return Response(body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }
}
