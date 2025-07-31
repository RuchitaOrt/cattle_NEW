import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/TaggingStepper.dart';

import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FormSection {
  final String title;
  final Widget content;

  FormSection({required this.title, required this.content});
}

class PaymentForm extends StatelessWidget {
  const PaymentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BasicFormProvider>(
      create: (_) => BasicFormProvider(),
      child: const _PaymentFormScreenContent(), // 👈 Separate inner widget
    );
  }
}

class _PaymentFormScreenContent extends StatefulWidget {
  const _PaymentFormScreenContent({Key? key}) : super(key: key);

  @override
  State<_PaymentFormScreenContent> createState() =>
      _SignatureFormScreenContentState();
}

class _SignatureFormScreenContentState
    extends State<_PaymentFormScreenContent> {
  int expandedIndex = 0;
  bool _expanded = false;
    @override
void initState() {
  super.initState();
WidgetsBinding.instance.addPostFrameCallback((_) {
    final provider = Provider.of<BasicFormProvider>(context, listen: false);

    for (var controller in [
      provider.paymentfarmerNameController,
      provider.paymentContacteController,
      
    ]) {
      controller.addListener(() => setState(() {}));
    }
  });
}
  @override
  Widget build(BuildContext context) {
    final basicFormProvider = Provider.of<BasicFormProvider>(context);

    final List<FormSection> sections = [
      FormSection(
        title: CattleStrings.strFarmerDetail,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFieldWidget(
              isMandatory: false,
              title: CattleStrings.strName,
              hintText: CattleStrings.strNameHint,
              onChange: (val) {},
              textEditingController: basicFormProvider.paymentfarmerNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: false,
              title: CattleStrings.strContactNo,
              hintText: CattleStrings.strContactNoHint,
              maxCharacterLength: 10,
               leadingIcon:Text("+ 91"),
              onChange: (val) {},
              textEditingController: basicFormProvider.paymentContacteController,
               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              autovalidateMode: AutovalidateMode.disabled,
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: CommonAppBar(
        title: CattleStrings.strPayment,
         stepsTitle: "STEP 5/5",
      ),
      backgroundColor: CattleColors.white,
       bottomNavigationBar:
       (basicFormProvider.isPaymentLater==true)? 
        Padding(
         padding: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
         child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CattleColors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                   Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                  },
                  child: const Text("Back to home",
                      style: TextStyle(color: Colors.white)),
                ),
       )
       :
       basicFormProvider.isPaymentOKClick!? Padding(
         padding: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
         child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CattleColors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
          showModalBottomSheet(
                    backgroundColor: CattleColors.white,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20)),
                    ),
                    isScrollControlled: true,
                    builder: (_) => ConfirmationSheet(
                      isSingleButton: true,
                      singleButton: "Back to home",
                      onBackToHome: () {
                           Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => TaggingScreen(currentStepId: "6",type: "",proceed: "",)));
                      },
                      imagePath: CattleImagePath.taggingComplete,
                      onCancel: () => Navigator.pop(context),
                      onLogout: () {
                        Navigator.pop(context);
                      },
                      firstbutton: '',
                      secondButton: '',
                      title: "Tagging complete",
                      subHeading:
                          "You can view this case in the ‘Unsynced’ or ‘Completed’ sections",
                    ),
                  );
                  },
                  child: const Text("Submit",
                      style: TextStyle(color: Colors.white)),
                ),
       ): Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Expanded(
            //   child: OutlinedButton(
            //     onPressed: () {
            //       showModalBottomSheet(
            //         backgroundColor: CattleColors.white,
            //         context: context,
            //         shape: const RoundedRectangleBorder(
            //           borderRadius: BorderRadius.vertical(
            //               top: Radius.circular(20)),
            //         ),
            //         isScrollControlled: true,
            //         builder: (_) => ConfirmationSheet(
            //           isSingleButton: true,
            //           singleButton: "Save & exit",
            //           onBackToHome: () {
            //              Navigator.pushReplacement(
            //                     routeGlobalKey.currentContext!,
            //                     MaterialPageRoute(
            //                         builder: (context) => HomeScreen()));
            //           },
            //           imagePath: CattleImagePath.helplogo,
            //           onCancel: () => Navigator.pop(context),
            //           onLogout: () {
            //             Navigator.pop(context);
            //           },
            //           firstbutton: '',
            //           secondButton: '',
            //           title: "Are you sure you want to exit?",
            //           subHeading:
            //               "If you go back now, your progress will be \nsaved in 'Pending'.",
            //         ),
            //       );
            //     },
            //     style: OutlinedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10)),
            //       side: const BorderSide(
            //           color: CattleColors.orange, width: 0.4),
            //     ),
            //     child: const Text("Save & cancel",
            //         style: TextStyle(
            //             color: CattleColors.orange,
            //             fontWeight: FontWeight.w600)),
            //   ),
            // ),
            // const SizedBox(width: 12),
            // Expanded(
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor:basicFormProvider.isPaymentFormValid? CattleColors.orange:CattleColors.greyButton,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8)),
            //     ),
            //     onPressed: () {
                
            //     },
            //     child: const Text("Continue",
            //         style: TextStyle(color: Colors.white)),
            //   ),
            // ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
            child:
            (basicFormProvider.isPaymentLater==true)?paymentConfirmation(CattleImagePath.paymentnotcomplete,"Payment not complete","The application is open as payment of ₹4,250 is pending. It will be in the ‘Pending’ section until payment is completed"): 
            (basicFormProvider.isPaymentOKClick==true)?paymentConfirmation(CattleImagePath.paymentcomplete,"Payment complete","Payment for ₹4,250 is complete. You can go ahead and submit the application"):
            ListView(
              children: [
                ...sections.asMap().entries.map((entry) {
                  final index = entry.key;
                  final section = entry.value;
                  final isExpanded = index == expandedIndex;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isExpanded
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CattleColors.lightergrey,
                            border: Border.all(color: CattleColors.lightgrey),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                              bottom: isExpanded
                                  ? Radius.zero
                                  : Radius.circular(12),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              section.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: CattleColors.blackshade,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                expandedIndex = isExpanded ? -1 : index;
                              });
                            },
                          ),
                        ),
                        if (isExpanded)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: CattleColors.lightgrey),
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(12)),
                            ),
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                            child: section.content,
                          ),
                      ],
                    ),
                  );
                }).toList(),

                // ✅ Add totalPremium after all sections
                const SizedBox(height: 16),
                totalPremium(),
                const SizedBox(height: 16),
                paymentMode(basicFormProvider)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget totalPremium() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
          bottom: _expanded ? Radius.zero : Radius.circular(12),
        ),
        border: Border.all(color: CattleColors.lightgrey),
        color: CattleColors.lightergrey,
        boxShadow: _expanded
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          // User + Info row

          const SizedBox(height: 8),

          // Expandable Header
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Container(
                color: CattleColors.lightergrey,
                child: Row(
                  children: [
                    Text(CattleStrings.strTotalPremium,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CattleColors.blacklight)),
                    SizedBox(
                      width: 4,
                    ),
                    Text("र 1770",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CattleColors.blackshade)),
                    const Spacer(),
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: CattleColors.orange,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),
          if (_expanded) ...[expandedWidget()],
        ],
      ),
    );
  }
