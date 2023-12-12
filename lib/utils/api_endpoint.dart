class ApiEndPoints {
  static final String baseURL = 'https://multiplatform-backend.vercel.app/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
  static _GroupEndPoints groupEndPoints = _GroupEndPoints();
  static _FileEndPoints fileEndPoints = _FileEndPoints();
  static _EventEndPoints eventEndPoints = _EventEndPoints();
  static _RequestEndPoints requestEndPoints = _RequestEndPoints();
}

class _AuthEndPoints {
  final String register = 'auth/register';
  final String login = 'auth/login';
}

class _GroupEndPoints {
  final String getAll = 'group/page/';
  String getAllOfUser(String accountID, int pageNumber) {
    return 'group/user/$accountID/page/$pageNumber';
  }
}

class _FileEndPoints {
  final String getFile = 'file/';
}

class _EventEndPoints {
  String getAll(int pageNumber) {
    return 'event/page/$pageNumber';
  }
}

class _RequestEndPoints {
  final String createRequest = 'supportRequest';
}