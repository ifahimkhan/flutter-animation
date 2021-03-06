import 'package:flutter_animation/model/item_model.dart';
import 'package:flutter_animation/resources/news_api_provider.dart';
import 'package:flutter_animation/resources/news_db_provider.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchTopItems(int id) async {
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }
    item = await apiProvider.fetchTopItem(id);
    dbProvider.addItem(item);
  }
}
