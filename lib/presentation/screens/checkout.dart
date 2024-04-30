import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nibbles_ecommerce/presentation/widgets.dart';
import 'package:nibbles_ecommerce/core/core.dart';

import 'package:nibbles_ecommerce/application/application.dart';
import 'package:nibbles_ecommerce/configs/configs.dart';

import 'package:nibbles_ecommerce/models/order.dart';
import 'package:nibbles_ecommerce/models/package.dart';

import 'dart:math' as math;

import 'package:razorpay_flutter/razorpay_flutter.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen(
      {super.key, required this.packageModel, required this.addressTitle});

  final PackageModel packageModel;
  final String addressTitle;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    Navigator.of(context).pushNamed(
        AppRouter.successfulOrder,
        arguments: widget.packageModel.name);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Payment Error: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment
    print("External Wallet: ${response.walletName}");
  }
  DateTime selectedDate = DateTime.now();
  bool dateChosen = false;
  final TextEditingController controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        dateChosen = true;
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final random = math.Random();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppDimensions.normalize(150),
              child: Stack(
                children: [
                  curvedlRecSvg(AppColors.deepTeal),
                  positionedRow(context),
                  positionedTitle("Checkout".toUpperCase()),
                  Positioned(
                      top: AppDimensions.normalize(63),
                      left: AppDimensions.normalize(10),
                      child: Text(
                        "Your Order",
                        style: AppText.h3b?.copyWith(color: Colors.white),
                      )),
                  Positioned(
                      top: AppDimensions.normalize(77),
                      left: AppDimensions.normalize(10),
                      right: AppDimensions.normalize(10),
                      child: Material(
                        borderRadius: profileBorderRadius,
                        elevation: 2,
                        child: Container(
                          height: AppDimensions.normalize(67),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: profileBorderRadius,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Space.yf(.8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Space.xf(),
                                  Image.asset(
                                    AppAssets.mealsPng[random.nextInt(4)],
                                    height: AppDimensions.normalize(24),
                                  ),
                                  Space.xf(.8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.packageModel.name.toUpperCase(),
                                        style: AppText.h2,
                                      ),
                                      Text(widget.packageModel.formattedPrice
                                          .toUpperCase()),
                                      Space.yf(.4),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppAssets
                                                .kidsImages[random.nextInt(2)],
                                            height: AppDimensions.normalize(12),
                                          ),
                                          Space.xf(.5),
                                          BlocBuilder<SelectKidCubit,
                                              SelectKidState>(
                                            builder: (context, state) {
                                              return Text(state
                                                      .selectedKid?.name
                                                      .capitalize() ??
                                                  "");
                                            },
                                          )
                                        ],
                                      ),
                                      Space.yf(.8),
                                    ],
                                  )
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  color: AppColors.antiqueRuby,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Starting Date :".capitalize(),
                                        style: AppText.h3b
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      Space.xf(1.5),
                                      GestureDetector(
                                        onTap: () => _selectDate(context),
                                        child: Container(
                                          height: AppDimensions.normalize(12),
                                          width: AppDimensions.normalize(50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimensions.normalize(
                                                          4)),
                                              border: Border.all(
                                                  color:
                                                      AppColors.commonAmber)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                dateChosen
                                                    ? "${selectedDate.toLocal()}"
                                                        .split(' ')[0]
                                                    : "Select Date",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.calendar_month,
                                                size:
                                                    AppDimensions.normalize(7),
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Space.yf(1.3),
            couponContainer(controller),
            Space.yf(1.3),
            pricesContainer(widget.packageModel),
            Space.yf(1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...AppAssets.paymentPng.map((e) => Padding(
                      padding:
                          EdgeInsets.only(right: AppDimensions.normalize(4)),
                      child: Image.asset(
                        e,
                        height: AppDimensions.normalize(13),
                      ),
                    ))
              ],
            ),
            Space.yf(),
            BlocBuilder<SelectKidCubit, SelectKidState>(
              builder: (context, kidState) {
                return BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                  builder: (context, orderState) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          startRazorpayPayment();
                        },
                        child: Text(
                          (orderState is PlaceOrderLoading) ? AppStrings.wait : "Pay",style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );

                  },
                );
              },
            ),
            Space.yf(2.2),
          ],
        ),
      ),
    );
  }
  void startRazorpayPayment() {
    // Extract the numeric part from formattedPrice
    String numericPrice = widget.packageModel.formattedPrice.replaceAll(RegExp(r'[^0-9.]'), '');

    // Convert numericPrice to a double
    double price = double.tryParse(numericPrice) ?? 0.0;

    // Convert the price to paise
    int amountInPaise = (price * 100/1000).toInt();

    var options = {
      'key': 'rzp_test_nINexP3HZA1XP7', // Replace with your actual Razorpay API key
      'amount': amountInPaise, // Amount in paise
      'name': widget.packageModel.name,
      'description': 'Test Payment',
      'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }


}

