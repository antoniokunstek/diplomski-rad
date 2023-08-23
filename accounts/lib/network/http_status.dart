enum HttpStatus {
  OK,
  NOT_FOUND
}

extension HttpStatusCodes on HttpStatus {
  int get status {
    switch(this) {
      case HttpStatus.OK:
        return 200;
      case HttpStatus.NOT_FOUND:
        return 404;
      default:
        return 0;
    }
  }
}