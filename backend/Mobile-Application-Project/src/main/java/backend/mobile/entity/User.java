package backend.mobile.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String name;

    @Pattern(regexp = "male|female")
    private String gender;

    @NotNull
    @Email
    @Column(unique = true)
    private String email;

    @Min(1)
    @Max(4)
    private Integer level;

    @NotNull
    @Size(min = 8)
    private String password;
}