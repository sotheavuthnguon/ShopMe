import 'package:flutter_shop_me_dio/src/constants/app_constants.dart';
import 'package:flutter_shop_me_dio/src/models/xcore.dart';
import 'package:flutter_shop_me_dio/src/services/http_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;

  late HttpService httpService = HttpService();

  @override
  void onInit() {
    httpService.init();
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final result =
          await httpService.request(url: 'products', method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var products =
              List<Product>.from((result.data).map((x) => Product.fromJson(x)));
          productList.value = products;
          logger.d(products);
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
