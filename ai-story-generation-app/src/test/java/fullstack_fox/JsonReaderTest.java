package fullstack_fox;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.net.URISyntaxException;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class JsonReaderTest {

    @Test
    void readJson() {
        JsonReader reader = new JsonReader();
        ArrayList<String> expectedOutput = new ArrayList<>();
        expectedOutput.add("123");
        expectedOutput.add("456");
        expectedOutput.add("789");
        expectedOutput.add("101112");
        expectedOutput.add("131415");
        expectedOutput.add("161718");
        expectedOutput.add("192021");

        try {
            ArrayList<String> output = reader.readJson("configTest.json");

            for (int i = 0; i < output.size(); i++) {
                Assertions.assertEquals(expectedOutput.get(i), output.get(i));
            }
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }
}