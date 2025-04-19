import 'package:flutter/material.dart';
import 'health_analytics_page.dart';
import 'signin_page.dart';
import 'bluetooth_connection_widget.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  HealthPageState createState() => HealthPageState();
}

class HealthPageState extends State<HealthPage> {
  bool isSignedIn = true;
  final String userName = 'Marwan';
  final String? profilePictureUrl = 'https://www.example.com/profile_picture.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with title and add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  HealthTitle(),
                  AddDeviceButton(),
                ],
              ),
              const SizedBox(height: 40),

              // Health analytics section
              const HealthAnalytics(),
              const SizedBox(height: 40),

              // Sign in or profile card
              Center(
                child: isSignedIn
                    ? SignInCard(
                        userName: userName,
                        profilePictureUrl: profilePictureUrl,
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignInPage()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 17, 17, 17),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.person, color: Colors.white),
                              SizedBox(width: 12),
                              Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class HealthTitle extends StatelessWidget {
  const HealthTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Health',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

class AddDeviceButton extends StatelessWidget {
  const AddDeviceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => BluetoothConnectionWidget(),
        );
      },
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Center(
          child: Icon(Icons.add, color: Colors.white, size: 17),
        ),
      ),
    );
  }
}

class HealthAnalytics extends StatelessWidget {
  const HealthAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    const int heartRate = 76;
    const double bodyTemp = 36.7;
    const String sleep = '7h 30m';

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = screenWidth * 0.9;
    final cardHeight = screenHeight * 0.18;
    final iconSize = screenWidth * 0.07;
    final fontSize = screenWidth * 0.045;
    final labelSize = screenWidth * 0.03;

    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HealthAnalyticsPage()),
          );
        },
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03,
            horizontal: screenWidth * 0.04,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 17, 17, 17),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHealthColumn(
                icon: Icons.thermostat,
                value: '$bodyTemp°C',
                label: 'Body Temp',
                color: Colors.orange,
                fontSize: fontSize,
                labelSize: labelSize,
                iconSize: iconSize,
              ),
              _buildHealthColumn(
                icon: Icons.favorite,
                value: '$heartRate BPM',
                label: 'Heart Rate',
                color: Colors.red,
                fontSize: fontSize,
                labelSize: labelSize,
                iconSize: iconSize,
              ),
              _buildHealthColumn(
                icon: Icons.bedtime,
                value: sleep,
                label: 'Sleep',
                color: Colors.blue,
                fontSize: fontSize,
                labelSize: labelSize,
                iconSize: iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildHealthColumn({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required double fontSize,
    required double labelSize,
    required double iconSize,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: iconSize),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: Colors.white, fontSize: fontSize)),
        Text(label, style: TextStyle(color: Colors.white54, fontSize: labelSize)),
      ],
    );
  }
}

class SignInCard extends StatelessWidget {
  final String? userName;
  final String? profilePictureUrl;

  const SignInCard({super.key, this.userName, this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = screenWidth * 0.9;
    final cardHeight = screenHeight * 0.07;
    final fontSize = screenWidth * 0.035;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SignInPage()),
        );
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 17, 17, 17),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: screenWidth * 0.05,
              backgroundColor: Colors.grey[800],
              backgroundImage: profilePictureUrl != null
                  ? NetworkImage(profilePictureUrl!)
                  : null,
              child: profilePictureUrl == null
                  ? Icon(Icons.account_circle, color: Colors.white, size: screenWidth * 0.07)
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              userName ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
