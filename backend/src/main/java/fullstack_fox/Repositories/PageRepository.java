package fullstack_fox.Repositories;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import fullstack_fox.Entities.Page;
import fullstack_fox.Entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PageRepository extends CrudRepository<Page, Long> {

}