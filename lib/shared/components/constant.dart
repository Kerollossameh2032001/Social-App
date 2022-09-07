import '../../models/notification_model.dart';

String savedUId = '';
List<NotificationModel> currentNotifications=[];
int count = 0 ;

/*Sign Out
* ElevatedButton(
          onPressed: () async {
            CacheHelper.removeData(key: 'uId').then((value) {
              if (value) {
                navigateAndReplacement(context, LoginScreen());
                GoogleSignIn().signOut();
              }
            });
          },
          child: Text('sign Out'),
        )
*/