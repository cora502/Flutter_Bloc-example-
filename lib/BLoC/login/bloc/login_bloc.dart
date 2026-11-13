import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // BLoC Memory to hold dynamic data between screens
  String savedEmail = "";
  String savedName = ""; 

  LoginBloc() : super(LoginInitial()) {
    
    // 1. Handle Login
    on<LoginSubmitEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await Future.delayed(const Duration(seconds: 1)); // Simulate network
        if (event.email.isNotEmpty && event.password.isNotEmpty) {
          savedEmail = event.email;
          
          // If they didn't register first, create a fallback name from the email
          if (savedName.isEmpty || savedEmail != event.email) {
            savedName = event.email.split('@')[0];
          }
          
          emit(LoginSuccess());
        } else {
          emit(LoginFailure("Email and password cannot be empty"));
        }
      } catch (e) {
        emit(LoginFailure("An error occurred during login."));
      }
    });

    // 2. Handle Registration
    on<RegisterSubmitEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        if (event.name.isNotEmpty && event.email.isNotEmpty && event.password.length >= 6) {
          // Save the exact name and email the user typed
          savedName = event.name;
          savedEmail = event.email;
          emit(RegisterSuccess());
        } else {
          emit(LoginFailure("Please fill all fields (Password min 6 chars)"));
        }
      } catch (e) {
        emit(LoginFailure("An error occurred during registration."));
      }
    });

    // 3. Handle Profile Loading
    on<LoadProfileEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await Future.delayed(const Duration(milliseconds: 500));
        // Pass the saved data to the UI
        emit(ProfileLoaded(name: savedName, email: savedEmail));
      } catch (e) {
        emit(LoginFailure("Could not load profile data."));
      }
    });

    // 4. Handle Logout
    on<LogoutEvent>((event, emit) {
      savedEmail = "";
      savedName = "";
      emit(LoginInitial());
    });
  }
}