import 'package:flutter/material.dart';
import '../models/item.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Masukan Jenis 2: Dropdown Kategori Beraroma Tech
  String? _selectedCategory;
  final List<String> _categories = [
    'AI & Data Science',
    'Cloud & DevOps',
    'Cyber Security',
    'Mobile & IoT',
  ];

  // Masukan Jenis 3: Switch Status Prioritas
  bool _isImportant = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveItem() {
    if (_formKey.currentState?.validate() ?? false) {
      final newItem = Item(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory!,
        isImportant: _isImportant,
      );

      // Navigasi dua arah dengan mengirim data baru ke pemanggil
      Navigator.pop(context, newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deploy New Module'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF38BDF8).withAlpha(40)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.hub_outlined, color: Color(0xFF38BDF8), size: 28),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Configuration Parameters',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFFF1F5F9),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Isi parameter modul sebelum di-deploy ke sistem.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Masukan Jenis 1: Module Name
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Module Identifier / Name *',
                  hintText: 'e.g. Distributed Consensus Engine',
                  prefixIcon: Icon(Icons.code_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Identifier modul tidak boleh kosong';
                  }
                  if (value.trim().length < 3) {
                    return 'Minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Masukan Jenis 2: Dropdown Category
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                dropdownColor: const Color(0xFF1E293B),
                style: const TextStyle(color: Colors.white, fontSize: 15),
                decoration: const InputDecoration(
                  labelText: 'Architecture Domain *',
                  prefixIcon: Icon(Icons.lan_rounded),
                ),
                hint: const Text(
                  'Select Tech Domain',
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedCategory = val;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silakan tentukan architecture domain';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Masukan Jenis 1 (Multiline): Module Specifications
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Technical Specification *',
                  hintText: 'Tuliskan fungsionalitas dan stack teknologi...',
                  prefixIcon: Icon(Icons.description_outlined),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Spesifikasi teknis tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Masukan Jenis 3: SwitchListTile
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _isImportant
                        ? const Color(0xFFF43F5E).withAlpha(120)
                        : Colors.white.withAlpha(20),
                  ),
                ),
                child: SwitchListTile(
                  activeThumbColor: const Color(0xFF38BDF8),
                  title: const Text(
                    'High Priority / Production Ready',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF1F5F9),
                    ),
                  ),
                  subtitle: const Text(
                    'Aktifkan flag critical untuk sistem utama',
                    style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                  value: _isImportant,
                  onChanged: (bool value) {
                    setState(() {
                      _isImportant = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Tombol Deploy Modern
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _saveItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38BDF8),
                    foregroundColor: const Color(0xFF0F172A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                  icon: const Icon(Icons.rocket_launch_rounded, size: 20),
                  label: const Text(
                    'DEPLOY MODULE',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
