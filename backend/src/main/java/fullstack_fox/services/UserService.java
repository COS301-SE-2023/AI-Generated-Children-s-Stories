package fullstack_fox.services;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User authenticateFirebaseToken(String token) throws FirebaseAuthException {

        //verify that the token is still valid, and the user can sign in
        FirebaseToken verifiedToken = FirebaseAuth.getInstance().verifyIdToken(token);

        //get the user id from the token
        String uid = verifiedToken.getUid();

        System.out.println("userID: " + uid);

        //find the user in the repository, otherwise create a new user
        User user = userRepository.findByFirebaseUid(uid);

        //check if user exists
        if (user == null) {
            //create a new user if not existing
            user = new User();
            user.setFirebaseUid(uid);
            user.setFirebaseToken(token);

            //write to the database
            userRepository.save(user);
        }

        return user;

    }
}
