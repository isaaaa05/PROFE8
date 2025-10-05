import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/reservation.dart';

class ReservationCard extends StatelessWidget {
  final Reservation reservation;

  const ReservationCard({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.confirmation_number,
                  color: const Color(0xFF2196F3),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    reservation.eventName,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2196F3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.category, 'Type', reservation.eventType),
            _buildInfoRow(Icons.person, 'Username', reservation.username),
            _buildInfoRow(Icons.confirmation_number_outlined, 'Tickets',
                '${reservation.ticketCount}'),
            _buildInfoRow(
              Icons.calendar_today,
              'Date',
              '${reservation.date.day}/${reservation.date.month}/${reservation.date.year}',
            ),
            _buildInfoRow(
              Icons.access_time,
              'Time',
              reservation.time.format(context),
            ),
            if (reservation.receiveNotifications)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications_active,
                      size: 16,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Notifications enabled',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.green,
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.black54),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
