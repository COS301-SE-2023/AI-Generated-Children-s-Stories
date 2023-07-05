package fullstack_fox;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.*;
import org.json.*;

public class JsonReader {

    public JsonReader() {
    }

    public ArrayList<String> readJson(String inFName) throws URISyntaxException {
        try (FileReader fileReader = new FileReader(
                new File(this.getClass().getResource("resources/" + inFName).toURI()))) {

            JSONTokener tokener = new JSONTokener(fileReader);
            JSONObject jsonObject = new JSONObject(tokener);

            ArrayList<String> configList = new ArrayList<>();
            configList.add(jsonObject.optString("applicationID"));
            configList.add(jsonObject.optString("channelID"));
            configList.add(jsonObject.optString("guildID"));
            configList.add(jsonObject.optString("sessionID"));
            configList.add(jsonObject.optString("botAuthorization"));
            configList.add(jsonObject.optString("userAuthorization"));
            configList.add(jsonObject.optString("chatGPTKey"));

            this.configUnitTest(configList);
            return configList;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    private void configUnitTest(ArrayList<String> inConfigList) {
        if (inConfigList == null || inConfigList.size() != 7) {
            System.out.println("Config file incorrect");
        } else {
            System.out.println("Config file correct");
        }
    }
}
