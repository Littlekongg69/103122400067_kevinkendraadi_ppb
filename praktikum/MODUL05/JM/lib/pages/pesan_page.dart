import 'package:flutter/material.dart';

class PesanPage extends StatelessWidget {
  const PesanPage({super.key});

  // List<Map<String, dynamic>> dengan 4 key-value pair per elemen:
  // 3 String (nama, pesan, waktu) dan 1 warna.
  static final List<Map<String, dynamic>> daftarPesan = [
    {
      'nama': 'Vio',
      'pesan': 'Hari Kamis tuh selalu punya vibe yang beda ya',
      'waktu': '07:45 AM',
      'warna': Colors.pink,
    },
    {
      'nama': 'Tila',
      'pesan': 'Lucu ya kamu',
      'waktu': '08:30 AM',
      'warna': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE3F2FD), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Pesan',
                style: TextStyle(
                  color: Color(0xFF448AFF),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: daftarPesan.length,
                itemBuilder: (context, index) {
                  final item = daftarPesan[index];
                  return Card(
                    elevation: 2,
                    color: const Color(0xFFF6F0F8),
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: item['warna'] as Color,
                        child: const Icon(Icons.message,
                            color: Colors.white, size: 18),
                      ),
                      title: Text(
                        item['nama'] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      subtitle: Text(
                        item['pesan'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: Text(
                        item['waktu'] as String,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
