abstract class FailureSearch implements Exception {}

class InvalidTextError implements FailureSearch {}

class SearchNotMatch implements FailureSearch {}

//400
class BadRequest implements FailureSearch {}

// 403
class Forbidden implements FailureSearch {}

//404
class NotFound implements FailureSearch {}

//429
class TooManyRequests implements FailureSearch {}

class DatasourceError implements FailureSearch {}
