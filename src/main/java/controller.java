import java.io.IOException;
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
                String f[] = footageAndReporter.getFootage().toString().split(";|:");
                System.out.println("\tFootage: "+footageAndReporter.getFootage());
                //INSERT INTO Footage (FootageID, FootageTitle, FootageDate, Duration, JournalistID)
              //  insertData();
                System.out.println("\tReporter: " + footageAndReporter.getReporter());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        doQuery("select * from item");

    }
    private static void insertData(String manipulation)
    {
        ManipulateDatabase m = new ManipulateDatabase(host, port, database,cp,username,password,manipulation);

    }
    private static void doQuery(String query)
    {
        Query q = new Query(host, port, database,cp,username,password,query);
    }

}
