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

To copy to ec2 server | scp -i fsf-ssh-key.pem backend-0.0.1-SNAPSHOT.jar ubuntu@ec2-13-245-255-235.af-south-1.compute.amazonaws.com:/home/ubuntu
To run in background of ec2 server | nohup java -jar backend-0.0.1-SNAPSHOT.jar &
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