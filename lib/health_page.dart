import 'package:flutter/material.dart';
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
  final String? profilePictureUrl = 'https://ui-avatars.com/api/?name=Marwan'; 

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  HealthTitle(),
                  AddDeviceButton(),
                ],
              ),
              const SizedBox(height: 40),

              const HealthAnalytics(
                heartRate: 72.0, // Example value
                spo2: 98.0,      // Example value
                bodyTemp: 36.5,  // Example value
              ),
              const SizedBox(height: 40),

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
          builder: (context) => const BluetoothConnectionWidget(),
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
  final double heartRate;
  final double spo2;
  final double bodyTemp;

  const HealthAnalytics({
    super.key,
    required this.heartRate,
    required this.spo2,
    required this.bodyTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildHealthColumn(
            icon: Icons.favorite,
            color: Colors.red,
            value: '${heartRate.toStringAsFixed(0)} bpm',
            label: 'Heart Rate',
          ),
          _buildHealthColumn(
            icon: Icons.bloodtype,
            color: Colors.blue,
            value: '${spo2.toStringAsFixed(0)}%',
            label: 'SpO2',
          ),
          _buildHealthColumn(
            icon: Icons.thermostat,
            color: Colors.orange,
            value: '${bodyTemp.toStringAsFixed(1)}°C',
            label: 'Body Temp',
          ),
        ],
      ),
    );
  }

  Widget _buildHealthColumn({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    const double iconSize = 40;
    const double fontSize = 24;
    const double labelSize = 14;

    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: iconSize),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: fontSize,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: labelSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInCard extends StatelessWidget {
  final String? userName;
  final String? profilePictureUrl;

  const SignInCard({
    super.key,
    this.userName,
    this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = screenWidth * 0.9;
    final cardHeight = screenHeight * 0.1 > 70 ? 70.0 : screenHeight * 0.1;
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
              backgroundImage: (profilePictureUrl != null &&
                      profilePictureUrl!.startsWith('http'))
                  ? NetworkImage(profilePictureUrl!)
                  : null,
              child: (profilePictureUrl == null ||
                      !profilePictureUrl!.startsWith('http'))
                  ? Icon(Icons.account_circle,
                      color: Colors.white, size: screenWidth * 0.07)
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