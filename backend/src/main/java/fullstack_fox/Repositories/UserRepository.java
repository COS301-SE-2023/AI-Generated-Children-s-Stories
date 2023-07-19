package fullstack_fox.Repositories;

import fullstack_fox.Entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByFirebaseUid(String firebaseUid);
}
