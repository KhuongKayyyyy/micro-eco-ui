import 'package:ecommerce_app/model/user/user_detail.dart';

class UserService {
  static Future<UserDetail> getUserDetail() async {
    // Simulate fetching delay
    await Future.delayed(const Duration(milliseconds: 1500));
    return UserDetail(
      name: 'Nguyen Dat Khuong',
      email: 'khuongnd@gmail.com',
      phone: '1234567890',
      address: '123 Main St, Anytown, USA',
      gender: 'Male',
      dateOfBirth: '2003-08-03',
    );
  }
}
