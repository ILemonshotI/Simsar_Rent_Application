// Suggested helper for token management
class TokenStorage {
  static String? _token = '38|nW8iFDFgClx7rNqG6uCrZN5GJm2DgEXn2zYhEphX4bd81cea';

  // Call this during login to save the token
  static void setToken(String token) => _token = token;

  // The interceptor will call this to get the token
  static String? getToken() => _token; 
}