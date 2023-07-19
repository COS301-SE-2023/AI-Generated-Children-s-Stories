package fullstack_fox.Controllers;

import com.google.firebase.auth.FirebaseAuthException;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import fullstack_fox.services.UserService;
import fullstack_fox.Entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/authenticate")
    public ResponseEntity<String> authenticateUser(@RequestBody String tokenBody) {
        //print the response:

        System.out.println("Got token at backend: " + tokenBody);

        tokenBody = tokenBody.substring(6);

        try {
            User user = userService.authenticateFirebaseToken(tokenBody);
            return ResponseEntity.ok("User authenticated. Here is the uid: " + user.getId());
        } catch (FirebaseAuthException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authentication failed: " + e.getMessage());
        }
    }
}
