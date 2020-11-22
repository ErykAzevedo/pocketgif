abstract class FailureHome implements Exception {}

class InvalidTextError implements FailureHome {}

//204
class NotFoundGif implements FailureHome {}

//400
class BadRequest implements FailureHome {}

// 403
class Forbidden implements FailureHome {}

//404
class NotFound implements FailureHome {}

//429
class TooManyRequests implements FailureHome {}

class DatasourceError implements FailureHome {}
