package fullstack_fox.Controllers;

import com.google.firebase.auth.FirebaseAuthException;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.UserRepository;
import fullstack_fox.services.UserService;
import org.json.JSONObject;
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
    private UserRepository userRepository;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }


    @PostMapping("/logout")
    public ResponseEntity<String> logout(@RequestBody Long id) {

        System.out.println("Logging out...");

        try {
            //set the api token to null
            userService.nullifyApiToken(id);

            JSONObject response = new JSONObject();
            response.put("status", "success");
            return ResponseEntity.ok(response.toString());

        } catch (Exception e) {
            JSONObject response = new JSONObject();
            response.put("status", "failed");
            response.put("error", e.toString());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response.toString());
        }
    }

    @PostMapping("/authenticate")
    public ResponseEntity<String> authenticateUser(@RequestBody String tokenBody) {
        //print the response:
        System.out.println("Got token at backend: ");
        System.out.println(tokenBody);

        try {
            User user = userService.authenticateFirebaseToken(tokenBody);
            System.out.println("Success");

            JSONObject response = new JSONObject();
            response.put("status", "success");
            response.put("id", user.getId());

            user.generateAPIToken();
            userRepository.save(user);

            //update in the repo

            response.put("api_token", user.getApiToken());
            return ResponseEntity.ok(response.toString());

        } catch (FirebaseAuthException e) {

            System.out.println("Exception authenticating");

            JSONObject response = new JSONObject();
            response.put("status", "failed");
            response.put("message", "authentication failed");

            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response.toString());
        }
    }

}
