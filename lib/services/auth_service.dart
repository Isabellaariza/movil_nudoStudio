import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  ///  LOGIN
  static Future<String?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    ///  ADMIN
    if (email == "admin@nudostudio.com" && password == "123456") {
      await prefs.setBool("isLogged", true);
      await prefs.setString("role", "admin");
      return null;
    }

    ///  USUARIO REGISTRADO
    final savedEmail = prefs.getString("user_email");
    final savedPass = prefs.getString("user_pass");

    if (email == savedEmail && password == savedPass) {
      await prefs.setBool("isLogged", true);
      await prefs.setString("role", "user");
      return null;
    }

    return "Credenciales inválidas";
  }

  ///  OBTENER USUARIO COMPLETO
static Future<Map<String, String>> getUserData() async {
  final prefs = await SharedPreferences.getInstance();

  return {
    "name": prefs.getString("user_name") ?? "Usuario",
    "email": prefs.getString("user_email") ?? "correo@email.com",
    "phone": prefs.getString("user_phone") ?? "+57 300 000 0000",
    "address": prefs.getString("user_address") ?? "Dirección no registrada",
  };
}

///  GUARDAR INFO EXTRA
static Future<void> saveUserData({
  required String name,
  required String phone,
  required String address,
}) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString("user_name", name);
  await prefs.setString("user_phone", phone);
  await prefs.setString("user_address", address);
}

  

  ///  REGISTRO
  static Future<String?> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (email.isEmpty || password.isEmpty) {
      return "Completa todos los campos";
    }

    await prefs.setString("user_email", email);
    await prefs.setString("user_pass", password);

    return null;
  }

  /// RECUPERAR CONTRASEÑA
  static Future<String?> recoverPassword(String email) async {
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString("user_email");

    if (email == savedEmail) {
      return prefs.getString("user_pass");
    }

    return null;
  }

  ///  OBTENER ROL
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  ///  SABER SI ESTÁ LOGUEADO
  static Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogged") ?? false;
  }

  ///  LOGOUT (NO BORRA USUARIO REGISTRADO)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("isLogged");
    await prefs.remove("role");
  }

  static Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  }

}