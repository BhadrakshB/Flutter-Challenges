import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: -1,
            offset: Offset(0, -1),
          )
        ],
        borderRadius: BorderRadius.circular(25),
        color: Colors.deepPurple.shade900,
      ),
      padding: const EdgeInsets.only(
        left: 30,
        top: 5,
        bottom: 10,
      ),
      margin: const EdgeInsets.all(20),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Visa".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Platinum".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          const Text(
            "**** **** **** 5040",
            style: TextStyle(
              color: Colors.white70,
              letterSpacing: 8,
            ),
          )
        ],
      ),
    );
  }
}

class CardDetails {
  final String type;
  final int balance;
  final String accountType;

  CardDetails(
      {required this.type, required this.accountType, required this.balance});
}



// Color(0xFF311078),