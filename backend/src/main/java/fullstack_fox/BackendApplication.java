package fullstack_fox;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/*
To make jar
1. mvn clean package
2. cd target
2. java -jar .\target\backend-1.0-SNAPSHOT.jar
*/

@SpringBootApplication
public class BackendApplication {
	public static void main(String[] args) {
		SpringApplication.run(BackendApplication.class, args);
	}
}
