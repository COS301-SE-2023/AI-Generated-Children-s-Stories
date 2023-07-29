package fullstack_fox.Controllers;

import fullstack_fox.Repositories.LikedRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LikedController {
    @Autowired
    LikedRepository likedRepository;
}
