
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riwayat TOEFL',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFFF7FF),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Data riwayat tes dibuat menggunakan List of Map.
  // Setiap data memiliki tepat 2 key: tanggal dan nilai.
  static final List<Map<String, String>> riwayatTes = [
    {'tanggal': '02/03/2022', 'nilai': '150'},
    {'tanggal': '01/02/2022', 'nilai': '140'},
    {'tanggal': '12/01/2022', 'nilai': '170'},
    {'tanggal': '11/12/2021', 'nilai': '110'},
    {'tanggal': '10/11/2021', 'nilai': '180'},
    {'tanggal': '09/10/2021', 'nilai': '130'},
    {'tanggal': '02/03/2021', 'nilai': '150'},
    {'tanggal': '01/02/2021', 'nilai': '140'},
    {'tanggal': '12/01/2021', 'nilai': '170'},
    {'tanggal': '11/12/2020', 'nilai': '110'},
    {'tanggal': '10/11/2020', 'nilai': '180'},
    {'tanggal': '09/10/2020', 'nilai': '130'},
    {'tanggal': '02/03/2020', 'nilai': '150'},
    {'tanggal': '01/02/2020', 'nilai': '160'},
    {'tanggal': '12/01/2020', 'nilai': '165'},
    {'tanggal': '11/12/2019', 'nilai': '170'},
    {'tanggal': '10/11/2019', 'nilai': '160'},
    {'tanggal': '09/10/2019', 'nilai': '160'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2196F3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Welcome,',
                          style: TextStyle(
                            color: Color(0xFF9747FF),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '103122400067 - Kevin kendra adi sebastian',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // KARTU STATUS TOEFL
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2196F3),
                      Color(0xFF9C27B0),
                      Color(0xFFD946EF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Status tes TOEFL Anda:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'LULUS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _NilaiTes(jenis: 'Listening', nilai: '80'),
                        _NilaiTes(jenis: 'Structure', nilai: '80'),
                        _NilaiTes(jenis: 'Reading', nilai: '90'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Riwayat Tes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              // LISTVIEW SCROLL INDEPENDEN
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: riwayatTes.length,
                  itemBuilder: (context, index) {
                    final data = riwayatTes[index];

                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFE5DDE8),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Tanggal tes:',
                                  style: TextStyle(
                                    color: Color(0xFF2196F3),
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Nilai: ${data['nilai']}',
                                  style: const TextStyle(
                                    color: Color(0xFF2196F3),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                data['tanggal']!,
                                style: const TextStyle(
                                  color: Color(0xFF2196F3),
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                data['nilai']!,
                                style: const TextStyle(
                                  color: Color(0xFF2196F3),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NilaiTes extends StatelessWidget {
  final String jenis;
  final String nilai;

  const _NilaiTes({
    required this.jenis,
    required this.nilai,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          jenis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        Text(
          nilai,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
