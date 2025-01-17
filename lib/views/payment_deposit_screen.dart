import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/viewmodel/payment_accounts_viewmodel/accounts_transaction_provider.dart';
import 'package:connectly_c2c/views/widgets/balance_screen.dart';
import 'package:connectly_c2c/views/widgets/transaction_screen.dart';

class PaymentDepositScreen extends ConsumerWidget {
  const PaymentDepositScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAccountSelected = ref.watch(accountSelectedProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.read(accountSelectedProvider.notifier).toggle();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: isAccountSelected
                                      ? const Color(0xFF6B4EFF)
                                      : Colors.transparent,
                                  width: 3))),
                      child: Center(
                        child: Text('Accounts',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.read(accountSelectedProvider.notifier).toggle();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: !isAccountSelected
                                      ? const Color(0xFF6B4EFF)
                                      : Colors.transparent,
                                  width: 3))),
                      child: Center(
                        child: Text('Transactions',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            isAccountSelected
                ? const Expanded(child: BalanceScreen())
                : const Expanded(child: TransactionScreen()),
          ],
        ),
      ),
    );
  }
}
