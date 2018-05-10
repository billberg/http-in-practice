package ch1.examples;  

import java.io.IOException;  
import java.io.InputStreamReader;  
import java.io.LineNumberReader;  
import java.io.PrintWriter;  
import java.net.Socket;  

public class SimpleHttpClient {  
    /** 
     * send http request & get response, 
     *  
     * @param host 
     *            hostname or ip 
     * @param path 
     *            path after host, format: "/xxx" 
     * @param port 
     * @return response string 
     * @throws IOException 
     * @throws InterruptedException 
     */  
    public static String httpRequest(String host, String path, int port) throws IOException, InterruptedException {  
        Socket client = new Socket(host, port);  
        StringBuffer requestInfo = new StringBuffer("");  
        StringBuffer responseInfo = new StringBuffer("");  

        // prepare request info,  
        requestInfo.append("GET " + path + " HTTP/1.1\n");  
        requestInfo.append("Host: " + host + "\n");  
        requestInfo.append("Connection: Close\n");  

        // send request,  
        PrintWriter pw = new PrintWriter(client.getOutputStream(), true);  
        pw.println(requestInfo.toString());  
        System.out.println("****** request - start ******");  
        System.out.println(requestInfo.toString());  
        System.out.println("****** request - end ******");  

        // get response info,  
        LineNumberReader lnr = new LineNumberReader(new InputStreamReader(client.getInputStream()));  
        String line;  
        while ((line = lnr.readLine()) != null) {  
            responseInfo.append(line + "\n");  
        }  
        System.out.println("****** response - start ******");  
        System.out.println(responseInfo.toString());  
        System.out.println("****** response - end ******");  

        pw.close();  
        lnr.close();  
        client.close();  
        return responseInfo.toString();  
    }  

    /****** test - start ******/  
    /** 
     * test http request, 
     */  
    public static void testHttpRequest() {  
        try {  
            httpRequest("localhost", "/index.html", 80);  
            // sendRequest("www.google.com.hk", "/", 80);  
        } catch (IOException e) {  
            e.printStackTrace();  
        } catch (InterruptedException e) {  
            e.printStackTrace();  
        }  
    }  

    public static void main(String[] args) {  

    }  
    /****** test - end ******/  
}  