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
  String getAll(int pageNumber) {
    return 'group/page/$pageNumber/search';
  }

  final String create = "group";

  String getAllOfUser(String accountID, int pageNumber) {
    return 'group/user/$accountID/page/$pageNumber/search';
  }

  String createEvent(String groupId) {
    return "group/$groupId/event";
  }

  String joinGroup(int groupID) {
    return 'group/$groupID/join';
  }

  String getAllJoinGroupRequest(String groupID, int page) {
    return 'group/$groupID/join/page/$page';
  }

  String acceptJoinGroupRequest(String groupID, String joinRequestID) {
    return 'group/$groupID/join/$joinRequestID';
  }

  String rejectJoinGroupRequest(String groupID, String joinRequestID) {
    return 'group/$groupID/join/$joinRequestID';
  }

  String getEventsOfGroup(String groupID, int page) {
    return 'group/$groupID/event/page/$page';
  }

  String getMembersOfGroup(String groupID, int page) {
    return 'group/$groupID/member/page/$page';
  }
}

class _FileEndPoints {
  final String getFile = 'file/';
}

class _EventEndPoints {
  String getAll(int pageNumber, String? filter) {
    return 'event/page/$pageNumber/search/${filter ?? ""}';
  }
}

class _RequestEndPoints {
  final String createRequest = 'supportRequest';

  String getAll(int pageNumber) {
    return 'supportRequest/page/$pageNumber/search';
  }

  String getAllOfUser(String accountID, int pageNumber) {
    return 'supportRequest/account/$accountID/page/$pageNumber/search';
  }

  String createPersonalContribute(String supportRequestId) {
    return "supportRequest/$supportRequestId/contribute";
  }

  String getPersonalsContribute(String supportRequestId, int page) {
    return "supportRequest/$supportRequestId/contribute/page/$page";
  }
}
