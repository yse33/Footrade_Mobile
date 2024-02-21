class AppStrings {
  // Login and Register
  static const String usernameLabel = 'Username';
  static const String emailLabel = 'Your Email';
  static const String passwordLabel = 'Password';
  static const String passwordRepeatLabel = 'Repeat Password';
  static const String registerButton = 'Register';
  static const String loginButton = 'Login';
  static const String promptRegister = 'Don\'t have an account?';
  static const String promptLogin = 'Already have an account?';
  static const String registerText = 'Register now';
  static const String loginText = 'Log in';
  static const String forgotPassword = 'Forgot password?';
  static const String usernameEmpty = 'Please enter your username';
  static const String emailEmpty = 'Please enter your email';
  static const String passwordEmpty = 'Please enter your password';
  static const String passwordRepeatEmpty = 'Please repeat your password';
  static const String passwordMismatch = 'Passwords do not match';
  static const String snackbarErrorTitle = 'Oh no! Something went wrong';

  // Preference
  static const String sizeDialogTitle = 'Sizes';
  static const String sizeDialogConfirm = 'OK';
  static const String brandDialogTitle = 'Pick your favourite brands';
  static const String sizeButtonText = 'Pick your shoe sizes';
  static const String setPreference = 'Next';
  static const List<String> brandNames = [
    'Nike', 'Adidas', 'Puma', 'Converse', 'Vans'
  ];
  static const List<String> brandSizes = [
    'EU 36', 'EU 36.5', 'EU 37', 'EU 38',
    'EU 38.5', 'EU 39', 'EU 40', 'EU 40.5',
    'EU 41', 'EU 42', 'EU 42.5', 'EU 43',
    'EU 44', 'EU 44.5', 'EU 45', 'EU 45.5',
    'EU 46', 'EU 47', 'EU 47.5', 'EU 48',
    'EU 48.5', 'EU 49', 'EU 49.5', 'EU 50',
    'EU 50.5', 'EU 51.5', 'EU 52.5'
  ];
  static const String preferenceFailed = 'Please select at least one brand and size';

  // Home
  static const String salesTitle = 'Sales For Me';
  static const String favoritesTitle = 'Favorites';
  static const String homeTitle = 'Home';
  static const String forMeTitle = 'For Me';
  static const String inboxTitle = 'Inbox';
  static const String settingsTitle = 'Settings';
  static const String logoutTitle = 'Logout';

  // Search
  static const String searchEmpty = 'Please enter a search term';
  static const String searchResultEmpty = 'No shoes found for: ';
  static const String searchFailed = 'Failed to search for shoes for: ';
  static const String suggestionsEmpty = 'Please enter a search term';
  static const String suggestionsResultEmpty = 'No suggestions found for: ';
  static const String suggestionsFailed = 'Failed to get suggestions for: ';
  static const String loadMore = 'Load more';

  // Shoe Preferences
  static const String shoePreferencesEmpty = 'There are currently no shoes on sale that match your taste.';

  // Shoe Detail
  static const String shoeDetailTitle = 'Shoe Details';
  static const String shoeDetailProvider = 'Go to ';

  // Shoe favorites
  static const String shoeFavoritesEmpty = 'You have no favorite shoes';
  static const String shoeNotOnSale = 'Not on sale';

  // API Service Errors
  static const String tokenNotFound = 'Token not found';
  static const String usernameNotFound = 'Username not found';
  static const String failedRegister = 'Failed to register user';
  static const String failedLogin = 'Failed to login user';
  static const String failedSavePreference = 'Failed to save user preference';
  static const String failedSearch = 'Failed to search for sales';
  static const String failedSuggestions = 'Failed to get suggestions';
  static const String failedSetFavorite = 'Failed to set favorite';
  static const String failedGetShoePreferences = 'Failed to get shoes for user';
  static const String failedGetShoeDetail = 'Failed to get shoe detail';
  static const String failedGetShoeFavorites = 'Failed to get favorite shoes';
  static const String failedSaveDeviceToken = 'Failed to save device token';
}