package fullstack_fox.Repositories;

import fullstack_fox.Entities.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    User findByFirebaseUid(String firebaseUid);


    @Query("select u from User u where u.firebaseUid = 'admin'")
    User getAdminUserId();
}
