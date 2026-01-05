// Suggested helper for token management
class TokenStorage {
  static String? _token = '35|mDjJoUInN5TBRvX3vuqkeHvCjiiuHGLgqzIbL52u2aedb762';

  // Call this during login to save the token
  static void setToken(String token) => _token = token;

  // The interceptor will call this to get the token
  static String? getToken() => _token; 
}