import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/photo_equipment.dart';
import 'catalog_page.dart';
import 'favorites_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'chat_screen.dart';

final List<PhotoEquipment> equipmentList = [
  PhotoEquipment(
    title: 'Canon EOS R5',
    brand: 'Canon',
    price: 3899.99,
    imageUrl: 'https://m.media-amazon.com/images/I/81R7ewwBg3L._AC_SL1500_.jpg',
    category: 'Камеры',
    description: 'Профессиональная беззеркальная камера с продвинутыми функциями.',
    isFavorite: false,
    isInCart: false,
  ),
  PhotoEquipment(
    title: 'Nikon Z7 II',
    brand: 'Nikon',
    price: 2999.99,
    imageUrl: 'https://www.nikon.de/globalassets/digizuite/127246-en-z7ii_bfn1_front.png/OptimizelyPhoneWebP',
    category: 'Камеры',
    description: 'Полнокадровая беззеркальная камера с отличной детализацией и скоростью работы.',
    isFavorite: false,
    isInCart: false,
  ),
  PhotoEquipment(
    title: 'Sony Alpha 7 IV',
    brand: 'Sony',
    price: 2499.99,
    imageUrl: 'https://www.foto-heibel.de/media/image/00/d7/66/113001-1200Wx1200H.jpg',
    category: 'Камеры',
    description: 'Беззеркальная камера с гибридным автофокусом и превосходной цветопередачей.',
    isFavorite: false,
    isInCart: false,
  ),
  PhotoEquipment(
    title: 'Fujifilm X-T4',
    brand: 'Fujifilm',
    price: 1699.99,
    imageUrl: 'https://m.media-amazon.com/images/I/814e0G3QbWL.jpg',
    category: 'Камеры',
    description: 'Компактная камера с матрицей APS-C, идеально подходящая для видеосъемки и фото.',
    isFavorite: false,
    isInCart: false,
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CatalogPage(equipmentList: equipmentList),
    FavoritesPage(equipmentList: equipmentList),
    CartPage(equipmentList: equipmentList),
    ChatScreen(),
    ProfilePage(),
  ];

  final List<String> _titles = [
    'Каталог',
    'Лайкнутое',
    'Корзина',
    'Чат',
    'Профиль',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Лайкнутое',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Чат',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}
