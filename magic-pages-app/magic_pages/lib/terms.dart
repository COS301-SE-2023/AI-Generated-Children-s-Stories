import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:magic_pages/wave_widget.dart';
import 'button_widget.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Stack(children: [
                const WaveHeaderWidget(),
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("Terms and Conditions",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 26,
                              )),
                        ),
                        paragraph(
                            "Welcome to the AI Generated Children's Stories mobile application ('the App'). These Terms and Conditions ('Terms') govern your use of the App, so please read them carefully. By accessing or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, you may not use the App."),
                        subHeading("Intellectual Property Rights"),
                        paragraph(
                            "The App and all its content, including but not limited to text, images, illustrations, audio, and software, are the property of Full-Stack Fox or its licensors and are protected by intellectual property laws. You may not reproduce, distribute, modify, or create derivative works based on the App or its content without prior written consent from Full-Stack Fox."),
                        subHeading("User Licence"),
                        paragraph(
                            "Full-Stack Fox grants you a limited, non-exclusive, non-transferable, and revocable licence to access and use the App for personal and non-commercial purposes. This licence does not grant you the right to use the App for any unauthorised purposes, including but not limited to selling, sublicensing, or distributing the content generated by the App."),
                        subHeading("User Guidelines"),
                        paragraph(
                            "You agree not to use the App in any way that:\na) Violates any applicable laws, regulations, or third-party rights;\nb) Harasses, abuses, threatens, or otherwise violates the rights of others;\nc) Impersonates any person or entity or falsely states or misrepresents your affiliation with a person or entity;\nd) Contains any harmful or malicious code that may interfere with the functionality of the App or any related services;\ne) Attempts to gain unauthorised access to the App or any related systems or networks."),
                        subHeading("Privacy Policy"),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                      text:
                                      'Your privacy is important to us. Please refer to our ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xFF000000))),
                                  TextSpan(
                                    text: 'Privacy policy ',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF000000),
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () => Navigator.pushNamed(
                                          context, "/privacyPolicy"),
                                  ),
                                  const TextSpan(
                                      text:
                                      'to understand how we collect, use, and disclose information about you when you use the App.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xFF000000))),
                                ],
                              ),
                            )),
                        subHeading("Stories and Content"),
                        paragraph(
                            "The stories and content generated by the App are provided for entertainment and educational purposes only. Full-Stack Fox does not guarantee the accuracy, completeness, or suitability of the content. You acknowledge that the content may not be error-free, and Full-Stack Fox will not be liable for any reliance you place on the content."),
                        subHeading("Modification and Termination"),
                        paragraph(
                            "Full-Stack Fox reserves the right to modify, suspend, or terminate the App or any part of it at any time without prior notice. We may also terminate your access to the App if you violate these Terms or engage in any unauthorised use of the App."),
                        subHeading("Disclaimer of Warranties"),
                        paragraph(
                            "The App is provided on an 'as is' and 'as available' basis without any warranties, express or implied. Full-Stack Fox disclaims all warranties, including but not limited to implied warranties of merchantability, fitness for a particular purpose, and non-infringement."),
                        subHeading("Limitation of Liability"),
                        paragraph(
                            "In no event shall Full-Stack Fox be liable for any direct, indirect, incidental, consequential, or special damages arising out of or in connection with your use of the App, even if Full-Stack Fox has been advised of the possibility of such damages."),
                        subHeading("Governing Law and Jurisdiction"),
                        paragraph(
                            "These Terms shall be governed by and construed in accordance with the laws of South Africa, without regard to its conflict of laws principles. Any dispute arising under these Terms shall be subject to the exclusive jurisdiction of the courts located in South Africa."),
                        subHeading("Changes to the Terms"),
                        paragraph(
                            "Full-Stack Fox may update these Terms from time to time, and the updated version will be posted on the App. Your continued use of the App after any such changes constitute your acceptance of the updated Terms.\nIf you have any questions or concerns about these Terms, please contact us at fullstackfox5@gmail.com. These Terms and Conditions were last updated on 30 July 2023."),
                      ],
                    ),
                  ),
                ])
              ]))),
      bottomNavigationBar: const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 20.0),
          child: ButtonWidget(message: 'BACK', destination: '/signup')),
    );
  }

  Padding subHeading(var widgetText) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 24.0, right: 24, top: 8.0, bottom: 8.0),
      child: Text(widgetText,
          style: const TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
              fontSize: 20)),
    );
  }

  Padding paragraph(var widgetText) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8.0, left: 24.0, right: 24.0),
      child: Text(
        widgetText,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: 'poppins',
        ),
      ),
    );
  }
}