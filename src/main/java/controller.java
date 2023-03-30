import java.io.IOException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
//this is the controller where we instantiate and call all methods that makes it possible to insert data from the csv file
public class controller {
    private static String host = "localhost"; //host is "localhost" or "127.0.0.1"
    private static String port = "3306"; //port is where to communicate with the RDBMS
    private static String database = "tv3"; //database containing tables to be queried
    private static String cp = "utf8"; //Database codepage supporting Danish (i.e. æøåÆØÅ)

    // Set username and password.
    // -------------------------
    private  static String username = "root";		// Username for connection
    private static String password = "test123";	// Password for username

    public static void main(String[] args) {

        //making a new instance of the class that can load the data from the csv file
        FootagesAndReportersLoader loader = new FootagesAndReportersLoader();
        try {
            //remember to insert your own path to the csv file here. The file is found under resources in this project
            List<FootageAndReporter> footageAndReporters = loader.loadFootagesAndReporters("YOUR FILE PATH TO THE CSV FILE WITH DATA INSERT HERE");

            for (FootageAndReporter footageAndReporter: footageAndReporters)
            {
                //calling out method that inserts a report and inserts a footage in the database
                createReporterInDB(footageAndReporter);
                 createFootageInDB(footageAndReporter);

            }
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
    private static void insertData(String manipulation)
    {
        //calling the manipulation class that can insert things in the database and giving it the sql command
        ManipulateDatabase m = new ManipulateDatabase(host, port, database,cp,username,password,manipulation);

    }
    private static void doQuery(String query)
    {
        //This method is not used in the task but it makes it possible to excecute querryes from java in sql database
        Query q = new Query(host, port, database,cp,username,password,query);
    }
    private static void createFootageInDB(FootageAndReporter ft)
    {
    //we are collection all the data for the footage and collecting it as a string to be sent to be exceutet in the database
    String FTitle = ft.getFootage().getTitle();
    String FDate = ft.getFootage().getDate().toString();
    String FDuration = ft.getFootage().getDuration().toString();
    String FCpr = ft.getReporter().getCPR().toString();
    String data = "INSERT INTO Footage VALUES('"+FTitle+"','"+FDate+"','"+FDuration+"','"+FCpr+ "')";
        System.out.println(data);
    insertData(data);

    }
    private static void  createReporterInDB(FootageAndReporter ft)
    {
        //we are collection all the data for the journalist/reporter and collecting it as a string to be sent to be exceutet in the database
        String Rcpr = ft.getReporter().getCPR().toString();
        String RFirstName= ft.getReporter().getFirstName();
        String RLastName = ft.getReporter().getLastName();
        String RStreetName = ft.getReporter().getStreetName();
        String RCivicnumb = ft.getReporter().getCivicNumber().toString();
        String RCountry = ft.getReporter().getCountry();
        String RZipCode = ft.getReporter().getZIPCode().toString();
        String data = "INSERT INTO Journalist VALUES('"+Rcpr+"','"+RFirstName+"','"+RLastName+"','"+RStreetName+"','"+RCivicnumb+"','"+RCountry+"','"+RZipCode+"')";
        System.out.println(data);
        insertData(data);


    }
}
