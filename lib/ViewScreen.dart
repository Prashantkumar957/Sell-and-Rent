import 'package:flutter/material.dart';
import 'profile.dart';
import 'favorites_screen.dart';
import 'package:sellandrent/Quries.dart';
class Viewscreen extends StatefulWidget {
  const Viewscreen({super.key});

  @override
  State<Viewscreen> createState() => _ViewscreenState();
}

class _ViewscreenState extends State<Viewscreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _properties = [
    {
      'title': 'Modern Apartment in Chennai',
      'image': 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      'price': '\₹40,50,000',
      'type': 'Apartment',
      'location': 'Chennai',
      'bedrooms': 3,
      'bathrooms': 2,
      'area': '1200 sq ft',
      'rating': 4.8,
    },
    {
      'title': 'Luxury Villa with Ocean View',
      'image': 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6',
      'price': '\₹1,200,000',
      'type': 'Villa',
      'location': 'Mumbai',
      'bedrooms': 5,
      'bathrooms': 4,
      'area': '3200 sq ft',
      'rating': 4.9,
    },
    {
      'title': 'Cozy Studio in City Center',
      'image': 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      'price': '\₹220,000',
      'type': 'Studio',
      'location': 'Delhi',
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '600 sq ft',
      'rating': 4.5,
    },
  ];

  int _currentIndex = 0; // Track the current selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Find Your Dream Home",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            Text(
              "New Delhi, India",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.notifications_outlined),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.favorite_border),
            ),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search properties...',
                      prefixIcon: const Icon(Icons.search, color: Colors.blue),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.tune, color: Colors.blue),
                        onPressed: () {
                          // Open filters
                        },
                      ),
                    ),
                    onChanged: (value) {
                      // Implement search functionality
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Apartment'),
                _buildFilterChip('House'),
                _buildFilterChip('Villa'),
                _buildFilterChip('Commercial'),
              ],
            ),
          ),

          // Property List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _properties.length,
              itemBuilder: (context, index) {
                final property = _properties[index];
                return _buildPropertyCard(property);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 4) {
            // Index 4 corresponds to the 'Profile' item (0-based)
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AgentProfileScreen()),
            );
          }
           else if (index == 3) {
              // Index 4 corresponds to the 'Profile' item (0-based)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QueriesOverviewScreen()),
              );
          }else if (index == 2) {
            // Index 4 corresponds to the 'Profile' item (0-based)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritesScreen()),
            );
          } else {
            // Handle navigation for other bottom navigation items if needed
            // For example:
            // if (index == 0) {
            //   // Navigate to Home screen
            // }
            // ...
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        labelStyle: TextStyle(
          color: label == 'All' ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        selected: label == 'All',
        selectedColor: Colors.blue,
        backgroundColor: Colors.grey[200],
        onSelected: (bool selected) {
          setState(() {
            // Handle filter selection
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        showCheckmark: false,
      ),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> property) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  property['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Icon(Icons.home, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        property['rating'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Property Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        property['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      property['price'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      property['location'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Features
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFeatureItem(
                      Icons.king_bed,
                      '${property['bedrooms']} Beds',
                    ),
                    _buildFeatureItem(
                      Icons.bathtub,
                      '${property['bathrooms']} Baths',
                    ),
                    _buildFeatureItem(
                      Icons.zoom_out_map,
                      property['area'],
                    ),
                    _buildFeatureItem(
                      Icons.apartment,
                      property['type'],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // View Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // View property details
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blue),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}