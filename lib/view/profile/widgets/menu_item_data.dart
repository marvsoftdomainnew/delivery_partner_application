import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';

class MenuItemData {
  final IconData icon;
  final String title;

  const MenuItemData({required this.icon, required this.title});
}

class MenuTile extends StatefulWidget {
  final MenuItemData item;

  const MenuTile({super.key, required this.item});

  @override
  State<MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: EdgeInsets.only(top: 1.h),
        padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: _isPressed ? const Color(0xFFF1F5F9) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(widget.item.icon, color: const Color(0xFF64748B), size: 22),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                widget.item.title,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF334155),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------
// Menu Section
// ---------------------------
class MenuSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<MenuItemData> items;

  const MenuSection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              SizedBox(width: 3.w),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          ...items.map((item) => MenuTile(item: item)),
        ],
      ),
    );
  }
}

Widget earningCardGlass({
  required String amount,
  required String label,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.9), Colors.white.withOpacity(0.7)],
      ),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.1),
          blurRadius: 32,
          offset: const Offset(0, 12),
          spreadRadius: -8,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color, color.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 4),

            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          amount,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            letterSpacing: -0.8,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------
// Earning Card Widget
// ---------------------------
// Widget earningCard({
//   required String amount,
//   required String label,
//   required IconData icon,
//   required Color color,
// }) {
//   return Container(
//     padding: EdgeInsets.all(4.w),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(18),
//       border: Border.all(color: color.withOpacity(0.2), width: 1.5),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.04),
//           blurRadius: 12,
//           offset: const Offset(0, 2),
//         ),
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: color, size: 20),
//         ),
//         SizedBox(height: 1.5.h),
//         Text(
//           amount,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w800,
//             color: color,
//           ),
//         ),
//         SizedBox(height: 0.3.h),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13.sp,
//             color: const Color(0xFF64748B),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     ),
//   );
// }
