module com.fullstackfox {
    requires transitive javafx.graphics;
    requires javafx.controls;
    requires javafx.fxml;

    opens com.fullstackfox to javafx.fxml;
    exports com.fullstackfox;
}
