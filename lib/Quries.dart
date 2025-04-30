import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QueriesOverviewScreen extends StatefulWidget {
  const QueriesOverviewScreen({super.key});

  @override
  State<QueriesOverviewScreen> createState() => _QueriesOverviewScreenState();
}

class _QueriesOverviewScreenState extends State<QueriesOverviewScreen> {
  final List<PropertyQuery> _properties = [
    PropertyQuery(
      propertyName: "3BHK Apartment - Mumbai Central",
      imageUrl: "https://images.unsplash.com/photo-1598928506311-c55ded4f14c9", // Replace with Indian image if needed
      totalQueries: 20,
      latestQuery: DateTime.now().subtract(const Duration(days: 2)),
      interestedCustomers: 14,
    ),
    PropertyQuery(
      propertyName: "Luxury Villa - Bengaluru Whitefield",
      imageUrl: "https://images.unsplash.com/photo-1580587771525-78b9dba3b914", // Replace if needed
      totalQueries: 9,
      latestQuery: DateTime.now().subtract(const Duration(days: 4)),
      interestedCustomers: 6,
    ),
    PropertyQuery(
      propertyName: "Affordable Flat - Noida Sector 62",
      imageUrl: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c", // Replace if needed
      totalQueries: 15,
      latestQuery: DateTime.now().subtract(const Duration(days: 6)),
      interestedCustomers: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indian Property Queries'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              // Open filter options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryItem("Total Properties", _properties.length.toString(), Icons.home),
                    _buildSummaryItem(
                      "Total Queries",
                      _properties.fold(0, (sum, item) => sum + item.totalQueries).toString(),
                      Icons.question_answer,
                    ),
                    _buildSummaryItem(
                      "Interested",
                      _properties.fold(0, (sum, item) => sum + item.interestedCustomers).toString(),
                      Icons.people,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Property List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _properties.length,
              itemBuilder: (context, index) {
                final property = _properties[index];
                return _buildPropertyQueryCard(property);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildPropertyQueryCard(PropertyQuery property) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to detail screen
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  property.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                      child: const Icon(Icons.home, size: 40, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.propertyName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${property.totalQueries} queries",
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${property.interestedCustomers} interested",
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          "Latest: ${DateFormat('dd MMM yyyy').format(property.latestQuery)}",
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyQuery {
  final String propertyName;
  final String imageUrl;
  final int totalQueries;
  final DateTime latestQuery;
  final int interestedCustomers;

  PropertyQuery({
    required this.propertyName,
    required this.imageUrl,
    required this.totalQueries,
    required this.latestQuery,
    required this.interestedCustomers,
  });
}
