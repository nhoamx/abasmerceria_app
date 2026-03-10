class ApiEndpoints {
  static const String _authority = 'costura.net';
  static const String _productsPath = '/api/v1/products';

  static Uri listProducts({int perPage = 50, int page = 1}) {
    return Uri.http(_authority, _productsPath, {
      'per_page': perPage.toString(),
      'page': page.toString(),
    });
  }

  static Uri searchProducts({
    required String query,
    int perPage = 50,
    int page = 1,
  }) {
    return Uri.http(_authority, '$_productsPath/search', {
      'query': query,
      'per_page': perPage.toString(),
      'page': page.toString(),
    });
  }

  static Uri searchProductBySku({
    required String sku,
    int perPage = 50,
    int page = 1,
  }) {
    return Uri.http(_authority, '$_productsPath/search/sku', {
      'sku': sku,
      'per_page': perPage.toString(),
      'page': page.toString(),
    });
  }
}
