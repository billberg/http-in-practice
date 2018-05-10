package ch2.examples;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;

/**
 * Server端负责关闭
 * @author billberg
 *
 */
public class HttpClient1 {
	//
	static String request1 =  "GET / HTTP/1.1\r\n" + 
							  "Host: 127.0.0.1\r\n" + 
							  "Connection: keep-alive\r\n";
	//
	static String request2 =  "GET / HTTP/1.1\r\n" + 
							  "Host: 127.0.0.1\r\n" + 
							  "Connection: keep-alive\r\n" + 
							  "Content-Length: 17\r\n" + 
							  "\r\n" + 
							  "{name:'billberg'}";
	//pipeline
	static String request3 =  "GET / HTTP/1.1\r\n" + 
							  "Host: 127.0.0.1\r\n" + 
							  "Connection: keep-alive\r\n"+
							  "GET / HTTP/1.1\r\n" + 
							  "Host: 127.0.0.1\r\n" + 
							  "Connection: keep-alive\r\n" + 
							  "Content-Length: 17\r\n" + 
							  "\r\n" + 
							  "{name:'billberg'}";
	
	public static void main(String[] args) {  

		long startTime = System.currentTimeMillis();
		 
		try {
			Socket s = new Socket("127.0.0.1", 8080);
			s.setSoTimeout(3000);
	          
	        InputStream is = s.getInputStream();
	        OutputStream os = s.getOutputStream();
	        OutputStreamWriter writer = new OutputStreamWriter(s.getOutputStream());  
	        
	        System.out.println("-------- Request --------");
	        System.out.print(request2);
	        System.out.println();
	      
	        os.write(request2.getBytes("UTF-8"));
	        os.flush();
	        
	        //如果用Buffered类封装读，则原始的InputStream则不可再使用，因为Buffered类处于性能考虑会预读
	        //BufferedReader br = new BufferedReader(new InputStreamReader(is));  
            
            int x;
            ByteBuffer bb = ByteBuffer.allocate(65536);
            boolean headerBreak = false;
            while ( (x = is.read()) != -1 ) {
            	bb.put((byte)x);
            	
            	if (bb.position() >=2 && bb.get(bb.position()-2) == '\r' && bb.get(bb.position()-1) == '\n') {
            		//HTTP头部结束
            		if (bb.position() >=4 && bb.get(bb.position()-4) == '\r' && bb.get(bb.position()-3) == '\n') {
                		headerBreak = true;
                		break;
                	}
            	}
            }
            
            int contentLength = 0;
            if (headerBreak) {
            	String responseHeader = new String(bb.array());
            	String[] headers = responseHeader.split("\r\n");
            	for (int i = 0; i < headers.length; i++) {
            		if (headers[i].startsWith("Content-Length:")) {
            			contentLength = Integer.valueOf(headers[i].split(":")[1].trim());
            			break;
            		}
            	}
            }
            
            if (contentLength > 0) {
            	byte[] responseBody = new byte[contentLength];
                for (int i = 0; i < contentLength; i++) {
                	responseBody[i] = (byte) is.read();
                }
                
                bb.put(responseBody);
            }
           
            String response = new String(bb.array());
	        
            System.out.println("-------- Response --------");
            System.out.print(response);
            
	        s.close();  
        
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
        long endTime = System.currentTimeMillis();
		//System.out.println("Time cost:"+(endTime-startTime));
          
    }  
	
	
	public static void testKeepalive() {  

		long startTime = System.currentTimeMillis();
		 
		try {
			Socket s = new Socket("127.0.0.1", 8080);
			s.setSoTimeout(3000);
          
	        System.out.println( "remote socket " + s.getRemoteSocketAddress());  
	          
	        InputStream is = s.getInputStream();
	        OutputStream os = s.getOutputStream();
	        OutputStreamWriter writer = new OutputStreamWriter(s.getOutputStream());  
	      
	        os.write(request2.getBytes("UTF-8"));
	        os.flush();
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(is));  
            String line = "";  
            StringBuffer buf = new StringBuffer();  
            
            int contentLength = 0;
            while ( (line = br.readLine()) != null ) {  
            	System.out.println(line);
            	
            	if (line.startsWith("Content-Length:")) {
            		contentLength = Integer.valueOf(line.split(":")[1]);
            	}
                buf.append(line);  
            }  
            
            String response = buf.toString();  
	        
            System.out.println("Response:");
            System.out.print(response);
            
	        s.close();  
        
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
        long endTime = System.currentTimeMillis();
		System.out.println("Time cost:"+(endTime-startTime));
          
    }  

}