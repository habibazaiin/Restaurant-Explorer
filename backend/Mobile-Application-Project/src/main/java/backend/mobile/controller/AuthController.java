package backend.mobile.controller;

import backend.mobile.dto.ApiResponse;
import backend.mobile.dto.RegisterDto;
import backend.mobile.dto.LoginDto;
import backend.mobile.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/signup")
    public ResponseEntity<ApiResponse<?>> signup(@Valid @RequestBody RegisterDto dto) {

        ApiResponse<?> response = authService.registerUser(dto);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<?>> login(@Valid @RequestBody LoginDto dto) {

        ApiResponse<?> response = authService.login(dto);

        return ResponseEntity.ok(response);
    }
}
