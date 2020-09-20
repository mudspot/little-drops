import 'package:drops/controllers/stories_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/entities/SDExamCardModel.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/utils/random_data.dart';
import 'package:drops/views/ld_story_view.dart';
import 'package:get/get.dart';

SDExamCardModel card =
  SDExamCardModel(
    image: 'images/sdbiology.png',
    examName: 'Uriel Lee',
    time: 'Elder daughter',
    icon: Icon(
      Icons.notifications_active,
      color: Colors.white54,
    ),
    startColor: Color(0xFF2889EB),
    endColor: Color(0xFF0B56CB),
  );

final StoriesController storiesController = Get.find<StoriesController>();

ImageProvider _storiesImageAsset(String location) {
  if (location==null) location = randomImage();
  return Image.asset(location,height: 35, width: 20,).image;
}

Widget LDStoriesView(BuildContext context) {
  var name = 'Terry';
  return Container(
    child: SingleChildScrollView(
      padding: EdgeInsets.only(top: 20, bottom: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Hi, $name',
                style: boldTextStyle(size: 20),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 250,
              alignment: Alignment.center,
              child: Container(
                width: 180.0,
                margin: EdgeInsets.only(
                  left: 16,
                ),
                padding: EdgeInsets.all(10),
                decoration: boxDecoration(
                  radius: 8,
                  spreadRadius: 1,
                  blurRadius: 4,
                  gradient: LinearGradient(
                    colors: [
                      card.startColor,
                      card.endColor
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white30,
                      child: Image.asset(
                        card.image,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      card.examName,
                      style: secondaryTextStyle(
                          textColor: Colors.white, size: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          card.time,
                          style: secondaryTextStyle(
                              textColor: Colors.white54, size: 18),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Read Stories',
                style: boldTextStyle(size: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Select a story to read.',
                style: secondaryTextStyle(size: 14),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(() => ListView.builder(
                primary: false,
                padding: EdgeInsets.only(bottom: 16),
                itemCount: storiesController.stories.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    width: double.infinity,
                    decoration: boxDecorations(
                      showShadow: true,
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LDStoryView(
                                name:
                                    storiesController.stories[index].data.title,
                                backgroundImages: storiesController
                                    .stories[index].data.backgroundImages),
                          ),
                        );
                      },
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        height: 45,
                        width: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage(
                              'Loading',
                            ),
                            image: _storiesImageAsset(storiesController.stories[index].data.image),
                          ),
                        ),
                      ),
                      title: Text(
                        storiesController.stories[index].data.title,
                        style: boldTextStyle(size: 16),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          storiesController.stories[index].data.description,
                          style: secondaryTextStyle(size: 10),
                        ),
                      ),
                    ),
                  );
                })),
          ]),
    ),
  );
}