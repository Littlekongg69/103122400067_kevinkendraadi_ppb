import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView dengan Dialog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Model data
class AppItem {
  final String title;
  final String platform;
  final String languages;
  final Color color;

  const AppItem({
    required this.title,
    required this.platform,
    required this.languages,
    required this.color,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Daftar data
  final List<AppItem> items = const [
    AppItem(
      title: 'Native App',
      platform: 'Android, iOS',
      languages: 'Java, Kotlin, Swift, C#',
      color: Colors.red,
    ),
    AppItem(
      title: 'Hybrid App',
      platform: 'Android, iOS, Web',
      languages: 'Javascript, Dart',
      color: Colors.grey,
    ),
  ];

  // Fungsi menampilkan dialog
  void _showDetailDialog(BuildContext context, AppItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detail'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(item.platform, style: const TextStyle(fontSize: 12)),
              Text(item.languages, style: const TextStyle(fontSize: 12)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ListView dengan Dialog',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundColor: item.color),
              title: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              subtitle: Text(
                item.platform,
                style: const TextStyle(fontSize: 11),
              ),
              onTap: () => _showDetailDialog(context, item),
            ),
          );
        },
      ),
    );
  }
}