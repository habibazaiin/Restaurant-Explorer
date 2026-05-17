package backend.mobile.dto;

import jakarta.validation.constraints.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class RegisterDto {

    @NotNull
    private String name;

    @Pattern(regexp = "male|female")
    private String gender;

    @NotNull
    @Email
    private String email;

    @Min(1)
    @Max(4)
    private Integer level;

    @NotNull
    @Size(min = 8, message = "Password must be at least 8 characters")
    private String password;

    @NotNull
    @Size(min = 8)
    private String confirmPassword;
}
