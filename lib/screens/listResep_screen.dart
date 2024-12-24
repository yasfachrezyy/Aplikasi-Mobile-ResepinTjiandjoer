import 'package:flutter/material.dart';
import 'package:resep_mobile/model/resep_model.dart';
import 'package:resep_mobile/screens/detail_screen.dart';

const kBackgroundColor = Colors.orange;

class ListResepPage extends StatefulWidget {
  const ListResepPage({Key? key}) : super(key: key);

  @override
  _ListResepPageState createState() => _ListResepPageState();
}

class _ListResepPageState extends State<ListResepPage> {
  final TextEditingController _searchController = TextEditingController();
  List<MenuMakanan> _filteredMenuList = List.from(menuMakananList);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes(String query) {
    final List<MenuMakanan> filteredList = menuMakananList
        .where((resep) =>
            resep.namaMakanan.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredMenuList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Resep Makanan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green.shade50,
                prefixIcon: const Icon(Icons.search, color: kBackgroundColor),
                hintText: 'Cari Resep',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: _filteredMenuList.length,
              itemBuilder: (context, index) {
                final menu = _filteredMenuList[index];
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
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            menu.image![0],
                            height: 150.0,
                            width: 150.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          menu.namaMakanan,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
