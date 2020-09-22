import 'dart:convert';

import 'package:flutter_animation/resources/news_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetch top ids return lis of ids', () async {
    //set up of test case

    final newsapi = NewsApiProvider();
    newsapi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4, 5]), 200);
    });

    final ids = await newsapi.fetchTopIds();

    //expectation
    expect(ids, [1, 2, 3, 4,5]);
  });

  test('Fetch items return an Item Model',()async{
    final newsApi=NewsApiProvider();
    newsApi.client=MockClient((request) async{
      final jsonMap={'id':123};
      return Response(json.encode(jsonMap),200);
    });
    final item=await newsApi.fetchTopItem(999);
    expect(item.id, 123);
  });


}