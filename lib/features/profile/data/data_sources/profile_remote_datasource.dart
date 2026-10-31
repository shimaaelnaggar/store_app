import 'package:dio/dio.dart';
import 'package:store/core/errors/api_error_handler.dart';
import 'package:store/features/profile/data/models/profile_model.dart';

abstract class BaseProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSource implements BaseProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource({required this.dio});

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await dio.get<Map<String, dynamic>>('/api/auth/me');
      return ProfileModel.fromJson(response.data!);
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}
