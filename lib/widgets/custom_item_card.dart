import 'package:flutter/material.dart';
import '../models/item.dart';

class CustomItemCard extends StatelessWidget {
  final Item item;
  final bool isDetailMode;

  const CustomItemCard({
    super.key,
    required this.item,
    this.isDetailMode = false,
  });

  Map<String, dynamic> _getCategoryStyle(String category) {
    switch (category) {
      case 'AI & Data Science':
        return {
          'color': const Color(0xFF06B6D4), // Neon Cyan
          'icon': Icons.psychology_outlined,
          'badge': 'AI.CORE',
        };
      case 'Cloud & DevOps':
        return {
          'color': const Color(0xFF818CF8), // Cyber Indigo
          'icon': Icons.cloud_done_outlined,
          'badge': 'CLOUD.OPS',
        };
      case 'Cyber Security':
        return {
          'color': const Color(0xFFF43F5E), // Neon Rose
          'icon': Icons.security_outlined,
          'badge': 'SEC.GUARD',
        };
      case 'Mobile & IoT':
        return {
          'color': const Color(0xFF10B981), // Emerald Matrix
          'icon': Icons.devices_other_outlined,
          'badge': 'SYS.MOBILE',
        };
      default:
        return {
          'color': const Color(0xFFA855F7), // Purple Tech
          'icon': Icons.memory_outlined,
          'badge': 'TECH.CORE',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _getCategoryStyle(item.category);
    final Color accentColor = style['color'] as Color;
    final IconData iconData = style['icon'] as IconData;
    final String badgeText = style['badge'] as String;

    return Container(
      margin: isDetailMode
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E293B),
            item.isImportant
                ? const Color(0xFF334155).withAlpha(200)
                : const Color(0xFF0F172A),
          ],
        ),
        border: Border.all(
          color: item.isImportant
              ? const Color(0xFF38BDF8).withAlpha(160)
              : Colors.white.withAlpha(20),
          width: item.isImportant ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: item.isImportant
                ? const Color(0xFF38BDF8).withAlpha(35)
                : Colors.black.withAlpha(50),
            blurRadius: item.isImportant ? 16 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Tech Icon Container with Glow
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: accentColor.withAlpha(80)),
                  ),
                  child: Icon(iconData, color: accentColor, size: 24),
                ),
                const SizedBox(width: 14),
                // Title and Badge
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: accentColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(6),
                              border:
                                  Border.all(color: accentColor.withAlpha(60)),
                            ),
                            child: Text(
                              badgeText,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: accentColor,
                              ),
                            ),
                          ),
                          if (item.isImportant) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF43F5E).withAlpha(30),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.bolt,
                                      size: 11, color: Color(0xFFF43F5E)),
                                  SizedBox(width: 2),
                                  Text(
                                    'CRITICAL',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFFF43F5E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isDetailMode ? 20 : 16,
                          letterSpacing: 0.2,
                          color: const Color(0xFFF8FAFC),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isDetailMode)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(10),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              item.description,
              maxLines: isDetailMode ? 10 : 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13.5,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