Widget paymentConfirmation(String imagePath,String title,String subHeading)
{
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     SvgPicture.asset(
            imagePath,
          
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style:  TextStyle(
              color: CattleColors.blackshade,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
        subHeading!=""?  Column(
            children: [
              Text(
                subHeading,
                textAlign: TextAlign.center,
                style:  TextStyle(
                  color: CattleColors.grey75,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
               const SizedBox(height: 24),
            ],
          ):Container(),
  ],);
}
  Widget paymentMode(BasicFormProvider basicformprovider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
          bottom: _expanded ? Radius.zero : Radius.circular(12),
        ),
        border: Border.all(color: CattleColors.lightgrey),
        color: CattleColors.lightergrey,
        boxShadow: _expanded
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          // User + Info row

          const SizedBox(height: 8),

          // Expandable Header
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Container(
                color: CattleColors.lightergrey,
                child: Row(
                  children: [
                    Text(CattleStrings.strPayment,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CattleColors.blacklight)),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

         expandedPaymentWidget(basicformprovider)
        ],
      ),
    );
  }
  Widget expandedPaymentWidget(BasicFormProvider basicformprovider) {
    return Container(

      color: CattleColors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            GestureDetector(
              onTap: ()
              {
                  showModalBottomSheet(
                      backgroundColor: CattleColors.white,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      isScrollControlled: true,
                      builder: (_) => ConfirmationSheet(
                        isSingleButton: true,
                        singleButton: "Okay",
                        onBackToHome: () {
                        basicformprovider.linkSharedOkayClick();
                        },
                        imagePath: CattleImagePath.likshared,
                        onCancel: () => Navigator.pop(context),
                        onLogout: () {
                          Navigator.pop(context);
                        },
                        firstbutton: '',
                        secondButton: '',
                        title: "Link shared",
                        subHeading:
                            "A payment link has been sent to 9819098190. \nIt will be active for 30 mins.",
                      ),
                    );
              },
              child: Row(
                children: [
                  SvgPicture.asset(CattleImagePath.standardlink),
                  summary("Standard link ", "", ""),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Divider(
                thickness: 0.2,
                color: CattleColors.grey75,
              ),
            ),
              GestureDetector(
                onTap: ()
                {
                  showModalBottomSheet(
                    backgroundColor: CattleColors.white,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20)),
                    ),
                    isScrollControlled: true,
                    builder: (_) => ConfirmationSheet(
                      isSingleButton: true,
                      singleButton: "Okay",
                      onBackToHome: () {
                          basicformprovider.linkSharedOkayClick();
                      },
                      imagePath: CattleImagePath.qrImage,
                      onCancel: () => Navigator.pop(context),
                      onLogout: () {
                        Navigator.pop(context);
                      },
                      firstbutton: '',
                      secondButton: '',
                      title: "Scan QR code",
                      subHeading:
                          "If you share this QR code with someone, they can scan it and complete payment \n\nQR code expires in 1:10 minutes",
                    ),
                  );
                },
                child: Row(
                children: [
                  SvgPicture.asset(CattleImagePath.qrcode),
                  summary("QR code ", "", ""),
                ],
                            ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Divider(
                thickness: 0.2,
                color: CattleColors.grey75,
              ),
            ),
              GestureDetector(
                onTap: ()
                {
                  basicformprovider.setPaymentLater(true);
                },
                child: Row(
                children: [
                  SvgPicture.asset(CattleImagePath.paylater),
                  summary("Pay later ", "", ""),
                ],
                            ),
              ),
           
            
            
          ],
        ),
      ),
    );
  }

  Widget expandedWidget() {
    return Container(
      color: CattleColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          summary("Cow ", "(NLM12345677890000)", "र 1500"),
          Divider(
            thickness: 0.2,
            color: CattleColors.grey75,
          ),
          summary("Buffalo ", "(NLM12345677890000)", "र 1500"),
          Divider(
            thickness: 0.2,
            color: CattleColors.grey75,
          ),
          summary("Buffalo ", "(NLM12345677890000)", "र 1500"),
          Divider(
            thickness: 0.2,
            color: CattleColors.grey75,
          ),
          summary("Buffalo ", "(NLM12345677890000)", "र 1500"),
          Divider(
            thickness: 0.2,
            color: CattleColors.grey75,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(CattleStrings.strTotal,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CattleColors.blackshade)),
                Text("र 1770",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CattleColors.blackshade)),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget summary(String title, String subTitle, String price) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: CattleColors.blackshade)),
              Text(subTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: CattleColors.hintGrey)),
            ],
          ),
          Text(price,
              style: TextStyle(
                  fontWeight: FontWeight.w300, color: CattleColors.blackshade)),
        ],
      ),
    );
  }
}
