package fullstack_fox;

import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/*
To make jar
1. mvn clean package -DskipTests
2. cd target
2. java -jar .\target\backend-1.0-SNAPSHOT.jar
*/

@SpringBootApplication
public class BackendApplication implements CommandLineRunner {

	@Autowired
	UserRepository userRepository;

	public static void main(String[] args) {
		FirebaseConfig firebaseConfig = new FirebaseConfig();
		SpringApplication.run(BackendApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		insertAdminUser();
	}

	private void insertAdminUser() {

		if (userRepository.getAdminUserId() == null) {
			User adminUser = new User("admin");
			userRepository.save(adminUser);
		}
	}
}