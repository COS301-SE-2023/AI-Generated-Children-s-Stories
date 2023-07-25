package fullstack_fox.services;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void nullifyApiToken(Long id) {
        Optional<User> user = userRepository.findById(id);

        user.ifPresent(u -> {
            u.nullifyApiToken();
            userRepository.save(u);
        });
    }

    public User authenticateFirebaseToken(String token) throws FirebaseAuthException {

        //verify that the token is still valid, and the user can sign in
        FirebaseToken verifiedToken = FirebaseAuth.getInstance().verifyIdToken(token);

        //get the user id from the token
        String uid = verifiedToken.getUid();

        System.out.println("userID: " + uid);

        //find the user in the repository, otherwise create a new user
        User user = userRepository.findByFirebaseUid(uid);

        //TODO: update api token and send back to frontend

        //check if user exists
        if (user == null) {
            //create a new user if not existing
            user = new User(uid);

            //write to the database
            userRepository.save(user);
        }

        if (user.getApiToken() == null) { //generate a new token
            user.generateAPIToken();
        }

        return user;

    }
}
