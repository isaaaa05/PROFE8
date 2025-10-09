import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import '../models/reservation.dart';
import '../widgets/payment_summary_card.dart';

class PaymentScreen extends StatefulWidget {
  final Reservation reservation;
  final VoidCallback? onPaymentSuccess;

  const PaymentScreen({
    super.key,
    required this.reservation,
    this.onPaymentSuccess,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _referenceNumberController = TextEditingController();

  String _selectedPaymentMethod = 'Credit Card';
  final List<String> _paymentMethods = [
    'Credit Card',
    'Debit Card',
    'PayPal',
    'GCash',
    'Maya'
  ];

  String _generatedReferenceNumber = '';

  @override
  void initState() {
    super.initState();
    _generateReferenceNumber();
  }

  void _generateReferenceNumber() {
    final random = Random();
    _generatedReferenceNumber =
        'REF${random.nextInt(900000) + 100000}${random.nextInt(9000) + 1000}';
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _referenceNumberController.dispose();
    super.dispose();
  }

  bool get _isEWallet {
    return _selectedPaymentMethod == 'GCash' ||
        _selectedPaymentMethod == 'PayPal' ||
        _selectedPaymentMethod == 'Maya';
  }

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      widget.onPaymentSuccess?.call();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Payment Successful!',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Your reservation has been confirmed. You will receive a confirmation email shortly.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'Done',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF2196F3),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticketPrice = 500.0;
    final totalAmount = ticketPrice * widget.reservation.ticketCount;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : null,
          ),
        ),
        backgroundColor:
            isDark ? const Color(0xFF2C2C2C) : const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Complete Your Payment',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 24),
            PaymentSummaryCard(
              reservation: widget.reservation,
              ticketPrice: ticketPrice,
              totalAmount: totalAmount,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedPaymentMethod,
                    dropdownColor:
                        isDark ? const Color(0xFF2C2C2C) : Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Payment Method',
                      labelStyle: GoogleFonts.poppins(
                        color: isDark ? const Color(0xFFE0E0E0) : null,
                      ),
                      prefixIcon: Icon(
                        Icons.payment,
                        color: isDark ? const Color(0xFF64B5F6) : null,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor:
                          isDark ? const Color(0xFF2C2C2C) : Colors.white,
                    ),
                    items: _paymentMethods.map((String method) {
                      return DropdownMenuItem<String>(
                        value: method,
                        child: Text(
                          method,
                          style: GoogleFonts.poppins(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPaymentMethod = newValue!;
                        if (_isEWallet) {
                          _generateReferenceNumber();
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (_isEWallet) ...[
                    // E-Wallet payment (GCash, PayPal, Maya)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF64B5F6),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.qr_code_2,
                            size: 120,
                            color: const Color(0xFF64B5F6),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Scan QR Code to Pay',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Or use the reference number below',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isDark
                                  ? const Color(0xFFE0E0E0)
                                  : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1E1E1E)
                                  : const Color(0xFFF5F5DC),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Reference Number',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: isDark
                                        ? const Color(0xFFE0E0E0)
                                        : Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _generatedReferenceNumber,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF64B5F6),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Amount to Pay: ₱${totalAmount.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64B5F6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _referenceNumberController,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Enter Reference Number After Payment',
                        labelStyle: GoogleFonts.poppins(
                          color: isDark ? const Color(0xFFE0E0E0) : null,
                        ),
                        prefixIcon: Icon(
                          Icons.confirmation_number,
                          color: isDark ? const Color(0xFF64B5F6) : null,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                            isDark ? const Color(0xFF2C2C2C) : Colors.white,
                        hintText:
                            'Enter the reference number from your receipt',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? const Color(0xFF9E9E9E) : null,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter reference number';
                        }
                        return null;
                      },
                    ),
                  ] else ...[
                    // Card payment fields with dark mode support
                    TextFormField(
                      controller: _cardNumberController,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        labelStyle: GoogleFonts.poppins(
                          color: isDark ? const Color(0xFFE0E0E0) : null,
                        ),
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: isDark ? const Color(0xFF64B5F6) : null,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                            isDark ? const Color(0xFF2C2C2C) : Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter card number';
                        }
                        if (value.length < 16) {
                          return 'Card number must be 16 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cardHolderController,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Card Holder Name',
                        labelStyle: GoogleFonts.poppins(
                          color: isDark ? const Color(0xFFE0E0E0) : null,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: isDark ? const Color(0xFF64B5F6) : null,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                            isDark ? const Color(0xFF2C2C2C) : Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter card holder name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _expiryController,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Expiry (MM/YY)',
                              labelStyle: GoogleFonts.poppins(
                                color: isDark ? const Color(0xFFE0E0E0) : null,
                              ),
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: isDark ? const Color(0xFF64B5F6) : null,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? const Color(0xFF2C2C2C)
                                  : Colors.white,
                            ),
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: 'CVV',
                              labelStyle: GoogleFonts.poppins(
                                color: isDark ? const Color(0xFFE0E0E0) : null,
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: isDark ? const Color(0xFF64B5F6) : null,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? const Color(0xFF2C2C2C)
                                  : Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              if (value.length < 3) {
                                return 'Invalid';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF64B5F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _isEWallet
                          ? 'Confirm Payment'
                          : 'Pay ₱${totalAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
