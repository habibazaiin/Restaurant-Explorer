package backend.mobile.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class ApiResponse<T> {

    private boolean success;
    private String message;
    private T data;
}
