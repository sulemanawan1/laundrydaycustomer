import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  GetServerKey._();
  static Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database'
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "laundryday-ef178",
        "private_key_id": "a7180ff61ae9e1e578ff455c66cc4a9190f32b4f",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDlVLdYo3y1UM0n\nlUWg+drFXvGEnOfyZhmSDzzv30Ww2lPdDG5TNsHpYRYaSZx8095+HeQe3JPZTbrb\n3wiux354xhpzNk7Mcxdh4xdmME+1aIULLrKw2riogvJeP6AicQEPHc9x4KWH64YV\nay0Lm56h0zjKkGFR/go2My7dffyuaJdYM8GJ62TdOvip4HP/n50XQjNXbyDdwT/F\nUjTiky3ua+dBpQ5OkxuvSDstzYFhB2P+p1ie1b7Ua1b5il+abqqX7H0QU90HWcpY\n+sqrewfFIHR++Kn/v/TozOW3HYw4Hj6aLJ3dNQMZ0dbYml073UAwSr/EKf0L+rrQ\nTp29KkepAgMBAAECggEACIRAui7OyFBZC2xx5VxctrIOcm19+FS4rrcYfRNZHAwX\noOC/ziD9SuSl9Kb22UnoUYhcUEBtJdz1oLRj4ahwoXKV8+EN7xjNGFUIfu0yC0Yi\nPrvmu0ZRekHsAfpcljrac7cYh52fTXC+ji1omFhDUrYskz/mZVbzsSHtznWfJyjo\nM034sRPO8OVPH6kKTdq+i/tPfmWLWsS4K0KTXkAU1t3us02yiG3N7ai31SCKrDTv\npp41HN2RTCOVQhtDxbipQndASeukpdXuKf+2tqRV7HVSFQR7Q8K4NbT7cKrU8oEd\n0qeLfq7TdIQZgO/uS6IuHDO/slE1rIkstuahaiwgswKBgQD51xAuhn0O2gcEc/lQ\nBAPfzqAXTtiErzJu8if5FG9AzXvKTm3rnjd+HwXD/LFNa76M6S3uEogMBYj3jJnd\nOeTH/SKld6WfBR1cgZE5DsVNx1qjtwQpJLyNiOPyLPXizS5wwGGxht+2lBafxtN8\nTHjjH2CDBFKcbzRpuNafwe/TWwKBgQDq/DQbJrhdr977GnM/zCpTldFx4HllJ8QH\nHpLXz6u6DL/GJgephXXAS6oSlQxOYsCAdZMcAMsPfQvX8kHzrdsSU8VK4J20Iefc\nfBus4zIHiJJ7SJsVvD+o5PcDUa16ilzK8n1ek/jl3K1zlNNIjU+HbrgBUETFAIo6\n/r/RKKDUSwKBgQC4IBpp323NAzvGuV3U7ZCZYaM0akRBzQhDIa358Ghpfsarew+h\nZPIKvfw2y0U0BKLjIHpcCUZAbdfacMF4e9Ey3kipX7ssrc1MvqRzQ4J/ZttS6m9j\njxJy0J8FfMMeCg8ew3l8JyU6Xnsp95Mm+Qjigd5T0Fy9s2sSO0nZZUlFHwKBgCND\ng+JLNkHBAdp3BrKdRgDTK+JGCJG4nP9ghDLk1GWQQjtPO7kh8SDReg1d1sHwqejd\nPB1otRB2+I8IqQMTpRuj/KiW+rOsnuoEqfaRBdIBmdHsfHGPlZIYAkW6PSl1mCVQ\nrKXD2QdNza3ZuLdblYLCh9SSoi9aPGRMFKcjzLbvAoGAHjaSbSlycMpmnL5SsT2B\ntkaJdRAEMLVygelT4A4qmJtZp3QeJfzvzuwCVYi42aOS/BEa6K0zaPWRw1yP6Sbo\na4pKbIUGS/6isa1NkxbSpzQ2Rhm1UQLxT1j+zuuNStZQUxNhfS7rf1ydD++BZpmr\nXZ5oPuelIjSltgXy3RHS9sU=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-3i5ca@laundryday-ef178.iam.gserviceaccount.com",
        "client_id": "105552005981689558765",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-3i5ca%40laundryday-ef178.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
