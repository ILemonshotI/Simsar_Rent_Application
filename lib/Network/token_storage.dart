// Suggested helper for token management
class TokenStorage {
  static String? _token = '36|GKp0Dr6NsRUgGMk4HzQOkx4ZTp9wj1uVr0KeczGKc7359fe4';

  // Call this during login to save the token
  static void setToken(String token) => _token = token;

  // The interceptor will call this to get the token
  static String? getToken() => _token; 
}


/* Token Examples
admin token:
35|mDjJoUInN5TBRvX3vuqkeHvCjiiuHGLgqzIbL52u2aedb762
owner token:
36|GKp0Dr6NsRUgGMk4HzQOkx4ZTp9wj1uVr0KeczGKc7359fe4
user token:
38|nW8iFDFgClx7rNqG6uCrZN5GJm2DgEXn2zYhEphX4bd81cea
*/
