import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Пользователь';
  String? email;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = name;

    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      email = user?.email;
    });
  }

  void _editName() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Белый фон окна
          title: Text(
            'Редактировать имя',
            style: TextStyle(color: Colors.black), // Черный цвет текста заголовка
          ),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Имя',
              labelStyle: TextStyle(color: Colors.black), // Черный цвет текста метки
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.black), // Черный текст ввода
            cursorColor: Colors.black, // Черный цвет курсора
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  name = _nameController.text;
                });
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Черный текст кнопки
              ),
              child: Text('Сохранить'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Черный текст кнопки
              ),
              child: Text('Отмена'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, size: 50,
                      color: Colors.white),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      if (email != null)
                        Text(
                          email!,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _editName,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8),
                          ),
                        ),
                        child: Text('Редактировать имя'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}