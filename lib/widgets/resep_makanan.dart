import 'package:flutter/material.dart';
import 'package:resep_mobile/model/resep_model.dart';

class ResepMakanan extends StatelessWidget {
  final MenuMakanan menuMakanan;

  const ResepMakanan({Key? key, required this.menuMakanan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                menuMakanan.image![0],
                height: 120.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                menuMakanan.namaMakanan,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                menuMakanan.lokasi,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 16.0),
                  const SizedBox(width: 4.0),
                  Text(
                    menuMakanan.rateReview.toString(),
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
