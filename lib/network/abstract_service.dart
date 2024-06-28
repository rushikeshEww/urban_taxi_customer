import '../models/common_response.dart';

abstract class AbstractService {
  Future<CommonResponse> getLogin(String emailPhoneNumber, String password);
  Future<CommonResponse> getForgotPassword(String emailPhoneNumber);
  Future<CommonResponse> sendOTP(String phoneNumber);
  Future<CommonResponse> verifyOTP(String phoneNumber, String otp);
  Future<CommonResponse> registerUser(String phoneNumber, String email, String name, String password);
}