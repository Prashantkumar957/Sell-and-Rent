import 'package:flutter/material.dart';

class AgentProfileScreen extends StatefulWidget {
  const AgentProfileScreen({super.key});

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  String _name = "Prashant Kumar";
  String _email = "prashant@luxuryhomes.com";
  String _phone = "+91 98765 43210";
  String _company = "Luxury Homes Realty";
  String _license = "RE/MAX-12345678";
  String _bio = "Top-performing real estate agent specializing in luxury properties across Mumbai. 10+ years experience with 98% client satisfaction.";
  String _profileImage = "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(
              color: Colors.white, // Title color
              fontWeight: FontWeight.w600, // Semi-bold styling
              fontSize: 20,

              // Adjusted for better visibility
            ),
          ),
          centerTitle: true, // Centers the title
          elevation: 2, // Adds a subtle shadow for a more modern look
          backgroundColor: Colors.transparent, // Transparent background for a sleek design
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white, // Back button color
            ),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Go Back', // Tooltip for better accessibility
          ),
          actions: [
            IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _isEditing ? Colors.blue[100] : Colors.grey[200], // Conditional background color
                  shape: BoxShape.circle, // Circular icon button for a smooth look
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ), // Adds a subtle shadow effect to the button
                  ],
                ),
                child: Icon(
                  _isEditing ? Icons.check : Icons.edit,
                  color: _isEditing ? Colors.blue : Colors.grey[700], // Icon color based on editing mode
                  size: 20, // Keeps the icon size consistent
                ),
              ),
              onPressed: _toggleEditMode,
              tooltip: _isEditing ? 'Save Changes' : 'Edit Profile', // Tooltip for better user experience
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo, Colors.blueAccent], // Gradient background
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildDetailCard(
                    title: "Personal Information",
                    children: [
                      _buildEditableField(
                        label: "Full Name",
                        value: _name,
                        icon: Icons.person_outline,
                        isEditing: _isEditing,
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                        onSaved: (value) => _name = value!,
                      ),
                      _buildEditableField(
                        label: "Email",
                        value: _email,
                        icon: Icons.email_outlined,
                        isEditing: _isEditing,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)
                            ? 'Invalid email'
                            : null,
                        onSaved: (value) => _email = value!,
                      ),
                      _buildEditableField(
                        label: "Phone",
                        value: _phone,
                        icon: Icons.phone_outlined,
                        isEditing: _isEditing,
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                        onSaved: (value) => _phone = value!,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildDetailCard(
                    title: "Professional Information",
                    children: [
                      _buildEditableField(
                        label: "Company",
                        value: _company,
                        icon: Icons.business_outlined,
                        isEditing: _isEditing,
                        onSaved: (value) => _company = value!,
                      ),
                      _buildEditableField(
                        label: "License Number",
                        value: _license,
                        icon: Icons.verified_user_outlined,
                        isEditing: _isEditing,
                        onSaved: (value) => _license = value!,
                      ),
                      _buildEditableField(
                        label: "Bio",
                        value: _bio,
                        icon: Icons.info_outline,
                        isEditing: _isEditing,
                        maxLines: 3,
                        onSaved: (value) => _bio = value!,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!_isEditing) _buildPerformanceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue.withOpacity(0.2), width: 3),
                    image: DecorationImage(image: NetworkImage(_profileImage), fit: BoxFit.cover),
                  ),
                ),
                if (_isEditing)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, size: 20, color: Colors.white),
                      onPressed: _changeProfilePicture,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            Text(_name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[800])),
            SizedBox(height: 4),
            Text(_company, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 18),
                SizedBox(width: 4),
                Text("4.9 (128 reviews)", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String value,
    required IconData icon,
    required bool isEditing,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: value,
        enabled: isEditing,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[700])),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Column(
      children: [
        SizedBox(height: 24),
        Text("Performance Overview",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[800])),
        SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildStatCard("24", "Properties", Icons.home_work_outlined),
            _buildStatCard("18", "Active Clients", Icons.people_outline),
            _buildStatCard("₹4.2Cr", "Total Value", Icons.currency_rupee_outlined),
            _buildStatCard("4.9/5", "Rating", Icons.star_outline),
          ],
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // Add logic for changing password
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              side: BorderSide(color: Colors.blue),
            ),
            child: Text("Change Password",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800])),
          SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  void _toggleEditMode() {
    if (_isEditing) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() => _isEditing = false);
      }
    } else {
      setState(() => _isEditing = true);
    }
  }

  void _changeProfilePicture() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Change profile picture tapped")),
    );
  }
}
