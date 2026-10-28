import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/custom_item_card.dart';

class ItemDetailScreen extends StatelessWidget {
  final Item item;
  const ItemDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Widget dipakai ulang dengan mode Detail & data berbeda
            CustomItemCard(
              item: item,
              isDetailMode: true,
            ),
            const SizedBox(height: 24),

            // Metadata Diagnostics Title
            Row(
              children: [
                const Icon(Icons.analytics_outlined,
                    color: Color(0xFF38BDF8), size: 20),
                const SizedBox(width: 8),
                Text(
                  'SYSTEM TELEMETRY & SPECS',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Domain Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withAlpha(20)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.developer_mode_rounded,
                      color: Color(0xFF818CF8)),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Target Domain',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.category,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF1F5F9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Deployment Status Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: item.isImportant
                      ? const Color(0xFFF43F5E).withAlpha(100)
                      : Colors.white.withAlpha(20),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    item.isImportant
                        ? Icons.warning_amber_rounded
                        : Icons.verified_rounded,
                    color: item.isImportant
                        ? const Color(0xFFF43F5E)
                        : const Color(0xFF10B981),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Deployment Severity',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.isImportant
                            ? 'Critical Priority / High SLA'
                            : 'Standard Environment',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: item.isImportant
                              ? const Color(0xFFF43F5E)
                              : const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Back Navigation Button
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF38BDF8), width: 1.5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.arrow_back_rounded,
                    color: Color(0xFF38BDF8)),
                label: const Text(
                  'RETURN TO HUB',
                  style: TextStyle(
                    color: Color(0xFF38BDF8),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
