import 'package:flutter/material.dart';

import '../ui/CustomColorScheme.dart';
import '../widgets/CourseList.dart';

class Dashboard extends StatelessWidget {

   const Dashboard({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Image.asset('assets/iconLogo.png'),
        title: Text("EduSphere",style: TextStyle(color: customColorScheme.tertiaryFixed),),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Courses",style: Theme.of(context).textTheme.bodyLarge),
            ),
            CourseList()
          ],
        ),
      ),
    );
  }
}
