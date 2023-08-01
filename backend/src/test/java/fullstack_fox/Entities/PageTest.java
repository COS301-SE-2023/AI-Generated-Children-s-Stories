package fullstack_fox.Entities;

import junit.framework.TestCase;
import org.junit.Assert;

public class PageTest extends TestCase {

    public void testGetImage() {
        Story myStory = new Story();
        Page page = new Page("image", "test" , myStory);

        Assert.assertEquals("image", page.getImage());
    }

    public void testGetText() {
        Story myStory = new Story();
        Page page = new Page("image", "test" , myStory);

        Assert.assertEquals("test", page.getText());
    }

    public void testGetStory() {
        Story myStory = new Story();
        Page page = new Page("image", "test" , myStory);
        Assert.assertEquals(myStory, page.getStory());
    }
}