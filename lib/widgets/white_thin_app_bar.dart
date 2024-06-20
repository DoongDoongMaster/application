import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/one_line_text_with_marquee.dart';
import 'package:flutter/material.dart';

class WhiteThinAppBar extends AppBar {
  WhiteThinAppBar({
    super.key,
    required String title,
    required String leftText,
    required String rightText,
    required void Function() onPressedLeftLabel,
    required void Function()? onPressedRightLabel,
    IconButton? iconButton1,
    IconButton? iconButton2,
  }) : super(
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: onPressedLeftLabel,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                leftText,
                                style: TextStyles.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 600,
                  child: OneLineTextWithMarquee(
                    title,
                    style: TextStyles.titleMedium,
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (iconButton1 != null) iconButton1,
                      if (iconButton2 != null) iconButton2,
                      if (iconButton1 == null && iconButton2 == null)
                        TextButton(
                          onPressed: onPressedRightLabel,
                          child: Text(
                            rightText,
                            style: TextStyles.bodyLarge,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        );
}
