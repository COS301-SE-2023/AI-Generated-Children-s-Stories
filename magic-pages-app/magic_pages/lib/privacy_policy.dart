import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:magic_pages/wave_widget.dart';
import 'button_widget.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
                        const Heading(text: "Privacy Policy"),
                        paragraph("Effective date: 30 July 2023"),
                        paragraph("Full-Stack Fox ('us,' 'we', or 'our') operates the AI Generated Children's Stories mobile application ('the App'). This page informs you of our policies regarding the collection, use, and disclosure of personal information when you use the App."),
                        subHeading("1. Information we collect"),
                        subHeading("1.1 Personal Information:", size: 17),
                        paragraph("While using our App, we may ask you to provide certain personally identifiable information that can be used to contact or identify you. Personally, identifiable information may include but is not limited to:\n● Your name\n● Email address\n● Any other information you voluntarily provide to us"),

                        subHeading("1.2 Usage Data"),
                        paragraph("We may also collect information that your mobile device sends whenever you access the App ('Usage Data'. This Usage Data may include information such as your device's Internet Protocol (IP) address, device name, operating system version, the configuration of the App when utilising our service, the time and date of your use of the App, and other statistics."),

                        subHeading("1.3 Children's Information:"),
                        paragraph("The App is intended for use by children, and we do not knowingly collect personal information from children under the age of 13. If you are a parent or guardian and you become aware that your child has provided us with personal information, please contact us at fullstackfox5@gmail.com. If we become aware that we have collected personal information from children without verification of parental consent, we will take steps to remove that information from our servers."),

                        subHeading("2. Use of Information"),
                        subHeading("2.1 We may use the collected information for various purposes, including but not limited to:", size: 17),
                        paragraph("● Providing and maintaining the App\n● Personalising the user experience\n● Sending you notifications, updates, and promotional materials related to the App (you may opt-out of these communications at any time)\n● Improving and analysing the App's performance and effectiveness\n● Monitoring the usage of the App\n● Detecting, preventing, and addressing technical issues or unauthorised access"),

                        subHeading("3. Disclosure of Information"),
                        subHeading("3.1 3.1 We may disclose your personal information in the following circumstances:", size: 17),
                        paragraph("● To comply with legal obligations or respond to lawful requests from public authorities \n● To protect and defend our rights, property, or safety, and that of our users or others \n● In the event of a merger, acquisition, or sale of all or a portion of our assets, where personal information may be transferred to the acquiring entity"),

                        subHeading("4. Data Security"),
                        paragraph("4.1 We are committed to protecting your personal information and have implemented reasonable security measures to safeguard it. However, please be aware that no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security."),
                        subHeading("5. Your Rights"),
                        paragraph("5.1 You have the right to access, update, or delete the personal information we hold about you. You may also withdraw your consent for us to use your personal information, subject to applicable laws."),
                        subHeading("6. Changes to the Privacy Policy"),
                        paragraph("6.1 We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the \'Effective date\' at the top. You are advised to review this Privacy Policy periodically for any changes."),
                        subHeading("7. Contact Us"),
                        paragraph("7.1 If you have any questions or concerns about this Privacy Policy, please contact us at fullstackfox5@gmail.com."),
                        paragraph("This Privacy Policy was last updated on 30 July 2023.")
                      ],
                    ),
                  ),
                ])
              ]))),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
          child: const ButtonWidget(message: 'BACK', destination: '/signup')
      ),
    );
  }

  Padding subHeading(widgetText, {double size = 20}) {
    final textStyle = TextStyle(
      fontFamily: 'poppins',
      fontWeight: FontWeight.w500,
      fontSize: size,
    );

    return Padding(
        padding:
        const EdgeInsets.only(left: 24.0, right: 24, top: 8.0, bottom: 8.0),
        child: Text(widgetText,
            style: textStyle)
    );
  }

  Padding paragraph(var widgetText) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8.0, left: 24.0, right: 24.0),
      child: Text(
        widgetText,
        style: const TextStyle(
          fontFamily: 'poppins',
        ),
      ),
    );
  }
}

class Heading extends StatelessWidget {
  final String text;
  final bool? addPadding;
  const Heading({
    super.key,
    required this.text,
    this.addPadding
  });

  @override
  Widget build(BuildContext context) {
    return  Text(text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'poppins',
        fontWeight: FontWeight.w500,
        fontSize: 26,
      ),
    );
  }
}