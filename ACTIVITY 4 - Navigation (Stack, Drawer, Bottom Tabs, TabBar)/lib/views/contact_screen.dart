import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COMPONENT 7: Contact screen accessible via named route '/contact'

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.contact_mail,
                size: 80,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Get in Touch',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'We\'d love to hear from you! Reach out to us through any of the following channels:',
              style: GoogleFonts.poppins(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),
            _buildContactCard(
              Icons.email,
              'Email',
              'support@ticketmasterlive.com',
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              Icons.phone,
              'Phone',
              '+63 (2) 8123-4567',
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              Icons.location_on,
              'Address',
              'Makati City, Metro Manila, Philippines',
            ),
            const SizedBox(height: 32),
            Text(
              'Business Hours',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Monday - Friday: 9:00 AM - 6:00 PM\nSaturday: 10:00 AM - 4:00 PM\nSunday: Closed',
              style: GoogleFonts.poppins(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String content) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF2196F3), size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: GoogleFonts.poppins(fontSize: 14),
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
