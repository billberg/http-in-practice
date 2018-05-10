package ch1.examples;  

import java.io.IOException;  
import java.io.InputStream;  
import java.io.InputStreamReader;  
import java.io.LineNumberReader;  
import java.io.OutputStream;  
import java.io.PrintWriter;  
import java.net.InetAddress;  
import java.net.ServerSocket;  
import java.net.Socket;  
import java.net.UnknownHostException;  
import java.util.Date;  
import java.util.HashMap;  
import java.util.Map;  

public class SimpleHttpServer implements HttpServer {  
    private ServerSocket server;  

    public SimpleHttpServer(int port, int backlog, String host) throws UnknownHostException, IOException {  
        server = new ServerSocket(port, backlog, InetAddress.getByName(host));  
    }  

    @Override  
    public void start() {  
        Socket socket = null;  
        InputStream inStream = null;  
        OutputStream outStream = null;  

        Map<String, String> paramMap = null;  

        while (true) {  
            try {  
                socket = server.accept();  

                // get input  
                inStream = socket.getInputStream();  
                paramMap = parse(inStream);  
                // paramMap = new HashMap();  

                // write output  
                outStream = socket.getOutputStream();  
                response(outStream, paramMap);  

                // close socket, this indicate the client that the response is finished,  
                socket.close();  
            } catch (Exception e) {  
                e.printStackTrace();  
            } finally {  
                try {  
                    if (inStream != null) {  
                        inStream.close();  
                    }  
                    if (outStream != null) {  
                        outStream.close();  
                    }  
                    if (socket != null) {  
                        socket.close();  
                    }  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
    }  

    @Override  
    public Map<String, String> parse(InputStream is) throws IOException {  
        Map<String, String> paramMap = new HashMap<String, String>();  
        LineNumberReader lr = new LineNumberReader(new InputStreamReader(is));  
        String inputLine = null;  
        String method = null;  
        String httpVersion = null;  
        String uri = null;  

        // read request line  
        inputLine = lr.readLine();  
        String[] requestCols = inputLine.split("\\s");  
        method = requestCols[0];  
        uri = requestCols[1];  
        httpVersion = requestCols[2];  
        System.out.println("http version:\t" + httpVersion);  

        // parse GET param  
        if (uri.contains("?")) {  
            paramMap.putAll(parseParam(uri.split("\\?", 2)[1], false));  
        }  

        // read header  
        while ((inputLine = lr.readLine()) != null) {  
            System.out.println("post header line:\t" + inputLine);  
        }  

        // read body - POST method  
        if (method.toUpperCase().equals("POST")) {  
            StringBuffer bodySb = new StringBuffer();  
            char[] bodyChars = new char[1024];  
            int len;  

            // ready() make sure it will not block,  
            while (lr.ready() && (len = lr.read(bodyChars)) > 0) {  
                bodySb.append(bodyChars, 0, len);  
            }  
            paramMap.putAll(parseParam(bodySb.toString(), true));  

            System.out.println("post body:\t" + bodySb.toString());  
        }  

        return paramMap;  
    }  

    @Override  
    public Map<String, String> parseParam(String paramStr, boolean isBody) {  
        String[] paramPairs = paramStr.trim().split("&");  
        Map<String, String> paramMap = new HashMap<String, String>();  

        String[] paramKv;  
        for (String paramPair : paramPairs) {  
            if (paramPair.contains("=")) {  
                paramKv = paramPair.split("=");  
                if (isBody) {  
                    // replace '+' to ' ', because in body ' ' is replaced by '+' automatically when post,  
                    paramKv[1] = paramKv[1].replace("+", " ");  
                }  
                paramMap.put(paramKv[0], paramKv[1]);  
            }  
        }  

        return paramMap;  
    }  

    @Override  
    public void response(OutputStream os, Map<String, String> paramMap) {  
        String name = (paramMap.get("name") == null) ? "xxx" : paramMap.get("name");  

        PrintWriter pw = null;  
        pw = new PrintWriter(os);  
        pw.println("HTTP/1.1 200 OK");  
        pw.println("Content-type: text/html; Charset=UTF-8");  
        pw.println("");  
        pw.println("<h1>Hi <span style='color: #FFF; background: #000;'>" + name + "</span> !</h1>");  
        pw.println("<h4>current date: " + new Date() + "</h4>");  
        pw.println("<p>you can provide your name via a param called <span style='color: #F00; background: yellow;'>\"name\"</span>, in both GET and POST method.</p>");  
        pw.flush();  
    }  

    @Override  
    public void terminate() throws IOException {  
        server.close();  
    }  

    /****** test - start ******/  
    public static void main(String[] args) {  
        testHttpServer();  
    }  

    // test http server,  
    public static void testHttpServer() {  
        try {  
            HttpServer server = new SimpleHttpServer(9090, 1, "localhost");  
            server.start();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
    /****** test - end ******/  
}  