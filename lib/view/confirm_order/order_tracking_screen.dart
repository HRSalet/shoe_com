import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:sneakers_app/view/navigator.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  Widget _buildTimelineItem({
    required String status,
    required String date,
    required String description,
    required bool isCompleted,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Column(
              children: [
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 30,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? Colors.black : Colors.white,
                    border: Border.all(
                      width: 2,
                      color: isCompleted ? Colors.black : Colors.grey,
                    ),
                  ),
                  child:
                      isCompleted
                          ? Icon(Icons.check, size: 16, color: Colors.white)
                          : null,
                ),
                if (isFirst)
                  Container(
                    width: 2,
                    height: 50,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 30,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? Colors.green : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String estimatedDate = DateFormat.yMMMd().format(
      DateTime.now().add(Duration(days: 7)),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.white,
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: FlexibleSpaceBar(
                title: Text(
                  AppLocalizations.of(context)!.track_order,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.estimated_delivery,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        estimatedDate,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.in_transit,
                          style: TextStyle(
                            color: Colors.orangeAccent[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildTimelineItem(
                        status: AppLocalizations.of(context)!.order_placed,
                        date:
                            DateFormat.yMMMd().format(DateTime.now()) +
                            " " +
                            DateFormat.jm().format(DateTime.now()),
                        description:
                            AppLocalizations.of(context)!.order_placed_msg,
                        isCompleted: true,
                        isFirst: true,
                      ),
                      _buildTimelineItem(
                        status: AppLocalizations.of(context)!.order_processed,
                        date: DateFormat.yMMMd().format(
                          DateTime.now().add(Duration(days: 1)),
                        ),
                        description:
                            AppLocalizations.of(context)!.order_processed_msg,
                        isCompleted: true,
                      ),
                      _buildTimelineItem(
                        status: AppLocalizations.of(context)!.in_transit,
                        date: DateFormat.yMMMd().format(
                          DateTime.now().add(Duration(days: 2)),
                        ),
                        description:
                            AppLocalizations.of(context)!.order_transit_msg,
                        isCompleted: true,
                      ),
                      _buildTimelineItem(
                        status: AppLocalizations.of(context)!.out_for_delivery,
                        date:
                            "Expected " +
                            DateFormat.yMMMd().format(
                              DateTime.now().add(Duration(days: 4)),
                            ),
                        description:
                            AppLocalizations.of(
                              context,
                            )!.order_out_for_delivery_msg,
                        isCompleted: false,
                      ),
                      _buildTimelineItem(
                        status: AppLocalizations.of(context)!.delivered,
                        date:
                            "Expected " +
                            DateFormat.yMMMd().format(
                              DateTime.now().add(Duration(days: 7)),
                            ),
                        description:
                            AppLocalizations.of(context)!.order_delivered_msg,
                        isCompleted: false,
                        isLast: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.delivery_details,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.local_shipping_outlined,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.tracking_number,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "TRK13579",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.copy, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.delivery_address,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Main street, Apt 4B\nNew Delhi, ND 110001\nIndia",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.copy, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainNavigator()),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.thank_you,
                    style: TextStyle(fontSize: 20),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
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
