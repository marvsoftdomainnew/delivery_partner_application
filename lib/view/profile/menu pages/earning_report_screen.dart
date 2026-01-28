import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';

class EarningsStats {
  final int total;
  final double completed;
  final double pending;
  final double cancelled;
  final int orders;
  final int avg;
  final int completedOrders;

  const EarningsStats({
    required this.total,
    required this.completed,
    required this.pending,
    required this.cancelled,
    required this.orders,
    required this.avg,
    required this.completedOrders,
  });
}

class TransactionItem {
  final String id;
  final String date;
  final int amount;
  final bool isCredit;

  const TransactionItem({
    required this.id,
    required this.date,
    required this.amount,
    this.isCredit = true,
  });
}

class EarningsReportScreen extends StatefulWidget {
  const EarningsReportScreen({super.key});

  @override
  State<EarningsReportScreen> createState() => _EarningsReportScreenState();
}

class _EarningsReportScreenState extends State<EarningsReportScreen> {
  String selectedFilter = 'Week';

  static const Map<String, EarningsStats> _earningsData = {
    'Day': EarningsStats(
      total: 1250,
      completed: 60.0,
      pending: 25.0,
      cancelled: 10.0,
      orders: 18,
      avg: 69,
      completedOrders: 15,
    ),
    'Week': EarningsStats(
      total: 18450,
      completed: 45.0,
      pending: 30.0,
      cancelled: 15.0,
      orders: 124,
      avg: 149,
      completedOrders: 118,
    ),
    'Month': EarningsStats(
      total: 72500,
      completed: 55.0,
      pending: 20.0,
      cancelled: 15.0,
      orders: 560,
      avg: 129,
      completedOrders: 530,
    ),
    'Year': EarningsStats(
      total: 865000,
      completed: 65.0,
      pending: 15.0,
      cancelled: 10.0,
      orders: 6820,
      avg: 135,
      completedOrders: 6500,
    ),
  };

  EarningsStats get currentStats => _earningsData[selectedFilter]!;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterSegmentedButton(
                selected: selectedFilter,
                onChanged: (value) => setState(() => selectedFilter = value),
              ),
              const SizedBox(height: 24),
              TotalEarningsCard(stats: currentStats, filter: selectedFilter),
              const SizedBox(height: 20),
              EarningsChartCard(stats: currentStats, filter: selectedFilter),
              const SizedBox(height: 20),
              SummaryCardsRow(stats: currentStats),
              // const SizedBox(height: 20),
              // DateRangeCard(filter: selectedFilter),
              const SizedBox(height: 20),
              const TransactionsList(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "Earnings Report",
        style: GoogleFonts.poppins(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.primary,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}

// ==================== FILTER BUTTON ====================

class FilterSegmentedButton extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const FilterSegmentedButton({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: ['Day', 'Week', 'Month', 'Year']
            .map(
              (filter) => Expanded(
                child: _FilterOption(
                  label: filter,
                  isSelected: selected == filter,
                  onTap: () => onChanged(filter),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}

class TotalEarningsCard extends StatelessWidget {
  final EarningsStats stats;
  final String filter;

  const TotalEarningsCard({
    super.key,
    required this.stats,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFA855F7)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Earnings",
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Text(
                "₹${_formatCurrency(stats.total)}",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      color: Color(0xFF10B981),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "+12.5%",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF10B981),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "vs last $filter",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    if (amount >= 100000) {
      return "${(amount / 1000).toStringAsFixed(0)}k";
    }
    return amount.toString();
  }
}

// ==================== EARNINGS CHART CARD ====================

class EarningsChartCard extends StatelessWidget {
  final EarningsStats stats;
  final String filter;

  const EarningsChartCard({
    super.key,
    required this.stats,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Distribution",
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 45,
                        sectionsSpace: 2,
                        sections: _buildPieSections(),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(flex: 3, child: _buildLegend()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieSections() {
    final sections = [
      (stats.completed, const Color(0xFF6366F1), 'Completed'),
      (stats.pending, const Color(0xFF10B981), 'Pending'),
      (stats.cancelled, const Color(0xFFF59E0B), 'Cancelled'),
    ];

    return sections
        .map(
          (data) => PieChartSectionData(
            value: data.$1,
            color: data.$2,
            radius: 50,
            title: "${data.$1.toStringAsFixed(0)}%",
            titleStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            titlePositionPercentageOffset: 0.55,
          ),
        )
        .toList();
  }

  Widget _buildLegend() {
    final items = [
      (const Color(0xFF6366F1), 'Completed', stats.completed),
      (const Color(0xFF10B981), 'Pending', stats.pending),
      (const Color(0xFFF59E0B), 'Cancelled', stats.cancelled),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Container(
                    width: 14,
                    height: 24,
                    decoration: BoxDecoration(
                      color: item.$1,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$2,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          "${item.$3.toStringAsFixed(0)}%",
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class SummaryCardsRow extends StatelessWidget {
  final EarningsStats stats;

  const SummaryCardsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final cards = [
      _SummaryCardData(
        title: "Orders",
        value: stats.orders.toString(),
        icon: Icons.shopping_bag_outlined,
        color: const Color(0xFF6366F1),
        bgColor: const Color(0xFFEEF2FF),
      ),
      _SummaryCardData(
        title: "Avg/Order",
        value: "₹${stats.avg}",
        icon: Icons.trending_up,
        color: const Color(0xFF10B981),
        bgColor: const Color(0xFFECFDF5),
      ),
      _SummaryCardData(
        title: "Completed",
        value: stats.completedOrders.toString(),
        icon: Icons.check_circle_outline,
        color: const Color(0xFF8B5CF6),
        bgColor: const Color(0xFFF5F3FF),
      ),
    ];

    return Row(
      children: cards
          .map(
            (data) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _SummaryCard(data: data),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SummaryCardData {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color bgColor;

  const _SummaryCardData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}

class _SummaryCard extends StatelessWidget {
  final _SummaryCardData data;

  const _SummaryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: data.bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: data.color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            data.value,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.title,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== DATE RANGE CARD ====================

// class DateRangeCard extends StatelessWidget {
//   final String filter;

//   const DateRangeCard({super.key, required this.filter});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFEEF2FF),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.calendar_today_outlined,
//               color: Color(0xFF6366F1),
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Text(
//               "Range based on $filter",
//               style: GoogleFonts.poppins(
//                 fontSize: 13.sp,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFF1E293B),
//               ),
//             ),
//           ),
//           Icon(
//             Icons.chevron_right,
//             color: const Color(0xFF64748B).withOpacity(0.5),
//           ),
//         ],
//       ),
//     );
//   }
// }

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  static const _mockTransactions = [
    TransactionItem(id: '121', date: '26 Jan 2026', amount: 320),
    TransactionItem(id: '122', date: '26 Jan 2026', amount: 450),
    TransactionItem(id: '123', date: '25 Jan 2026', amount: 280),
    TransactionItem(id: '124', date: '25 Jan 2026', amount: 620),
    TransactionItem(id: '125', date: '24 Jan 2026', amount: 390),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            "Recent Transactions",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: const Color(0xFF1E293B),
            ),
          ),
        ),
        ..._mockTransactions.map(
          (transaction) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _TransactionTile(transaction: transaction),
          ),
        ),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final TransactionItem transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_downward_rounded,
              color: Color(0xFF10B981),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order #${transaction.id}",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.date,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "+ ₹${transaction.amount}",
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              color: AppColors.textGreen,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
