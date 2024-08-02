import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aapkacare/values/screen.dart';

class LastImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Column(
      children: [
        myText(
          textName: "Your journey with Aapka Care Health",
          size: s.width < 1024 ? 20 : 30,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 15,
        ),
        Image.asset(
          'assets/indiamart.jpg',
        ),
        SizedBox(
          height: 20,
        )
      ],
    ).px(100 * s.customWidth);
  }
}

class LeftRightData extends StatelessWidget {
  final String? rightImage;
  final String? leftImage;
  final String heading;
  final String description;

  const LeftRightData({super.key, this.leftImage, this.rightImage, required this.heading, required this.description});

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
      alignment: AlignmentDirectional.center,
      child: Wrap(
        spacing: s.width < 1024 ? 0 : 50,
        runSpacing: 30,
        children: [
          leftImage != null
              ? Container(
                  width: s.width < 1024 ? s.width : 500,
                  height: s.width < 720 ? 200 : 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      leftImage ?? '',
                      fit: BoxFit.fill,
                    ),
                  ))
              : SizedBox.shrink(),
          Container(
            width: s.width / (s.width < 1024 ? 1.2 : 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  heading,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          rightImage != null
              ? Container(
                  width: s.width < 1024 ? s.width : 500,
                  height: s.width < 720 ? 200 : 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      rightImage ?? '',
                      fit: BoxFit.fill,
                    ),
                  ))
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class myText extends StatelessWidget {
  final String textName;
  final FontWeight? fontWeight;
  final Color? color;
  final double size;
  final bool? start;

  const myText({super.key, required this.textName, this.fontWeight, this.color, required this.size, this.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: start == true ? TextAlign.start : TextAlign.center,
      textName,
      style: GoogleFonts.poppins(
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
      ),
    );
  }
}

class Questions extends StatelessWidget {
  final String image;
  final String heading;
  final List<String> questions;
  final List<Widget> questionContents;

  const Questions({
    super.key,
    required this.image,
    required this.heading,
    required this.questions,
    required this.questionContents,
  });

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Container(
      width: double.infinity,
      color: Colors.blue[50],
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
      alignment: AlignmentDirectional.center,
      child: Wrap(
        spacing: s.width < 1024 ? 0 : 50,
        runSpacing: 30,
        children: [
          Container(
            width: s.width / (s.width < 1024 ? 1.2 : 3),
            height: s.width < 720 ? 300 : 500,
            // decoration: BoxDecoration(border: Border.all()),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
              ),
            ),
          ),
          Container(
            width: s.width < 1024 ? s.width : 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  heading,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                WhyWhatWidget(
                  questions: questions,
                  questionContents: questionContents,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WhyWhatWidget extends StatefulWidget {
  final List<String> questions;
  final List<Widget> questionContents;

  const WhyWhatWidget({
    super.key,
    required this.questions,
    required this.questionContents,
  });

  @override
  _WhyWhatWidgetState createState() => _WhyWhatWidgetState();
}

class _WhyWhatWidgetState extends State<WhyWhatWidget> {
  int selectedIndex = 0;

  void toggleContent(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(widget.questions.length, (index) {
            return GestureDetector(
              onTap: () => toggleContent(index),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                decoration: BoxDecoration(
                  color: selectedIndex == index ? Colors.teal.shade300 : Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  widget.questions[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 20),
        widget.questionContents[selectedIndex],
        SizedBox(height: 20),
      ],
    );
  }
}

class circleCheck extends StatelessWidget {
  final String text;

  const circleCheck({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Colors.blue,
          size: 16,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          // '30 Min Procedure',
          style: GoogleFonts.montserrat(fontSize: 14),
        ),
      ],
    );
  }
}

class Box extends StatelessWidget {
  final String image;
  final String number;
  final String text;

  const Box({super.key, required this.image, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 130,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
              width: 100,
              height: double.infinity,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  number,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  final String boldText;
  final String regularText;
  final double? boldSize;
  final double? regularSize;

  const CustomRichText({
    super.key,
    required this.boldText,
    required this.regularText,
    this.boldSize,
    this.regularSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: boldSize ?? 14, height: 2),
            text: boldText,
          ),
          TextSpan(
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: regularSize ?? 12,
            ),
            text: regularText,
          ),
        ],
      ),
    );
  }
}

class baritric extends StatelessWidget {
  final bool? color;
  final String heading;
  final String desc;
  const baritric({
    Key? key,
    this.color,
    required this.heading,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
      color: color == true ? Colors.white : Colors.blue[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            desc,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class ReasonBox extends StatelessWidget {
  final String? image;
  final String headingName;
  final String detailName;
  final double? width;
  const ReasonBox({
    super.key,
    this.image,
    required this.headingName,
    required this.detailName,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image == null
              ? SizedBox.shrink()
              : Image.asset(
                  image!,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
          if (image != null) SizedBox(height: 10),
          myText(
            textName: headingName,
            size: 18,
            fontWeight: FontWeight.bold,
          ),
          myText(
            textName: detailName,
            fontWeight: FontWeight.w400,
            size: 14,
          )
        ],
      ),
    );
  }
}

class FirstBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Container(
      width: s.width,
      color: Colors.blue[50],
      child: Center(
        child: Container(
          width: s.width,
          color: Colors.transparent,
          child: s.width < 720
              ? Column(
                  children: [
                    buildAmberContainer(),
                    buildWhiteContainer(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: buildAmberContainer()),
                    buildWhiteContainer(),
                  ],
                ),
        ).px((s.width < 1270 ? 50 : 250) * s.customWidth),
      ),
    );
  }
}

class buildWhiteContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        'assets/doctor.png',
        fit: BoxFit.fill,
        width: 350,
        // width: s.width / (s.width < 1024 ? 1.2 : 3),
        // height: 350,
      ),
    );
  }
}

class buildAmberContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Text(
            'Your Health Care Journey',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Made',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'Hassle-Free',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //         color: Colors.black,
          //         borderRadius: BorderRadius.circular(5),
          //       ),
          //       padding: EdgeInsets.all(10),
          //       child: Text(
          //         'Get a Call Back',
          //         style: TextStyle(
          //           fontSize: 14,
          //           color: Colors.white,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 10),
          //     Container(
          //       decoration: BoxDecoration(
          //         color: Colors.blue,
          //         borderRadius: BorderRadius.circular(5),
          //       ),
          //       padding: EdgeInsets.all(10),
          //       child: Text(
          //         'Book Consultation',
          //         style: TextStyle(
          //           fontSize: 14,
          //           color: Colors.white,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          SizedBox(height: 10),
          Wrap(
            runSpacing: 10,
            spacing: 20,
            alignment: WrapAlignment.center,
            children: [
              Box(
                image: 'assets/consultation.jpg',
                number: '10000+',
                text: 'Hassle-free Consultation',
              ),
              Box(
                image: 'assets/surgeries.jpg',
                number: '5000+',
                text: 'Smooth surgeries',
              ),
              Box(
                image: 'assets/doctors.jpg',
                number: '500+',
                text: 'Expert Doctors',
              ),
              Box(
                image: 'assets/hospitals.jpg',
                number: '100+',
                text: 'Trusted Hospital',
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
