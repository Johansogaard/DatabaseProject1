import java.io.IOException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
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


        FootagesAndReportersLoader loader = new FootagesAndReportersLoader();
        try {
            List<FootageAndReporter> footageAndReporters = loader.loadFootagesAndReporters("C:\\Users\\johan\\OneDrive\\Desktop\\Uddannelse\\DTU\\2. semester\\Introductory databases and database programming\\databaserigtigopgave\\src\\main\\resources\\uploads.csv");
            for (FootageAndReporter footageAndReporter: footageAndReporters)
            {

                createReporterInDB(footageAndReporter);
             createFootageInDB(footageAndReporter);

            }
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
    private static void insertData(String manipulation)
    {
        ManipulateDatabase m = new ManipulateDatabase(host, port, database,cp,username,password,manipulation);

    }
    private static void doQuery(String query)
    {
        Query q = new Query(host, port, database,cp,username,password,query);
    }
    private static void createFootageInDB(FootageAndReporter ft)
    {

    String FTitle = ft.getFootage().getTitle();
    String FDate = ft.getFootage().getDate().toString();
    String FDuration = ft.getFootage().getDuration().toString();
    String FCpr = ft.getReporter().getCPR().toString();
    insertData("INSERT INTO Footage VALUES('"+FTitle+"','"+FDate+"','"+FDuration+"','"+FCpr+ "')");

    }
    private static void  createReporterInDB(FootageAndReporter ft)
    {
        String Rcpr = ft.getReporter().getCPR().toString();
        String RFirstName= ft.getReporter().getFirstName();
        String RLastName = ft.getReporter().getLastName();
        String RStreetName = ft.getReporter().getStreetName();
        String RCivicnumb = ft.getReporter().getCivicNumber().toString();
        String RCountry = ft.getReporter().getCountry();
        String RZipCode = ft.getReporter().getZIPCode().toString();
        insertData("INSERT INTO Journalist VALUES('"+Rcpr+"','"+RFirstName+"','"+RLastName+"','"+RStreetName+"','"+RCivicnumb+"','"+RCountry+"','"+RZipCode+"')");


    }
}
