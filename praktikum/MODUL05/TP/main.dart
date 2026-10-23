import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int halaman = 0;
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => halaman = index);
          },
          children: [
            const Center(child: Text('Page 1')),
            Column(
              children: const [
                Text('Teks di paling atas (SafeArea test)'),
                Expanded(child: Center(child: Text('Page 2'))),
              ],
            ),
            const Center(child: Text('Page 3')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: halaman,
        onTap: (index) {
          controller.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Page 3',
          ),
        ],
      ),
    );
  }
}
