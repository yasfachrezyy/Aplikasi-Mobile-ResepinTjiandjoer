import 'package:flutter/material.dart';
import 'package:resep_mobile/screens/home_page.dart';
import 'package:resep_mobile/screens/listResep_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resep_mobile/model/resep_model.dart';
import 'package:resep_mobile/screens/detail_screen.dart';

const kBackgroundColor = Colors.orange;

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<MenuMakanan> favoritResep = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteRecipes();
  }

  void _loadFavoriteRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritIds = prefs.getStringList('favorite_recipes') ?? [];

    setState(() {
      favoritResep = menuMakananList
          .where((recipe) => favoritIds.contains(recipe.namaMakanan))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: kBackgroundColor,
        elevation: 4.0,
        title: const Text(
          'Favorite',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true, 
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifikasi belum tersedia')),
              );
            },
          ),
        ],
      ),
      body: favoritResep.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/favorite.png', 
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Tidak ada resep favorit.",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Temukan berbagai resep lezat dan nikmati pengalaman memasak yang menyenangkan.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ListResepPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, 
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                    ),
                    child: const Text(
                      'Tambahkan Resep Favorit',
                      style: TextStyle(
                        color: kBackgroundColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favoritResep.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2.5,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailResepPage(resep: favoritResep[index]),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  favoritResep[index].image?[0] ?? '',
                                  width: double.infinity,
                                  fit: BoxFit
                                      .cover, 
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error,
                                        color: Colors.red);
                                  },
                                ),
                              ),
                              const SizedBox(
                                  height: 8.0), 
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  favoritResep[index].namaMakanan,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        14.0, 
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
