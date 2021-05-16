import 'package:flutter/material.dart';
import 'package:udemy_flutter/social_app/shared/styles/colors.dart';
import 'package:udemy_flutter/social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            margin: const EdgeInsets.all(8),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  image: NetworkImage(
                    'https://image.freepik.com/free-photo/shot-unrecognizable-man-demonstrates-victroy-sign-through-torn-hole-yellow-paper_273609-25539.jpg',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Communicate with your friends',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            separatorBuilder: (context, index) => SizedBox(
              height: 8,
            ),
            itemCount: 10,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildPostItem(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    'https://image.freepik.com/free-photo/photo-unsure-doubtful-young-woman-holds-chin-looks-right-doubtfully-feels-hesitant_273609-18353.jpg',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Medhat Mohamed',
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.check_circle_outline_outlined,
                            color: defaultColor,
                            size: 12,
                          ),
                        ],
                      ),
                      Text(
                        '15/5/2021 10:45 PM',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(height: 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                IconButton(
                  icon: Icon(
                    IconBroken.More_Circle,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                height: 1,
                thickness: 1,
              ),
            ),
            Text(
              'Lorem Ipsum is simply dummy text of the printing ' +
                  'and typesetting industry. Lorem Ipsum has been the ' +
                  'industry\'s standard dummy text ever since the 1500s, ' +
                  'when an unknown printer took a galley of type and ' +
                  'scrambled it to make a type specimen book.',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    height: 1.2,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 3,
                      ),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          height: 1,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#FreePlastine',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: defaultColor,
                                  height: 1,
                                ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 3,
                      ),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          height: 1,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#Flutter',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: defaultColor,
                                  height: 1,
                                ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://image.freepik.com/free-photo/photo-unsure-doubtful-young-woman-holds-chin-looks-right-doubtfully-feels-hesitant_273609-18353.jpg',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 20,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '1200',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Chat,
                          size: 20,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '120 comments',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                height: 1,
                thickness: 1,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/photo-unsure-doubtful-young-woman-holds-chin-looks-right-doubtfully-feels-hesitant_273609-18353.jpg',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Write a comment...',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(height: 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Like',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.share,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Share',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
