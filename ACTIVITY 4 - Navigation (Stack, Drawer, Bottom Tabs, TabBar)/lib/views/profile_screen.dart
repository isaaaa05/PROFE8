import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFF2196F3),
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text(
              'User Profile',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading:
                          const Icon(Icons.email, color: Color(0xFF2196F3)),
                      title: Text('Email',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      subtitle: Text('user@example.com',
                          style: GoogleFonts.poppins()),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.phone, color: Color(0xFF2196F3)),
                      title: Text('Phone',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      subtitle: Text('+63 912 345 6789',
                          style: GoogleFonts.poppins()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on,
                          color: Color(0xFF2196F3)),
                      title: Text('Location',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      subtitle: Text('Manila, Philippines',
                          style: GoogleFonts.poppins()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
