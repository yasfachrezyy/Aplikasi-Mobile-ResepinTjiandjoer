import 'package:flutter/material.dart';
import 'package:resep_mobile/model/resep_model.dart';
import 'package:resep_mobile/screens/detail_screen.dart';
import 'package:resep_mobile/screens/favorite_screen.dart';
import 'package:resep_mobile/screens/listResep_screen.dart';
import 'package:resep_mobile/screens/profil_screen.dart';

const kBackgroundColor = Colors.orange;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const ListResepPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[
          _selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kBackgroundColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_sharp), label: 'List Resep'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: kBackgroundColor,
        elevation: 4.0,
        title: const Text(
          'Selamat Siang, Bro Virga',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.shade50,
                  prefixIcon: const Icon(Icons.search, color: kBackgroundColor),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 200.0,
                child: PageView.builder(
                  itemCount: 5, 
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 4),
                            blurRadius: 8.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(menuMakananList[index].image![0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListResepPage(),
                    ),
                  );
                },
                child: const Text(
                  "Lihat Semua",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final menu = menuMakananList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailResepPage(resep: menu),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 4),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            menu.image![0],
                            height: 120.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            menu.namaMakanan,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
