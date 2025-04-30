import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Sample favorite properties data
  final List<Map<String, dynamic>> _favorites = [
    {
      'id': '1',
      'title': 'Luxury Penthouse with Ocean View',
      'price': 1200000,
      'location': 'Miami Beach, FL',
      'image': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
      'type': 'Apartment',
      'bedrooms': 3,
      'bathrooms': 2,
      'area': 1800,
      'savedDate': '2023-05-15',
      'isCompetitor': false,
    },
    {
      'id': '2',
      'title': 'Modern Villa in Gated Community',
      'price': 950000,
      'location': 'Boca Raton, FL',
      'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
      'type': 'House',
      'bedrooms': 4,
      'bathrooms': 3,
      'area': 2400,
      'savedDate': '2023-05-10',
      'isCompetitor': true,
    },
    {
      'id': '3',
      'title': 'Downtown Commercial Space',
      'price': 2500000,
      'location': 'Downtown Miami, FL',
      'image': 'https://images.unsplash.com/photo-1493809842364-78817add7ffb',
      'type': 'Commercial',
      'bedrooms': 0,
      'bathrooms': 2,
      'area': 5000,
      'savedDate': '2023-04-28',
      'isCompetitor': false,
    },
  ];

  String _currentFilter = 'all'; // 'all', 'mine', 'competitors'

  @override
  Widget build(BuildContext context) {
    final filteredList = _currentFilter == 'all'
        ? _favorites
        : _favorites.where((item) =>
    _currentFilter == 'mine' ? !item['isCompetitor'] : item['isCompetitor']).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Properties'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All', 'all'),
                        const SizedBox(width: 8),
                        _buildFilterChip('My Listings', 'mine'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Competitors', 'competitors'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List of saved properties
          Expanded(
            child: filteredList.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final property = filteredList[index];
                return _buildPropertyCard(property);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: _currentFilter == value,
      onSelected: (selected) {
        setState(() {
          _currentFilter = value;
        });
      },
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      labelStyle: TextStyle(
        color: _currentFilter == value
            ? Theme.of(context).primaryColor
            : Colors.grey[600],
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      side: BorderSide(
        color: _currentFilter == value
            ? Theme.of(context).primaryColor
            : Colors.grey[300],
      ),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> property) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to property details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    property['image'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 180,
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red[400],
                      size: 20,
                    ),
                  ),
                ),
                if (property['isCompetitor'])
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange[600],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'COMPETITOR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Property Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${property['price'].toString().replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d)'),
                              (Match m) => '${m[1]},',
                        )}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Saved ${property['savedDate']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    property['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        property['location'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildDetailChip(
                        '${property['bedrooms']} ${property['bedrooms'] == 1 ? 'Bed' : 'Beds'}',
                        Icons.bed,
                      ),
                      const SizedBox(width: 8),
                      _buildDetailChip(
                        '${property['bathrooms']} ${property['bathrooms'] == 1 ? 'Bath' : 'Baths'}',
                        Icons.bathtub,
                      ),
                      const SizedBox(width: 8),
                      _buildDetailChip(
                        '${property['area']} sqft',
                        Icons.space_dashboard,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.remove_red_eye, size: 18),
                      label: const Text('View'),
                      onPressed: () {
                        // View property
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.compare, size: 18),
                      label: const Text('Compare'),
                      onPressed: () {
                        // Add to comparison
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: Colors.grey[300]!,
                        ),
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

  Widget _buildDetailChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/empty_state.svg', // You can add this SVG asset
            height: 120,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          const Text(
            'No saved properties yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _currentFilter == 'mine'
                ? 'Your saved listings will appear here'
                : _currentFilter == 'competitors'
                ? 'Saved competitor listings will appear here'
                : 'Save properties to view them here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to browse properties
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Browse Properties'),
          ),
        ],
      ),
    );
  }
}