import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  Future<void> _signUpWithEmailAndPassword(String email,
      String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithEmailAndPassword(String email,
      String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      print('Пожалуйста, заполните все поля');
      return;
    }

    if (_isLogin) {
      await _signInWithEmailAndPassword(email, password);
    } else {
      await _signUpWithEmailAndPassword(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLogin ? 'Вход' : 'Регистрация',
          style: TextStyle(color: Colors.black), // Черный текст заголовка
        ),
        backgroundColor: Colors.white, // Белый фон AppBar
        elevation: 0, // Убираем тень
        iconTheme: IconThemeData(color: Colors.black), // Черные иконки
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black), // Черный цвет метки
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // Черная рамка при фокусе
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Черная рамка
                ),
              ),
              style: TextStyle(color: Colors.black), // Черный текст ввода
              cursorColor: Colors.black, // Черный курсор
            ),
            SizedBox(height: 10), // Уменьшено расстояние между полями
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Пароль',
                labelStyle: TextStyle(color: Colors.black), // Черный цвет метки
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // Черная рамка при фокусе
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Черная рамка
                ),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.black),
              // Черный текст ввода
              cursorColor: Colors.black, // Черный курсор
            ),
            SizedBox(height: 20), // Расстояние до кнопки осталось прежним
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                // Черный фон кнопки
                foregroundColor: Colors.white,
                // Белый текст
                elevation: 0,
                // Убираем тень
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32), // Большие скругления
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(_isLogin ? 'Войти' : 'Зарегистрироваться'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(
                _isLogin
                    ? 'Нет аккаунта? Зарегистрируйтесь'
                    : 'Уже есть аккаунт? Войдите',
                style: TextStyle(color: Colors.black), // Черный текст
              ),
            ),
          ],
        ),
      ),
    );
  }
}