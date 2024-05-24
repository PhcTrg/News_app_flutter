import 'package:flutter/material.dart';
import 'package:news_reading/core/app_export.dart';
import 'package:news_reading/model/notification_model.dart';
import 'package:news_reading/provider/home_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> futureNotify;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("call");
    futureNotify = context
        .read<HomeProvider>()
        .getNotifications(context.watch<HomeProvider>().userModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notification'),
        ),
        body: FutureBuilder<List<NotificationModel>>(
          future: futureNotify,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.notifications_active),
                    title: Text('${snapshot.data![index].message}'),
                  );
                },
              );
            }

            return Center(child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
