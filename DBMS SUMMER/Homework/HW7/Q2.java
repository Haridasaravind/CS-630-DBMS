import java.io.*;
import java.sql.*;
import java.util.Scanner;

class Q2 {
    // the host name of the server and the server instance name/id
    public static void main(String args[]) {
        Connection conn = null;
        conn = getConnection();
        if (conn == null)
            System.exit(1);

        // now execute query
        Scanner input = new Scanner(System.in);
        try {
            // Create statement object
            Statement stmt = conn.createStatement();
            ResultSet rs1 = stmt.executeQuery("SELECT * from customers");
            if (rs1.next()) {
                do {
                    System.out.println("CID: " + rs1.getString("cid") +
                            " NAME: " + rs1.getString("name") +
                            " CITY: " + rs1.getString("city") +
                            " STATE: " + rs1.getString("state") +
                            "AGE: " + rs1.getString("age"));
                } while (rs1.next());
            } else {
                System.out.println("No Records Present");
            }
            System.out.println();
            ResultSet rs2 = stmt.executeQuery("SELECT c.cid,name,m.mid,title,w.watchedon FROM customers c, movies m, watch w WHERE c.cid=w.cid and m.mid=w.mid");
            if (rs2.next()) {
                do {
                    System.out.println("cid: " + rs2.getString("cid") + "Name: " + rs2.getString("name") + " mid: " + rs2.getString("mid") + " Title: " + rs2.getString("title") + " Watched on: " + rs2.getDate("watchedon"));
                } while (rs2.next());
            } else {
                System.out.println("No Records");
            }
            System.out.println();

            ResultSet rs3 = stmt.executeQuery("SELECT count(mid) as count_movie FROM movies");
            // if the result has any record print each record, line by line
            if (rs3.next()) {
                do {
                    System.out.println("No. of Movies in DB are: " + rs3.getString("count_movie"));
                } while (rs3.next());
            } else {
                System.out.println("No Records Present");
            }
            System.out.println();

            ResultSetMetaData metadata = stmt.executeQuery("select * from customers").getMetaData();
            int count = metadata.getColumnCount();
            System.out.println("No.of columns in customers table : " + count);
            for (int i = 1; i <= count; i++) {
                System.out.println("Name: " + metadata.getColumnName(i) + "Type: " + metadata.getColumnTypeName(i));
            }
            System.out.println();

            System.out.println("Enter a year to view films that were released during that year: ");
            int year = input.nextInt();

            ResultSet rs4 = stmt.executeQuery("SELECT mid,title,director FROM movies WHERE releaseyear=" + year);
            //
            if (rs4.next()) {
                do {
                    System.out.println("mid: " + rs4.getString("mid") + " Title: " + rs4.getString("title") + " Director: " + rs4.getString("director"));
                } while (rs4.next());
            } else {
                System.out.println("No Records Present");
            }
            conn.close();
            System.out.println("Connection closed.");

        } catch (SQLException e) {
            System.out.println("ERROR");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {

        // first we need to load the driver
        String jdbcDriver = "oracle.jdbc.OracleDriver";
        try {
            Class.forName(jdbcDriver);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Get username and password
        Scanner input = new Scanner(System.in);
        System.out.print("Username:");
        String username = input.nextLine();
        System.out.print("Password:");
        // the following is used to mask the password
        Console console = System.console();
        String password = new String(console.readPassword());
        System.out.print("hostname:");
        String oracleServer = input.nextLine();
        System.out.print("db:");
        String oracleServerSid = input.nextLine();
        String connString = "jdbc:oracle:thin:@" + oracleServer + ":1521:"
                + oracleServerSid;

        System.out.println("Connecting to the database...");

        Connection conn;
        // Connect to the database
        try {
            conn = DriverManager.getConnection(connString, username, password);
            System.out.println("Connection Successful");
        } catch (SQLException e) {
            System.out.println("Connection ERROR");
            e.printStackTrace();
            return null;
        }

        return conn;
    }
}
