
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class TechData {
  final String name;
  final String platform;
  final String language;
  final DateTime date;
  final String colorName;

  TechData({
    required this.name,
    required this.platform,
    required this.language,
    required this.date,
    required this.colorName,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jurnal ListView + FAB',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF7FF),
      ),
      home: const TechListPage(),
    );
  }
}

class TechListPage extends StatefulWidget {
  const TechListPage({super.key});

  @override
  State<TechListPage> createState() => _TechListPageState();
}

class _TechListPageState extends State<TechListPage> {
  final List<TechData> techList = [];

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Color getColor(String colorName) {
    switch (colorName) {
      case 'Blue':
        return Colors.blue;
      case 'Red':
        return Colors.red;
      case 'Green':
        return Colors.green;
      case 'Purple':
        return Colors.purple;
      case 'Orange':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  void showAddDialog() {
    final nameController = TextEditingController();
    final platformController = TextEditingController();
    final languageController = TextEditingController();

    DateTime? selectedDate;
    String selectedColor = 'Blue';
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Add New Tech',
                style: TextStyle(fontSize: 20),
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: SizedBox(
                    width: 320,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Tech Name',
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Nama teknologi wajib diisi';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: platformController,
                          decoration: const InputDecoration(
                            labelText: 'Platform',
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Platform wajib diisi';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: languageController,
                          decoration: const InputDecoration(
                            labelText: 'Lang',
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Bahasa wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Date Picker
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                selectedDate == null
                                    ? 'No date selected'
                                    : formatDate(selectedDate!),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final picked =
                                    await showDatePicker(
                                  context: dialogContext,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );

                                if (picked != null) {
                                  setDialogState(() {
                                    selectedDate = picked;
                                  });
                                }
                              },
                              child: const Text('Select Date'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Dropdown warna
                        DropdownButtonFormField<String>(
                          value: selectedColor,
                          decoration: const InputDecoration(
                            labelText: 'Choose Color',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Blue',
                              child: Text('Blue'),
                            ),
                            DropdownMenuItem(
                              value: 'Red',
                              child: Text('Red'),
                            ),
                            DropdownMenuItem(
                              value: 'Green',
                              child: Text('Green'),
                            ),
                            DropdownMenuItem(
                              value: 'Purple',
                              child: Text('Purple'),
                            ),
                            DropdownMenuItem(
                              value: 'Orange',
                              child: Text('Orange'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() {
                                selectedColor = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    if (selectedDate == null) {
                      ScaffoldMessenger.of(this.context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Silakan pilih tanggal terlebih dahulu',
                            ),
                          ),
                        );
                      return;
                    }

                    setState(() {
                      techList.add(
                        TechData(
                          name: nameController.text.trim(),
                          platform: platformController.text.trim(),
                          language: languageController.text.trim(),
                          date: selectedDate!,
                          colorName: selectedColor,
                        ),
                      );
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Data berhasil ditambahkan'),
                        ),
                      );
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      nameController.dispose();
      platformController.dispose();
      languageController.dispose();
    });
  }

  void showAddSnackBar() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('FAB Clicked'),
          action: SnackBarAction(
            label: 'Add',
            onPressed: showAddDialog,
          ),
          duration: const Duration(seconds: 4),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jurnal ListView + FAB',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // Menampilkan data menggunakan ListView
      body: techList.isEmpty
          ? const SizedBox.expand()
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: techList.length,
              itemBuilder: (context, index) {
                final tech = techList[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: getColor(tech.colorName),
                    ),
                    title: Text(tech.name),
                    subtitle: Text(
                      '${tech.platform} - ${tech.language}\n'
                      'Date: ${formatDate(tech.date)}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: showAddSnackBar,
        tooltip: 'Add Technology',
        child: const Icon(Icons.add),
      ),
    );
  }
}
