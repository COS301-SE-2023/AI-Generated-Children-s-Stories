package fullstack_fox;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;

public class GUI {
    private ArrayList<String> inputs;

    public GUI() {
    }

    public void displayStoryInputForm() {
        inputs = new ArrayList<>();

        JTextField storyIdeaField = new JTextField(20);
        JTextField ageField = new JTextField(20);

        JPanel panel = new JPanel(new GridLayout(3, 2));
        panel.add(new JLabel("Story Idea:"));
        panel.add(storyIdeaField);
        panel.add(new JLabel("Age:"));
        panel.add(ageField);

        int option = JOptionPane.showConfirmDialog(null, panel, "AI Story Generator", JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);

        if (option == JOptionPane.OK_OPTION) {
            String storyIdea = storyIdeaField.getText();
            String age = ageField.getText();
            inputs.add(storyIdea);
            inputs.add(age);
        }
    }

    public ArrayList<String> getInputs() {
        return inputs;
    }
}
