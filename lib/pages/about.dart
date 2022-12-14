import 'package:e_learning_app/data/constants.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About the App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas laoreet magna a viverra rutrum. Morbi non pulvinar turpis, ac condimentum sapien. In hac habitasse platea dictumst. Suspendisse hendrerit nisi nec urna vulputate, ut molestie nunc pellentesque. Sed convallis risus ut dui pellentesque iaculis. Aliquam erat volutpat. Quisque pretium pellentesque augue in mollis. Integer ex lacus, fermentum in orci et, mattis condimentum diam.",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone,
                      ),
                    ),
                    SelectableText(
                      "+234 8163351109",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.mail,
                      ),
                    ),
                    Flexible(
                      child: SelectableText(
                        "ismaeelmuhammad123@gmail.com",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_pin,
                      ),
                    ),
                    Flexible(
                      child: SelectableText(
                        "Kano State, Nigeria, Africa, Earth, Milky way.",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
