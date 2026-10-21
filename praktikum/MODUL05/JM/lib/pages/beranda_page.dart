import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const blue = Color(0xFF448AFF);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF90CAF9), Color(0xFFBBDEFB)],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Judul di bagian atas
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Beranda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Kartu putih di bagian bawah
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: size.height * 0.4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Stack(
                  children: const [
                    Align(
                      alignment: Alignment(0, -0.3),
                      child: Text(
                        'PPB MODUL 5!',
                        style: TextStyle(
                          color: blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-1, 0.35),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Random Text 1',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(1, 0.35),
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          'Random Text 2',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.85),
                      child: Text(
                        'Hari ini.',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
