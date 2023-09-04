package fullstack_fox;

import fullstack_fox.Entities.Page;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.PageRepository;
import fullstack_fox.Repositories.StoryRepository;
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
/*
@SpringBootApplication
public class BackendApplication {
	public static void main(String[] args) {
		FirebaseConfig firebaseConfig = new FirebaseConfig();
		SpringApplication.run(BackendApplication.class, args);
	}
}
*/
//to create pages


@SpringBootApplication
public class BackendApplication implements CommandLineRunner {

	@Autowired
	private PageRepository pageRepo;
	@Autowired
	private StoryRepository storyRepo;
	@Autowired
	private UserRepository userRepository;


	public static void main(String[] args) {
		SpringApplication.run(BackendApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		FirebaseConfig firebaseConfig = new FirebaseConfig();
		createUser();
		createStoryAndPage();
	}


	private void createUser() {
		User u = new User("123");
		userRepository.save(u);
	}

	private void createStoryAndPage() {
		Story newStory = new Story("Andy the ant", "trailer");
		storyRepo.save(newStory);

		Page newPage = new Page("image", "text", newStory);
		pageRepo.save(newPage);
		newPage = new Page("image2", "text2", newStory);
		pageRepo.save(newPage);
		newPage = new Page("image3", "text3", newStory);
		pageRepo.save(newPage);
	}

}
