import 'package:flutter/material.dart';
import '../base_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'TRY :',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/user');
              },
              child: Icon(Icons.account_circle, color: Colors.teal, size: 33),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BaseView(
        currentIndex: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/test');
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.school, size: 40),
                                SizedBox(height: 10),
                                Text('Practice Test',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                Text(
                                  'Master the speaking section by practicing structured tasks.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // 버튼 사이의 간격 추가
                    Container(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/news');
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.article, size: 40),
                                SizedBox(height: 10),
                                Text('Study with News',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                Text(
                                  'Enhance your listening and speaking skills with real-world news.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Learning History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildLearningCard('Task 1', 'Completed on 2024-05-21'),
                    _buildLearningCard('Task 2', 'Completed on 2024-05-20'),
                    _buildLearningCard('Task 3', 'Completed on 2024-05-19'),
                    _buildLearningCard('Task 4', 'Completed on 2024-05-18'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLearningCard(String task, String date) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 200, // 카드의 가로 길이
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                task,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(date),
            ],
          ),
        ),
      ),
    );
  }
}
