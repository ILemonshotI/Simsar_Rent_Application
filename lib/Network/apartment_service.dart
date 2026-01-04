import 'package:dio/dio.dart';
import 'package:simsar/Network/api_client.dart';
import 'package:simsar/Models/property_model.dart';

class ApartmentService {
  static Future<List<Property>> fetchApartments({
    String? city,
    String? province,
    double? minPrice,
    double? maxPrice,
    int perPage = 12,
  }) async {
    final response = await DioClient.dio.get(
      '/api/apartments',
      queryParameters: {
        if (city != null) 'city': city,
        if (province != null) 'province': province,
        if (minPrice != null) 'min_price': minPrice,
        if (maxPrice != null) 'max_price': maxPrice,
        'per_page': perPage,
      },
    );

    final List data = response.data['data'];

    return data.map((e) => Property.fromApiJson(e)).toList();
  }
}
