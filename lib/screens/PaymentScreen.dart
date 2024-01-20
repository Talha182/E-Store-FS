import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.black, fontSize: 18),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.albertSans(color: Colors.black),
          labelStyle: GoogleFonts.albertSans(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.7),
              width: 2.0,
            ),
            borderRadius:
                BorderRadius.circular(30.0), // Adjust the radius as needed
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.7),
              width: 2.0,
            ),
            borderRadius:
                BorderRadius.circular(18.0), // Adjust the radius as needed
          ),
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 15),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Payment",
                    style: GoogleFonts.albertSans(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: false,
                  isHolderNameVisible: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    "Card Details",
                    style: GoogleFonts.albertSans(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                CreditCardForm(
                  formKey: formKey,
                  obscureCvv: false,
                  obscureNumber: true,
                  cardNumber: cardNumber,
                  cvvCode: cvvCode,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  cardHolderName: cardHolderName,
                  expiryDate: expiryDate,
                  inputConfiguration: const InputConfiguration(
                    cardNumberDecoration: InputDecoration(
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0), // Adjust the padding as needed

                    ),
                    expiryDateDecoration: InputDecoration(
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0), // Adjust the padding as needed

                    ),
                    cvvCodeDecoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: 'XXX',
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0), // Adjust the padding as needed

                    ),
                    cardHolderDecoration: InputDecoration(
                      labelText: 'Card Holder',
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0), // Adjust the padding as needed

                    ),
                  ),
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Proceed To Checkout",
                          style: GoogleFonts.albertSans(
                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),

          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
