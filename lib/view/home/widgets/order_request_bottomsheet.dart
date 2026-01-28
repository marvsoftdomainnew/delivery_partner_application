import 'dart:async';
import 'package:fish_delivery_partner_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderRequestBottomsheet extends StatefulWidget {
  final Map<String, dynamic> order;
  final VoidCallback onIgnore;
  final VoidCallback onAccept;

  const OrderRequestBottomsheet({
    super.key,
    required this.order,
    required this.onIgnore,
    required this.onAccept,
  });

  @override
  State<OrderRequestBottomsheet> createState() =>
      _OrderRequestBottomsheetState();
}

class _OrderRequestBottomsheetState extends State<OrderRequestBottomsheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _timerController;

  int seconds = 15;
  Timer? timer;
  bool _isAcceptButtonDisabled = false;
  @override
  void initState() {
    super.initState();

    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..forward();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        widget.onIgnore();
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding; 
    return Padding(
      padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.all(4.w),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                blurRadius: 25,
                color: Colors.black26,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// DRAG INDICATOR
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: AnimatedBuilder(
                          animation: _timerController,
                          builder: (context, child) {
                            return CircularProgressIndicator(
                              value: 1 - _timerController.value,
                              strokeWidth: 2,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation(
                                Colors.orange,
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        "$seconds",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      
              SizedBox(height: 2.h),
      
              /// NEW REQUEST + EARNING
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFF1E6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "NEW REQUEST",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffFF7A00),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "₹${widget.order["earning"]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff16A34A),
                    ),
                  ),
                ],
              ),
      
              SizedBox(height: 1.5.h),
      
              /// STORE NAME
              Text(
                widget.order["shop"],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                widget.order["address"] ?? "",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
      
              SizedBox(height: 2.h),
      
              /// PICKUP & DROP
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: const Color(0xffF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _LocationRow(
                      title: "PICKUP",
                      place: widget.order["pickup"],
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _LocationRow(
                      title: "DROP",
                      place: widget.order["drop"],
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
      
              SizedBox(height: 2.h),
      
              /// ACTION BUTTONS
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onIgnore,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xffCBD5E1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "Ignore",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isAcceptButtonDisabled
                          ? null
                          : () {
                              setState(() {
                                _isAcceptButtonDisabled = true;
                              });
                              widget.onAccept();
                            },
                      // onPressed: widget.onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "Accept Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final String title;
  final String place;
  final Color color;

  const _LocationRow({
    required this.title,
    required this.place,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on, color: color, size: 18),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              place,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
