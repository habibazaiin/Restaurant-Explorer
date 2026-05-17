package backend.mobile.service;

import org.springframework.stereotype.Service;
import backend.mobile.dto.ApiResponse;
import backend.mobile.dto.RegisterDto;
import backend.mobile.dto.LoginDto;
import backend.mobile.entity.User;
import backend.mobile.repository.UserRepository;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final JwtService jwtService;

    public AuthService(UserRepository userRepository, JwtService jwtService) {
        this.userRepository = userRepository;
        this.jwtService = jwtService;
    }

    public ApiResponse<?> registerUser(RegisterDto dto) {

        if (!dto.getPassword().equals(dto.getConfirmPassword())) {
            throw new RuntimeException("Password mismatch");
        }

        if (userRepository.findByEmail(dto.getEmail()).isPresent()) {
            throw new RuntimeException("Email already exists");
        }

        User user = new User();
        user.setName(dto.getName());
        user.setGender(dto.getGender());
        user.setEmail(dto.getEmail());
        user.setLevel(dto.getLevel());
        user.setPassword(dto.getPassword());

        userRepository.save(user);

        return new ApiResponse<>(true, "User registered successfully", null);
    }

    public ApiResponse<?> login(LoginDto dto) {

        User user = userRepository.findByEmail(dto.getEmail())
                .orElseThrow(() -> new RuntimeException("Invalid email or password"));

        if (!user.getPassword().equals(dto.getPassword())) {
            throw new RuntimeException("Invalid email or password");
        }

        String token = jwtService.generateToken(user.getEmail());

        return new ApiResponse<>(true, "Login successful", token);
    }
}