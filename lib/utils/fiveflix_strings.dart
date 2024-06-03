abstract class FiveflixStrings {
  static const String appName = 'FiveFlix';
  static const String appFontFamily = 'NetflixSans';
  static const String errorLoadingMessage = 'Error loading data';
  static const String errorMessage = 'Whoops, something went wrong...';
  static const String addItemFavoriteSucess = 'Added to your favorites!';
  static const String removeItemFavoriteSucess = 'Removed from your favorites!';
  static const String emptyMediaMessageSearch =
      'No movies found with your search';
  static const String emptyMessageFavorite = 'No favorites yet!';
  static const String baseUrlApiTMDB = 'https://api.themoviedb.org/3';
  static const String baseUrlImageApi = 'https://image.tmdb.org/t/p';
  static const String urlImagePoster = '$baseUrlImageApi/w220_and_h330_face';
  static const String urlImagePosterOriginal = '$baseUrlImageApi/w500';
  static const String urlImagePlaceholder =
      'https://fakeimg.pl/100x100?text=No+image';
  static const String endpointPopularMovies = '$baseUrlApiTMDB/movie/popular';
  static const String endpointPopularSeries = '$baseUrlApiTMDB/tv/popular';
  static const String endpointMedia = '$baseUrlApiTMDB/';
  static const String endpointUpcoming = '$baseUrlApiTMDB/movie/upcoming';
  static const String endpointGenre = '$baseUrlApiTMDB/genre/';
  static const String endpointSearch = '$baseUrlApiTMDB/search/movie?&query=';
  static const String endpointTopRated = '$baseUrlApiTMDB/movie/top_rated';
  static const String endpointNews = '$baseUrlApiTMDB/movie/now_playing';
  static const String endpointTopRatedTV = '$baseUrlApiTMDB/tv/top_rated';
  static const String endpointCast = '/credits';
  static const String endpointTrailer = '/videos';
  static const keyJsonResults = 'results';
  static const keyJsonCast = 'cast';
  static const String endpointList = '/list';
  static const String endpointGenderList = '$baseUrlApiTMDB/genre/movie/list';
  static const String endpointDiscoverGender =
      '$baseUrlApiTMDB/discover/movie?with_genres=';
  static const keyJsonGenre = 'genres';
  static const error401 = 'Unauthorized access. Please check your credentials.';
  static const error404 = 'Resource not found. Please check the URL.';
  static const errorDefault = 'Server error. Please try again later.';
  static const storyLineIsEmpty = 'No story line available.';
  static const specialGame = 'Movie Roulette 🎰';
  static const specialGameText = 'Don\'t know what to watch next?';
  static const specialGameSubtitle = 'Take a chance on something new in ';
  static const String baseUrlApiGames =
      'https://flixfive-5db87-default-rtdb.firebaseio.com/.json';
  static const apikey = 'INSERT_YOUR_API_KEY_HERE';
}
