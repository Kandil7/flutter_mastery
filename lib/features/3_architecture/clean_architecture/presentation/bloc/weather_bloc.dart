import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_weather.dart';
import 'weather_event.dart';
import 'weather_state.dart';

/// WeatherBloc
/// 
/// This class manages the state of the weather feature.
/// It processes events and emits new states based on the results.
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;
  
  WeatherBloc({required this.getWeather}) : super(WeatherInitial()) {
    on<GetWeatherForCityEvent>(_onGetWeatherForCity);
  }
  
  /// Handle GetWeatherForCityEvent
  void _onGetWeatherForCity(
    GetWeatherForCityEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    
    try {
      final weather = await getWeather.execute(event.cityName);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
