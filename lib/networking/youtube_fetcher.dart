import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/youtube/v3.dart';

// Replace this with the actual contents of your service account's private key
const serviceAccountKeyJson = r'''
{
 "type": "service_account",
  "project_id": "perfect-day-375918",
  "private_key_id": "2aed70c0b9fdc893c3b7beb7173b9f4c37a6d774",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCtrYStgJ9teAit\nhiBMkPbGCGpk186e4vNllDt+KxBRhedwpienbBbsizFw9zR1/2Nwt3+vI3KRgN8d\nHm1yLqNChsfbzJKFNIEHJZjL1zo3lV0ARPbowwTxN/UJTK3RsvH7xDBx/fmDsqCD\ngP132DAl7uQdeGic6kpf2kwoPymrryCOKT9Cr6lTY2TUQq+SQMfRAgynvYX/DuC7\nfsdlCYFWJoJhKzCXcaPz6mVNMPeTMd9MLB6wkenW3hH176A3d23GGMJ5wlv5lSL1\nqBEBGwOTJPJj1jK2+0OeLj8heVEpBFH+zS+BIqIJjJAHDZbd3TtD0yxG05wqj4PW\nXE9uwRenAgMBAAECgf8w2Jx4L7SnFRtbsl1jK2I8UCGcOxXhmfLantYcpf/w7bgp\n9pEwhTXtUTiWjPA0P5+4E+PVXiLayWP2zJf7hSJlk4KiTubmj926JNjUe7Pj7h45\n9St8S10YeqRv+SDp2Wo1ZPg7FzMV1ydN1Pl0u1jPUmDV6QeDGmHQk5TXvOv7XM3j\n7ECs6YQS0w0YqkS8/jr8yfoTziroP3JnfA2GNQZOXyNw0GdLNxqUjywlptlWS7cl\n6nqerG0kaKWRLWAW7MzEuylm8yMJIkiCX6RiWIj/eNrtLWaF2Xm94/GN5BCVAh4x\nqspkvMMuo8S2b1D5K5p0ypnvwNl136JLBOeP08ECgYEA9GhK2Sar6ZZkH7FHr7VJ\ni6gMQrD1U4jTmGaV3qFLB+wH9YN07RuD0RWGZnhv8q6TmqYHG55jcfO4rg/hnsQj\nV4r8eW9nf32YFCOBF2WcoFxwT5kmLjK+7S7ZozVQE5CrRX/ec66rZwZeK1zpHbAm\ncbjomsqRf9Fdv77kBZkMXjMCgYEAteplAG002K2QmsBvCRh65uVV6nBx/iaIPubu\nZS18hc/STYiMJqfzhV+Wpvx9ekQahqBYHZxOTeAtQG3Kp5ztXm6OT62DnIk/esGY\nNunCOuFYtrU9E84DdFUj8zr40T8zARwkHyl6O0xrA2lre0htoDQt61dxGAhmw3/Q\neYv+RL0CgYEAsF3CBUk+rOT1g1kuXcD4PWsazdVcctc9ua/tXiYOOr08URJ3gdJl\nIK/juHYYcos/wE0mu+tj34r8Lb8QFL18s2N8JTUa/ojnAUFNmlCc4atS8F2Xi6ba\n19UDAB8slbHDpfdL0zasQT/7HFeDcQT3+QBx+aFLtWyjtgZODSwQHLkCgYAjoqTi\nboIZp/ZZujSGDZuVu3sXD6vk41txJv+wJjbsZ4eE1KjPsbrMd6slTvStjMW9dY+N\nTV8xdianJlq6ds0w4GtURGMxuNkMjPvqVeRMcHRWZi5uwL6AfWUrcnPnWX/+Sarx\nx8g/8XpNEsuRPODsrwwHu/tVf9/RkCoghUHr6QKBgFxBSD17E+/h7UiFnB1LzRcG\n5/c727LrBRXXsWAV/XLGuYGlQqyRoZU6V8noZ1tgJLZBfQMV1c4RliWQKsB6hSpH\nEhPS0Rvmm0W4bLbSol1NAUOC+XNOmuTUrB6rNzqXQJf5LRlPvUoghJDaW6vL5En+\neDzJNsM9HSBNuZfx5lDp\n-----END PRIVATE KEY-----\n",
  "client_email": "ethiopianidol@perfect-day-375918.iam.gserviceaccount.com",
  "client_id": "114729381672270190201",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ethiopianidol%40perfect-day-375918.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

Future<List<PlaylistItem>> fetchVideos() async {
  // Load the service account's private key from a string
  var credentials = ServiceAccountCredentials.fromJson(serviceAccountKeyJson);

  // Obtain an authenticated HTTP client using the service account's credentials
  var client = await clientViaServiceAccount(credentials, [YouTubeApi.youtubeReadonlyScope]);

  // Use the authenticated HTTP client to make authorized API calls
  var youtube = YouTubeApi(client);
  var channel_id = 'UCp9pS23Vw1n8WpcpZBDJNmA'; // EBC Entertainment channel ID
  var response = await youtube.playlists.list(
    ['snippet'],
    channelId: channel_id,
  );
  var playlist_id;
  for (var item in response.items ?? []) {
    if (item.snippet?.title == 'የኢትዮጵያ አይዶል Ethiopian Idol') {
      playlist_id = item.id;
      break;
    }
  }
  var videos = <PlaylistItem>[];
  var page_token;
  while (true) {
    var response = await youtube.playlistItems.list(
      ['snippet'],
      playlistId: playlist_id,
      maxResults: 10,
      pageToken: page_token,
    );
    videos.addAll(response.items ?? []);
    page_token = response.nextPageToken;
    if (page_token == null) break;
  }
  videos = videos.sublist(10);
  return videos;
}
