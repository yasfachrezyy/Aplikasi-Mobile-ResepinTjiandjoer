import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resep_mobile/model/resep_model.dart';

class DetailResepPage extends StatefulWidget {
  final MenuMakanan resep;

  const DetailResepPage({Key? key, required this.resep}) : super(key: key);

  @override
  _DetailResepPageState createState() => _DetailResepPageState();
}

class _DetailResepPageState extends State<DetailResepPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  // Mengecek apakah resep sudah ada di favorit
  void _checkFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritIds = prefs.getStringList('favorite_recipes') ?? [];

    setState(() {
      isFavorite = favoritIds.contains(widget.resep.namaMakanan);
    });
  }

  void _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritIds = prefs.getStringList('favorite_recipes') ?? [];

    if (isFavorite) {
      favoritIds.remove(widget.resep.namaMakanan);
    } else {
      favoritIds.add(widget.resep.namaMakanan);
    }

    await prefs.setStringList('favorite_recipes', favoritIds);

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Detail Resep',
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
            Navigator.pop(context); 
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  widget.resep.image?[0] ?? '',
                  height: 200.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.resep.namaMakanan,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 18.0, color: Colors.grey),
                  const SizedBox(width: 4.0),
                  Text(
                    widget.resep.lokasi.isNotEmpty
                        ? widget.resep.lokasi
                        : "Lokasi tidak diketahui",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.star, size: 18.0, color: Colors.orange),
                  const SizedBox(width: 4.0),
                  Text(
                    '${widget.resep.rateReview.toStringAsFixed(1)} / 5.0',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Divider(thickness: 1, height: 24.0),
              const Text(
                'Bahan: ',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.resep.bahan,
                style: const TextStyle(fontSize: 16.0),
              ),
              const Divider(thickness: 1, height: 24.0),
              const Text(
                'Alat: ',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.resep.alat,
                style: const TextStyle(fontSize: 16.0),
              ),
              const Divider(thickness: 1, height: 24.0),
              const Text(
                'Cara Memasak: ',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.resep.caraMasak,
                style: const TextStyle(fontSize: 16.0),
              ),
              const Divider(thickness: 1, height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
