import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sneakers_app/view/confirm_order/order_confirm_screen.dart';

import '../../utils/constants.dart';

class PaymentScreen extends StatefulWidget {
  final double subTotal;
  final double shippingCost;
  final double taxAmount;
  final double total;

  const PaymentScreen({
    Key? key,
    required this.subTotal,
    required this.shippingCost,
    required this.taxAmount,
    required this.total,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  int _selectedCard = 0;

  final paymentMethods = [
    {'title': 'Credit/Debit Card', 'icon': Icons.credit_card},
    {'title': 'PayPal', 'icon': Icons.paypal},
    {'title': 'Apple Pay', 'icon': Icons.apple},
    {'title': 'Google Pay', 'icon': Icons.g_mobiledata},
  ];

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
          const SizedBox(height: 4),
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

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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

  Widget _buildPaymentMethodsCard(int index, Map<String, dynamic> method) {
    final isSelected = _selectedPaymentMethod == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = index;
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
            width: 2,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Radio(
              value: index,
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value as int;
                });
              },
              activeColor: Colors.black,
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                method['icon'] as IconData,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(width: 16),
            Text(
              method['title'] as String,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedCards() {
    if (_selectedPaymentMethod != 0) return SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.saved_cards,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                label: Text(AppLocalizations.of(context)!.add_new),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) => _buildCreditCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCode() {
    if (_selectedPaymentMethod == 0) return SizedBox.shrink();

    String paymentTitle =
        paymentMethods[_selectedPaymentMethod]['title'] as String;
    String qrData =
        'Payment of ₹ ${widget.total.toStringAsFixed(2)} via $paymentTitle is successful.';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.scan_to_pay,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCard(int index) {
    final isSelected = _selectedCard == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCard = index;
        });
      },
      child: Container(
        width: 300,
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Credit Card",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.credit_card, size: 30, color: Colors.white),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "**** **** **** 1234",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CARD HOLDER',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        Text(
                          'Dear User',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EXPIRES',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        Text(
                          '12/25',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                decoration: const BoxDecoration(color: Colors.black),
                child: FlexibleSpaceBar(
                  title: Text(
                    AppLocalizations.of(context)!.payment,
                    style: const TextStyle(
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
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        _buildStep(
                          1,
                          AppLocalizations.of(context)!.shipping,
                          true,
                        ),
                        _buildStepConnector(true),
                        _buildStep(
                          2,
                          AppLocalizations.of(context)!.payment,
                          true,
                        ),
                        _buildStepConnector(true),
                        _buildStep(
                          3,
                          AppLocalizations.of(context)!.confirm,
                          false,
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
                          AppLocalizations.of(context)!.payment_methods,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        ...List.generate(
                          paymentMethods.length,
                          (index) => _buildPaymentMethodsCard(
                            index,
                            paymentMethods[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSavedCards(),
                  _buildQRCode(),
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
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
                          AppLocalizations.of(context)!.order_summary,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          AppLocalizations.of(context)!.subtotal,
                          "₹ ${widget.subTotal.toStringAsFixed(2)}",
                        ),
                        _buildSummaryRow(
                          AppLocalizations.of(context)!.shipping,
                          "₹ ${widget.shippingCost.toStringAsFixed(2)}",
                        ),
                        _buildSummaryRow(
                          AppLocalizations.of(context)!.tax,
                          "₹ ${widget.taxAmount.toStringAsFixed(2)}",
                        ),
                        const Divider(height: 24),
                        _buildSummaryRow(
                          AppLocalizations.of(context)!.total,
                          "₹ ${widget.total.toStringAsFixed(2)}",
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
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
            // Continue to next step
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => OrderConfirmScreen(
                      subTotal: widget.subTotal,
                      total: widget.total,
                      taxAmount: widget.taxAmount,
                      shippingCost: widget.shippingCost,
                    ),
              ),
            );
          },
          child: Text(
            AppLocalizations.of(context)!.confirm_order,
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
