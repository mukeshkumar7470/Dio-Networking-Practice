import 'package:flutter/material.dart';
import 'package:rest_api_fetch_using_dio/models/data.dart';
import 'package:rest_api_fetch_using_dio/models/user.dart';
import 'package:rest_api_fetch_using_dio/utils/dio_client.dart';
import 'package:rest_api_fetch_using_dio/widgets/create_user.dart';
import 'package:rest_api_fetch_using_dio/widgets/fetch_user.dart';
import 'package:rest_api_fetch_using_dio/widgets/update_user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'POST API',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const CreateUser(),
              const Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(
                  'GET & DELETE',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const FetchUser(),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const UpdateUser(),
              const Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(
                  'GET (auto fetch)',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: FutureBuilder<User?>(
                  future: _client.getUser(id: '10'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      User? userInfo = snapshot.data;

                      if (userInfo != null) {
                        Data userData = userInfo.data;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(userData.avatar),
                            const SizedBox(height: 8.0),
                            Text(
                              '${userInfo.data.firstName} ${userInfo.data.lastName}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              userData.email,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        );
                      }
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
