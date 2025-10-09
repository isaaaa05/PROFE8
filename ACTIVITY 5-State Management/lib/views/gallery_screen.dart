import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// COMPONENT 9: Display list of images from assets in GridView
// COMPONENT 18: Gallery app/carousel that loads images from assets
// COMPONENT 6: Display local images using Image.asset()
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  // COMPONENT 6 & 18: Local images using Image.asset()
  // To use local images:
  // 1. Add images to assets/images/ folder (e.g., concert1.jpg, concert2.jpg)
  // 2. Declare them in pubspec.yaml under assets section
  // 3. Use Image.asset('assets/images/concert1.jpg')
  final List<Map<String, String>> eventImages = [
    {
      'asset': 'assets/images/concert1.jpg', // COMPONENT 6: Local image path
      'title': 'Rock Concert',
      'type': 'asset',
    },
    {
      'asset': 'assets/images/concert2.jpg',
      'title': 'Music Festival',
      'type': 'asset',
    },
    {
      'asset': 'assets/images/concert3.jpg',
      'title': 'Live Performance',
      'type': 'asset',
    },
    {
      'asset': 'assets/images/concert4.jpg',
      'title': 'DJ Night',
      'type': 'asset',
    },
    {
      'asset': 'assets/images/concert5.jpg',
      'title': 'Orchestra',
      'type': 'asset',
    },
    {
      'asset': 'assets/images/concert6.jpg',
      'title': 'Theater Show',
      'type': 'asset',
    },
  ];

  int _currentCarouselIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);
  late Timer _carouselTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentCarouselIndex + 1) % eventImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _carouselTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Gallery',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // COMPONENT 18: Carousel that loads images from assets using PageView
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentCarouselIndex = index;
                  });
                },
                itemCount: eventImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          // COMPONENT 6: Display local image using Image.asset()
                          child: Image.asset(
                            eventImages[index]['asset']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            // Fallback to placeholder if asset not found
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: isDark
                                    ? const Color(0xFF1E1E1E)
                                    : Colors.grey[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 64,
                                      color:
                                          isDark ? Colors.white38 : Colors.grey,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Add image to\n${eventImages[index]['asset']}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: isDark
                                            ? Colors.white38
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Text(
                              eventImages[index]['title']!,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            // Carousel indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: eventImages.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCarouselIndex == entry.key
                        ? const Color(0xFF2196F3)
                        : (isDark ? Colors.white38 : Colors.grey),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Featured Events',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // COMPONENT 9: GridView displaying list of images from assets
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: eventImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showImageDialog(
                        eventImages[index]['asset']!,
                        eventImages[index]['title']!,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        // COMPONENT 6: Display local image using Image.asset()
                        child: Image.asset(
                          eventImages[index]['asset']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: isDark
                                  ? const Color(0xFF1E1E1E)
                                  : Colors.grey[300],
                              child: Icon(
                                Icons.image,
                                size: 48,
                                color: isDark ? Colors.white38 : Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showImageDialog(String imagePath, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // COMPONENT 6: Display local image using Image.asset()
            Image.asset(
              imagePath,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[300],
                  child: Icon(
                    Icons.image,
                    size: 64,
                    color: isDark ? Colors.white38 : Colors.grey,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
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
