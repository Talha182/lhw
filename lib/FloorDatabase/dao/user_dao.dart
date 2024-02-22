import 'package:floor/floor.dart';
import '../entity/user.dart'; // Ensure this import points to your User entity

@dao
abstract class UserDao {
  @Query('SELECT * FROM User')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM User WHERE id = :id')
  Stream<User?> findUserById(int id);

  @insert
  Future<void> insertUser(User user);

  @Query('SELECT * FROM User WHERE email = :email AND password = :password')
  Future<User?> findUserByEmailAndPassword(String email, String password);

}
