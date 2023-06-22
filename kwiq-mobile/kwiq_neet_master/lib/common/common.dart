import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Common {
  //2019-07-31 14:26:02
  static DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  static DateTime getDateTime(String dateTimeStr) {
    if (dateTimeStr == null) {
      return null;
    }
    return DateTime.parse(dateTimeStr);
  }

  static DateTime getCurrentDateTime() {
    return dateTimeFormat.parse(getCurrentDateTimeStr());
  }

  static String getDateTimeStr(DateTime dateTime) {
    if (dateTime == null) {
      return null;
    }
    return dateTimeFormat.format(dateTime);
  }

  static String getDateStr(DateTime dateTime) {
    if (dateTime == null) {
      return null;
    }
    return dateFormat.format(dateTime);
  }

  static String getCurrentDateTimeStr() {
    return dateTimeFormat.format(DateTime.now());
  }

  static DateTime addMinutesToDateTime(DateTime dateTime, int mins) {
    if (dateTime != null && mins != null && mins > 0) {
      return dateTime.add(new Duration(minutes: mins));
    }
    return dateTime;
  }

  static String getTimerValue(int secs) {
    int mins = 0;
    int sec = 0;
    if (secs != null && secs > 0) {
      if (secs > 60) {
        mins = (secs ~/ 60).toInt();
        sec = (secs % 60).toInt();
      } else {
        mins = 0;
        sec = secs;
      }
    }
    return mins.toString() + ":" + sec.toString();
  }

  static String getAboutNEETIntro() {
    return "The National Eligibility and Entrance Test is an entrance examination in India for students who wish to study undergraduate medical courses and dental courses in government or private medical colleges and dental colleges in India. The undergraduate NEET, for MBBS and BDS courses, is currently conducted by the National Testing Agency.";
  }

  static String getAboutNEET() {
    return """
    <h3>About NEET</h3>
    <p>The National Eligibility and Entrance Test is an entrance examination in India for students who wish to study undergraduate medical courses and dental courses in government or private medical colleges and dental colleges in India. The undergraduate NEET, for MBBS and BDS courses, is currently conducted by the National Testing Agency.</p>
    <h3>Exam pattern and structure</h3>
    <p>Exam questions asked from Physics, Chemistry, Botany & Zoology. There are 45 questions from each of the sections. A correct response gives the candidate 4 marks and 1 mark is deducted for every wrong answer. No marks are deducted if the candidate has not attempted a question. The total time duration is of 3 hours.</p>
    <h3>Syllabus</h3>
    <p>The NEET syllabus is prescribed by the Medical Council of India. The syllabus is based on Class 11th & Class 12th subjects.</p>
    """;
  }

  /*
  static String getAboutNEET() {
    return """

    <svg width="103.51mm" height="84.241mm" version="1.1" viewBox="0 0 103.50604 84.241127" xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <g transform="translate(-11.421 -3.5528)">
    <path d="m98.558 87.231c-0.14479-0.30971 0.0315-0.71266 0.3918-0.89544 0.36028-0.18278 1.1603-2.1946 1.7777-4.4708 0.61747-2.2762 1.311-4.0555 1.5411-3.9541 0.23015 0.10142 0.96721 2.0129 1.6379 4.2477 0.67072 2.2348 1.3941 4.1576 1.6075 4.2729 0.92858 0.50177 0.26614 1.3629-1.0484 1.3629-1.2946 0-1.407-0.15526-1.1379-1.5726 0.26956-1.4199 0.15768-1.5726-1.1524-1.5726-1.4608 0-2.6333 1.2859-1.5913 1.7451 0.30803 0.13574 0.56004 0.50628 0.56004 0.82341 0 0.74318-2.2395 0.75486-2.5861 0.01352zm4.0135-4.7465c0-0.49854-0.21411-1.0814-0.4758-1.2952s-0.47581-0.25368-0.47581-0.08857c0 0.1651-0.12996 0.74794-0.2888 1.2952-0.18952 0.65293-0.0259 0.995 0.4758 0.995 0.42054 0 0.76461-0.40789 0.76461-0.90642zm-90.287-11.15c-1.1115-3.3524-1.0209-4.9003 0.16165-2.7623 0.59342 1.0729 0.6748 0.06761 0.6748-8.3357 0-5.9511 0.17948-9.5557 0.4758-9.5557s0.4758 3.6046 0.4758 9.5557c0 8.4033 0.08138 9.4086 0.6748 8.3357 1.1425-2.0657 1.3519-0.54834 0.30032 2.1767l-0.99446 2.5771h41.722c22.947 0 41.632-0.10749 41.523-0.23886-0.44157-0.53202-82.236-62.665-82.495-62.665-0.15376 0 0.05586 0.85751 0.46581 1.9056 0.87577 2.239 0.43529 3.9499-0.55565 2.1582-0.54727-0.98947-0.64107 0.33124-0.64107 9.0257 0 6.3705-0.17819 10.185-0.4758 10.185s-0.4758-3.8143-0.4758-10.185c0-8.6945-0.09381-10.015-0.64107-9.0257-1.111 2.0087-1.3752-0.04661-0.34816-2.7082 0.79874-2.0699 0.86303-2.7662 0.40388-4.3744-1.0398-3.6418 1.4803-5.2832 3.5597-2.3185 0.96489 1.3757 7.1713 6.5954 7.8422 6.5954 0.13387 0-0.03068-0.43659-0.36566-0.97021-0.4089-0.65136-0.45158-1.1784-0.12988-1.6037 0.3217-0.42531 0.96882 0.35867 1.9691 2.3855l1.4899 3.019-1.9777 0.31452c-1.9395 0.30844-1.2473 0.86986 35.813 29.05 22.58 17.17 38.509 28.908 39.575 29.163 1.6888 0.40437 1.7843 0.33934 1.7843-1.2154 0-0.90342 0.21411-1.6426 0.4758-1.6426s0.4758 0.70766 0.4758 1.5726c0 1.8378 0.53027 1.9352 3.357 0.61669 5.9605-2.7803 8.9279-10.906 7.0342-19.262-1.0997-4.8528-5.7801-9.9755-9.114-9.9755-1.1019 0-1.2772 0.259-1.2772 1.8871 0 1.0379-0.21411 1.8871-0.4758 1.8871s-0.4758-0.8492-0.4758-1.8871c0-1.5999-0.18334-1.8871-1.2048-1.8871-3.1217 0-7.2455 3.9638-8.8347 8.492-0.9652 2.7502-1.1988 8.6429-0.44633 11.259 0.64516 2.2434 0.08323 2.3861-2.2434 0.56955-2.2872-1.7857-2.7835-3.2618-0.59324-1.7644l1.4274 0.97586 0.01047-4.2621c0.02417-9.8516 5.0297-16.508 12.425-16.522 13.055-0.02541 17.037 22.806 5.4133 31.037l-1.9095 1.3521-46.391 0.15267-46.391 0.15266zm10.497-58.396c0.65698 0-0.4569-1.0188-4.011-3.6685-2.2629-1.6871-2.7631-1.858-3.2358-1.105-0.45806 0.72967-0.01742 1.297 2.4388 3.1398 1.6488 1.2371 3.283 2.1108 3.6315 1.9415s0.8779-0.30777 1.1764-0.30777zm79.314 50.323c0-1.3839 0.21411-2.5161 0.4758-2.5161s0.4758 1.1323 0.4758 2.5161-0.21411 2.5161-0.4758 2.5161-0.4758-1.1323-0.4758-2.5161zm0-9.4355c0-1.3839 0.21411-2.5161 0.4758-2.5161s0.4758 1.1323 0.4758 2.5161-0.21411 2.5161-0.4758 2.5161-0.4758-1.1323-0.4758-2.5161zm-90.521-7.336c0.38793-0.20695 0.59475-1.7026 0.59475-4.3012s-0.20682-4.0942-0.59475-4.3012c-0.32711-0.1745-0.113-0.33962 0.4758-0.36694 0.86952-0.04033 1.0706 0.28832 1.0706 1.7502 0 1.5414 0.1579 1.76 1.0995 1.522 1.3853-0.35009 2.0639 0.7496 2.3171 3.7548 0.17294 2.0526 0.0705 2.3589-0.78884 2.3589-0.86906 0-0.96528-0.30916-0.80176-2.5761 0.16158-2.24 0.0701-2.547-0.70113-2.3535-1.0793 0.27086-1.51 3.5906-0.5682 4.3799 0.40969 0.34337 0.04562 0.51628-1.0325 0.49037-0.91592-0.02202-1.3977-0.1828-1.0706-0.3573zm87.571-8.5157c0.31403-0.41516 0.57096-2.34 0.57096-4.2774s-0.25693-3.8623-0.57096-4.2774c-0.44408-0.5871-0.06706-0.75484 1.6966-0.75484 1.2472 0 2.6817 0.29302 3.1879 0.65117 0.99113 0.70127 1.2402 2.7874 0.41352 3.4629-0.33346 0.27246-0.23742 0.80761 0.28079 1.5646 0.99385 1.4519 0.55418 3.4935-0.8603 3.9948-0.58014 0.20562-2.0076 0.37771-3.1721 0.38243-1.6468 0.0067-1.9904-0.15915-1.5463-0.74625zm4.777-2.0004c0.18545-1.2914-0.63922-2.2522-1.9459-2.2674-0.61356-0.0071-0.83266 0.49791-0.83266 1.9193 0 1.7318 0.13326 1.9086 1.3044 1.7298 0.82585-0.12602 1.3667-0.63292 1.4742-1.3817zm-0.48545-4.6359c0.12383-1.1527-0.0748-1.4153-1.0706-1.4153-0.99572 0-1.2226 0.29993-1.2226 1.6163 0 1.3164 0.19866 1.579 1.0706 1.4153 0.68798-0.12918 1.1249-0.70678 1.2226-1.6163z" stroke-width=".54708"/>
    </g>
    </svg>


     """;
  }
  */

  static String getAboutKwiqIntro() {
    return "Kwiq academy is founded by passionate professionals from diverse background to make online learning and skill evaluation very interactive and interesting. Our founding team has wide experience in IT, Education and Career Counselling.";
  }

  static String getAboutKwiq() {
    return """
    <h3>About Kwiq</h3>
    <p>Kwiq academy is founded by passionate professionals from diverse background to make online learning and skill evaluation very interactive and interesting. Our founding team has wide experience in IT, Education and Career Counselling.</p>
    <p>We are very proud to launch our mobile android and iOS application for NEET to enable our students to learn and evaluate their learning on the platform..</p>
    <p>Please write to admin@kwiqacademy.in for any suggestions or for any other enquires.</p>
    """;
  }

  static String getSVGString(String innerHtml) {
    String svgStart = "<svg width='150' height='150'>";
    String svgEnd = "</svg>";
    return svgStart + innerHtml + svgEnd;
  }

  static String addHTMLTags(String text) {
    String docType = "<!DOCTYPE html>";

    String htmlStart = "<html>";
    String htmlEnd = "</html>";

    String head =
        "<head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head>";

    String bodyStart = "<body style='margin: 5; padding: 5;'>";
    String bodyEnd = "</body>";

    String divStart = "<div>";
    String divEnd = "</div>";

    String startSpan = "<span style='font-size: 20px !important;'>";
    String endSpan = "</span>";

    return docType +
        htmlStart +
        head +
        bodyStart +
        divStart +
        startSpan +
        text +
        endSpan +
        divEnd +
        bodyEnd +
        htmlEnd;
  }

  static void portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
