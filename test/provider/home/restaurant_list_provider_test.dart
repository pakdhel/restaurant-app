import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantListProvider(mockApiServices);
  });

  test('State awal harus NoneState', () {
    expect(provider.resultState, isA<RestaurantListNoneState>());
  });

  test('Harus mengembalikan loadedState ketika API berhasil', () async {
    final mockResponse = RestaurantListResponse(
      error: false,
      message: 'success',
      count: 1,
      restaurants: [
        Restaurant(
          id: '1',
          name: 'Test restaurant',
          description: 'Test description',
          pictureId: '1',
          city: 'Jakarta',
          rating: 4.6,
        ),
      ],
    );

    when(
      () => mockApiServices.getRestaurantList(),
    ).thenAnswer((_) async => mockResponse);

    await provider.fetchRestaurantList();

    expect(provider.resultState, isA<RestaurantListLoadedState>());
  });

  test(
    'Harus mengembalikan ErrorState ketika API mengembalikan error true',
    () async {
      final mockResponse = RestaurantListResponse(
        error: true,
        message: 'Failed to fetch',
        count: 0,
        restaurants: [],
      );

      when(
        () => mockApiServices.getRestaurantList(),
      ).thenAnswer((_) async => mockResponse);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
    },
  );

  test('Harus mengembalikan ErrorState ketika API throw Exception', () async {
    when(
      () => mockApiServices.getRestaurantList(),
    ).thenThrow(Exception('Network error'));

    await provider.fetchRestaurantList();
    expect(provider.resultState, isA<RestaurantListErrorState>());
  });
}
