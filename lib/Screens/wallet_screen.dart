import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';

class WalletScreen extends StatelessWidget {
  final double amount;

  const WalletScreen({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: SAppColors.secondaryDarkBlue,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  const Text(
                    "My Wallet",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: SAppColors.secondaryDarkBlue,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              // 🔹 Center Content
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/wallet_asset.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      
                      const SizedBox(height: 32),

                      const Text(
                        "Total Balance",
                        style: TextStyle(
                          fontSize: 18,
                          color: SAppColors.secondaryDarkBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      const SizedBox(height: 8),

                      // 🔹 SAFE STYLE ACCESS
                      Center(
                        child: Text(
                          "\$${amount.toStringAsFixed(2)}",
                          style: (STextTheme.lightTextTheme.displayMedium ?? 
                                 const TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
                              .copyWith(
                          fontWeight: FontWeight.bold,
                          color: SAppColors.secondaryDarkBlue,
                        ),
                      ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}