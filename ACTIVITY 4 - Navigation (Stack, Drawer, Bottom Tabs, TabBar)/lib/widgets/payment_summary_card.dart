import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/reservation.dart';

class PaymentSummaryCard extends StatelessWidget {
  final Reservation reservation;
  final double ticketPrice;
  final double totalAmount;

  const PaymentSummaryCard({
    super.key,
    required this.reservation,
    required this.ticketPrice,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reservation Summary',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
            const Divider(height: 24),
            _buildSummaryRow('Event', reservation.eventName),
            _buildSummaryRow('Type', reservation.eventType),
            _buildSummaryRow('Date',
                '${reservation.date.day}/${reservation.date.month}/${reservation.date.year}'),
            _buildSummaryRow('Time', reservation.time.format(context)),
            _buildSummaryRow('Tickets', '${reservation.ticketCount}'),
            _buildSummaryRow(
                'Price per ticket', '₱${ticketPrice.toStringAsFixed(2)}'),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '₱${totalAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2196F3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
