package fullstack_fox.Controllers;

import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import java.util.NoSuchElementException;
import java.util.Optional;

@RestController
public class AuthenticateApiCalls {

    private final UserRepository userRepository;

    @Autowired
    public AuthenticateApiCalls(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public boolean authenticateApiKey(Long userId, String apiToken) {
        Optional<User> u = userRepository.findById(userId);

        if (u.isPresent()) {
            User user = u.get();
            if (user.getApiToken().equals(apiToken)) {
                return true;
            }
            return false;
        }
        throw new NoSuchElementException("No user found with id " + userId);
    }

}
