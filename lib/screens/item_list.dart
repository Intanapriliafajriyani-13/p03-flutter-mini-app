import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/custom_item_card.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  // Data in-memory bernuansa Modern Tech
  final List<Item> _items = [
    Item(
      title: 'Neural Network Optimizer',
      description:
          'Mengimplementasikan pipeline transformer dan tuning hyperparameter model LLM secara otomatis.',
      category: 'AI & Data Science',
      isImportant: true,
    ),
    Item(
      title: 'Kubernetes Cluster Migration',
      description:
          'Otomatisasi deployment microservices dengan Helm chart dan monitoring Prometheus di multi-region cloud.',
      category: 'Cloud & DevOps',
      isImportant: true,
    ),
    Item(
      title: 'Zero-Trust Protocol Audit',
      description:
          'Audit autentikasi biometric token JWT dan evaluasi kerentanan endpoint REST API backend.',
      category: 'Cyber Security',
      isImportant: false,
    ),
    Item(
      title: 'Flutter IoT Realtime Telemetry',
      description:
          'Streaming sensor hardware MQTT ke dashboard mobile dengan frame rate stabil 60 FPS.',
      category: 'Mobile & IoT',
      isImportant: false,
    ),
  ];

  // Navigasi ke AddItemScreen & menangani kembalian data via setState
  Future<void> _navigateAndAddItem() async {
    final newItem = await Navigator.pushNamed(context, '/add');
    if (newItem != null && newItem is Item) {
      setState(() {
        _items.insert(0, newItem); // Tambah di paling atas
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF1E293B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFF38BDF8), width: 1),
            ),
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Color(0xFF38BDF8)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Modul "${newItem.title}" tersinkronisasi!',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF38BDF8).withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.terminal_rounded,
                  color: Color(0xFF38BDF8), size: 20),
            ),
            const SizedBox(width: 10),
            const Text('DevSync // Tech Workspace'),
          ],
        ),
      ),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.developer_board_off,
                      size: 64, color: Colors.grey.shade600),
                  const SizedBox(height: 16),
                  const Text(
                    'Tidak ada modul aktif.\nTekan tombol + untuk membuat konfigurasi baru.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _items.length,
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemBuilder: (context, index) {
                final item = _items[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: {'item': item},
                    );
                  },
                  child: CustomItemCard(item: item),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateAndAddItem,
        backgroundColor: const Color(0xFF38BDF8),
        foregroundColor: const Color(0xFF0F172A),
        elevation: 6,
        icon: const Icon(Icons.add_rounded, size: 22),
        label: const Text(
          'NEW MODULE',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
