package fullstack_fox.Repositories;

import fullstack_fox.Entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    User findByFirebaseUid(String firebaseUid);
}
