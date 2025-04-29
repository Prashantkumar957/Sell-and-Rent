import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgentProfileScreen extends StatefulWidget {
  const AgentProfileScreen({super.key});

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  // Agent profile data
  String _name = "Prashant Kumar ";
  String _email = "demo@gmail..com";
  String _phone = "+9123-4567";
  String _company = "Luxury Homes Realty";
  String _license = "CA-12345678";
  String _bio = "Specializing in luxury properties with 10+ years of experience in the Bay Area market.";
  String _profileImage = "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully')),
                  );
                }
              }
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(_profileImage),
                    backgroundColor: Colors.grey[200],
                  ),
                  if (_isEditing)
                    FloatingActionButton.small(
                      onPressed: () => _changeProfilePicture(),
                      child: const Icon(Icons.camera_alt),
                      backgroundColor: Colors.blue,
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Name
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: !_isEditing,
                  fillColor: Colors.grey[100],
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: _isEditing ? Colors.black : Colors.grey[800],
                ),
                enabled: _isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: !_isEditing,
                  fillColor: Colors.grey[100],
                ),
                keyboardType: TextInputType.emailAddress,
                enabled: _isEditing,
                style: TextStyle(
                  fontSize: 16,
                  color: _isEditing ? Colors.black : Colors.grey[800],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 16),

              // Phone
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: !_isEditing,
                  fillColor: Colors.grey[100],
                ),
                keyboardType: TextInputType.phone,
                enabled: _isEditing,
                style: TextStyle(
                  fontSize: 16,
                  color: _isEditing ? Colors.black : Colors.grey[800],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              const SizedBox(height: 16),

              // Company
              TextFormField(
                initialValue: _company,
                decoration: InputDecoration(
                  labelText: 'Company',
                  prefixIcon: const Icon(Icons.business),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: !_isEditing,
                  fillColor: Colors.grey[100],
                ),
                enabled: _isEditing,
                style: TextStyle(
                  fontSize: 16,
                  color: _isEditing ? Colors.black : Colors.grey[800],
                ),
                onSaved: (value) => _company = value!,
              ),
              const SizedBox(height: 16),

              // License
              TextFormField(
                initialValue: _license,
                decoration: InputDecoration(
                  labelText: 'License Number',
                  prefixIcon: const Icon(Icons.verified_user),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: !_isEditing,
                  fillColor: Colors.grey[100],
                ),
                enabled: _isEditing,
                style: TextStyle(
                  fontSize: 16,
                  color: _isEditing ? Colors.black : Colors.grey[800],
                ),
                onSaved: (value) => _license = value!,
              ),
              const SizedBox(height: 16),

              // Bio
              TextFormField(
                initialValue: _bio,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.info),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: !_isEditing,
                  fillColor: Colors.grey[100],
                ),
                maxLines: 4,
                enabled: _isEditing,
                style: TextStyle(
                  fontSize: 16,
                  color: _isEditing ? Colors.black : Colors.grey[800],
                ),
                onSaved: (value) => _bio = value!,
              ),
              const SizedBox(height: 24),

              // Stats Section
              if (!_isEditing) ...[
                const Text(
                  'My Stats',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('24', 'Properties'),
                    _buildStatItem('18', 'Clients'),
                    _buildStatItem('4.9', 'Rating'),
                  ],
                ),
              ],

              // Change Password Button
              if (!_isEditing) ...[
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.lock),
                    label: const Text('Change Password'),
                    onPressed: () {
                      // Navigate to change password screen
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Future<void> _changeProfilePicture() async {
    // Implement image picker functionality
    // For example using image_picker package:
    // final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   setState(() {
    //     _profileImage = pickedFile.path;
    //   });
    // }
  }
}