
import 'database.dart';
import 'entity/user.dart';

class DatabaseInitializer {
  final AppDatabase database;

  DatabaseInitializer(this.database);

  Future<void> insertInitialData() async {
    final userDao = database.userDao;

    // Example user data, convert your JSON data to User objects
    final users = [
      User(
          id: 1,
          name: "lwh",
          email: "lhw@123.org",
          phone: "03159223072",
          nic: "21201",
          idNo: "4544435",
          dob: "1994-09-06",
          village: "vil1",
          ucName: "uc1",
          yearsExperience: 5,
          emailVerifiedAt: null,
          password: "11223344",
          image: "uploads/170833645240.png",
          roleId: null,
          status: "active",
          rememberToken: null,
          createdAt: "2023-12-13 01:08:08",
          updatedAt: "2024-02-19 14:54:12"
      ),
      User(
          id: 2,
          name: "سارہ احمد",
          email: "sara@phcglobal.org",
          phone: "09120510934",
          nic: "1213123123122",
          idNo: "۱۲۱۳۱۲",
          dob: "1999-09-09",
          village: "vil1",
          ucName: "uc1",
          yearsExperience: 0,
          emailVerifiedAt: null,
          password: "112233",
          image: "uploads/170833767573.png",
          roleId: null,
          status: "active",
          rememberToken: null,
          createdAt: "2024-02-16 17:29:54",
          updatedAt: "2024-02-19 15:14:35"
      ),
    ];

    // Insert each user
    for (var user in users) {
      await userDao.insertUser(user);
    }
  }
}
