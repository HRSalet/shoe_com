import 'package:flutter/material.dart';
import 'package:sneakers_app/view/payment/payment_screen.dart';

import '../../utils/app_methods.dart';
import '../../utils/constants.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedAddressIndex = 0;
  int selectedDeliveryMethod = 0;

  final deliveryMethods = [
    {
      'title': 'Standard Delivery',
      'duration': '5-7 days',
      'price': '50.00',
      'icon': Icons.local_shipping_outlined,
    },
    {
      'title': 'Express Delivery',
      'duration': '3-4 days',
      'price': '100.00',
      'icon': Icons.delivery_dining_outlined,
    },
  ];

  double shipping() {
    String priceString =
        deliveryMethods[selectedDeliveryMethod]['price'] as String;
    return double.parse(priceString);
  }

  double tax(double subtotal) {
    return subtotal * 0.07;
  }

  Widget _buildStep(int number, String title, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.black : Colors.white,
              border: Border.all(color: isActive ? Colors.black : Colors.grey),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? Colors.black : Colors.grey,
    );
  }

  Widget _buildAddressCard(int index) {
    final isSelected = index == selectedAddressIndex;
    return GestureDetector(
      onTap: () => setState(() => selectedAddressIndex = index),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.black87 : Colors.transparent,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 7, offset: Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            Radio(
              value: index,
              groupValue: selectedAddressIndex,
              onChanged: (value) {
                setState(() {
                  selectedAddressIndex = value as int;
                });
              },
              activeColor: Colors.black,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Dear User",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                      if (index == 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('+1234567890', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Text(
                    'Main street, Apt 4B\n New Delhi, ND 110001\n India',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliverMethodCard(int index, Map<String, dynamic> method) {
    final isSelected = selectedDeliveryMethod == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDeliveryMethod = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.black87 : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            Radio(
              value: index,
              groupValue: selectedDeliveryMethod,
              onChanged: (value) {
                setState(() {
                  selectedDeliveryMethod = value as int;
                });
              },
              activeColor: Colors.black,
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(method['icon'] as IconData, color: Colors.black),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method['title'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    method['duration'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "₹${method['price'] as String}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = AppMethods.sumOfItemsOnBag();
    double shippingCost = shipping();
    double taxAmount = tax(subtotal);
    double total = subtotal + shippingCost + taxAmount;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              foregroundColor: Colors.white,
              pinned: true,
              expandedHeight: 90,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(color: Colors.black),
                child: FlexibleSpaceBar(
                  title: Text(
                    'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        _buildStep(1, 'Shipping', true),
                        _buildStepConnector(true),
                        _buildStep(2, 'Payment', false),
                        _buildStepConnector(false),
                        _buildStep(3, 'Shipping', false),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping Address',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () {},
                              label: Text('Add new'),
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ...List.generate(
                          2,
                          (index) => _buildAddressCard(index),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Method',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        ...List.generate(
                          2,
                          (index) => _buildDeliverMethodCard(
                            index,
                            deliveryMethods[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildSummaryRow("Subtotal", "₹ $subtotal"),
                        _buildSummaryRow("Shipping", "₹ $shippingCost"),
                        _buildSummaryRow(
                          "Tax",
                          "₹ ${taxAmount.toStringAsFixed(2)}",
                        ),
                        Divider(height: 24),
                        _buildSummaryRow(
                          "Total",
                          "₹ ${total.toStringAsFixed(2)}",
                          isTotal: true,
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
        bottomSheet: MaterialButton(
          elevation: 10.0,
          height: 50,
          minWidth: 300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => PaymentScreen(
                      subTotal: subtotal,
                      shippingCost: shippingCost,
                      taxAmount: taxAmount,
                      total: total,
                    ),
              ),
            );
          },
          child: Text(
            "Continue to Payment",
            style: TextStyle(
              color: AppConstantsColor.lightTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
