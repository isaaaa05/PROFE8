import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reservation_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'messages_screen.dart';

// COMPONENT 3: BottomNavigationBar with three tabs (Home, Profile, Settings)
// COMPONENT 5: Icons added to each item in BottomNavigationBar
// COMPONENT 6: Combines Drawer and BottomNavigationBar in the same app
// COMPONENT 10: Home screen with Drawer and Bottom Tabs after login

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // COMPONENT 3: Three screens for bottom navigation
  final List<Widget> _screens = [
    const HomeContent(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TicketMaster Live',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      // COMPONENT 2: Drawer menu that navigates to three different pages
      // COMPONENT 6: Drawer combined with BottomNavigationBar
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFF5F5DC),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF2196F3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.confirmation_number,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'TicketMaster Live',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Your Event Companion',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              // COMPONENT 2: First drawer item - Home
              ListTile(
                leading: const Icon(Icons.home, color: Color(0xFF2196F3)),
                title: Text('Home', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _currentIndex = 0);
                },
              ),
              // COMPONENT 2: Second drawer item - About
              ListTile(
                leading: const Icon(Icons.info, color: Color(0xFF2196F3)),
                title: Text('About', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  // COMPONENT 7: Using named route
                  Navigator.pushNamed(context, '/about');
                },
              ),
              // COMPONENT 2: Third drawer item - Contact
              ListTile(
                leading:
                    const Icon(Icons.contact_mail, color: Color(0xFF2196F3)),
                title: Text('Contact', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  // COMPONENT 7: Using named route
                  Navigator.pushNamed(context, '/contact');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text('Logout', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
      body: _screens[_currentIndex],
      // COMPONENT 3 & 5: BottomNavigationBar with three tabs and icons
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2196F3),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(),
        items: const [
          // COMPONENT 5: Icon for Home tab
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // COMPONENT 5: Icon for Profile tab
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          // COMPONENT 5: Icon for Settings tab
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Home content with reservation button
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.confirmation_number,
              size: 100,
              color: const Color(0xFF2196F3),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to TicketMaster Live',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your one-stop platform for event reservations and payments',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                // COMPONENT 1: Using Navigator.push() to navigate
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ReservationScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.event_available),
              label: const Text('Make a Reservation'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MessagesScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.message),
              label: const Text('View Messages'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2196F3),
                side: const BorderSide(color: Color(0xFF2196F3)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
