import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;

public class ManipulateDatabase {
    public ManipulateDatabase(String host, String port, String database, String cp, String username, String password, String sqlManipulation)
    {

                String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?characterEncoding=" + cp;
                try {

                    // Get a connection.
                    Connection connection = DriverManager.getConnection(url, username, password);
                    // Create and execute Update.
                    Statement statement = connection.createStatement();
                    statement.executeUpdate(sqlManipulation);
                    // Close connection.
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();


        }
    }
}
