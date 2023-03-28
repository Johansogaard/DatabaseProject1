import java.sql.*;

public class Query {
    public Query(String host, String port, String database, String cp, String username, String password, String sqlQuery) {

        try{


        String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?characterEncoding=" + cp;
        Connection connection = DriverManager.getConnection(url, username, password);
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sqlQuery);
        ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
        int columnCount = resultSetMetaData.getColumnCount();
        int[] columnWidths = new int[columnCount + 1]; //columnWidths[0] to be ignored
        int valueLength;
        int maxLength = 45; //Columnwidths to be truncated to maxLength

        // Find maximum width for each column and store in columnWidths[i].
        // ----------------------------------------------------------------
        for (int i = 1; i <= columnCount; i++) {
            columnWidths[i] = resultSetMetaData.getColumnName(i).length();
        }
        while (resultSet.next()) {
            for (int i = 1; i <= columnCount; i++) {
                if (resultSet.getString(i) == null) {
                    valueLength = 4;
                } else {
                    valueLength = resultSet.getString(i).length();
                }
                if (valueLength > columnWidths[i]) {
                    columnWidths[i] = valueLength;
                }
            }
        }

        // Print all attribute names.
        // --------------------------
        for (int i = 1; i <= columnCount; i++) {
            System.out.print(truncate(rightPad(resultSetMetaData.getColumnName(i), columnWidths[i]), maxLength));
        }
        System.out.println();

        // Print all table rows.
        // ---------------------
        resultSet.beforeFirst(); // Set pointer for resultSet.next()
        while (resultSet.next()) {
            // Print all values in a row.
            // --------------------------
            for (int i = 1; i <= columnCount; i++) {
                if (resultSet.getString(i) == null) {
                    System.out.print(truncate(rightPad("null", columnWidths[i]), maxLength));
                } else {
                    System.out.print(truncate(rightPad(resultSet.getString(i), columnWidths[i]), maxLength));
                }
                ;
            }
            System.out.println();
        }
        connection.close();
    }
		catch(
    Exception e)

    {
        e.printStackTrace();
    }

}

// Method that rightpad short columnnames and short columnvalues to same width
public static String rightPad(String stringToPad, int width){
        while(stringToPad.length() <= width){ stringToPad = stringToPad + " "; }
        return stringToPad;
        }
    // Method that truncate long columnnames and long columnvalues to maxLength
    public static String truncate(String value, int length){
        if (value != null && value.length() > length)
        {value = value.substring(0, length - 4) + "... ";}
        return value;
    }
}
