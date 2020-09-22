import 'dart:convert';

import 'package:flutter_animation/model/item_model.dart';
import 'package:http/http.dart' show Client;

final _baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_baseUrl/topstories.json');
    final ids = json.decode(response.body);
    return ids;
  }

  Future<ItemModel> fetchTopItem(int id) async {
    final response = await client.get('$_baseUrl/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
