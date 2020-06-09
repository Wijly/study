package com.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileManager {
	
	// 파일 다운로드
	// serverFileName : 서버에 저장된 파일명
	// originalFileName : 클라이언트가 업로드한 파일명
	// path : 서버에 저장된 위치
	
	// 파일 다운로드 메소드
	public static boolean doFileDownload(HttpServletResponse response, String saveFileName, String originalFileName, String path) {
		
		try {

			String filePath = path + File.separator + saveFileName;
			
			if(originalFileName == null || originalFileName.equals("")) {
				//
				originalFileName = saveFileName;				
			}
			
			// 파일을 다운 받아 저장시 한글 깨짐 방지
			originalFileName = new String(originalFileName.getBytes("euc-kr"),"ISO-8859-1");
			
			File f = new File(filePath);
			
			if(!f.exists()) {
				return false;
			}
			
			// application 타입으로 된 것을 다운
			response.setContentType("application/octet-stream");
			// header를 읽어서 내려보냄
			response.setHeader("Content-disposition", "attachment;fileName="+originalFileName);
			
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(f));
			
			OutputStream out = response.getOutputStream();
			
			int n;
			byte[] bytes = new byte[4096];
			
			while((n=bis.read(bytes, 0, 4096))!=-1) {
				out.write(bytes,0,n);
			}
			out.flush();
			out.close();
			bis.close();
				
			
		} catch (Exception e) {
			System.out.println(e.toString()+"dofileDownload");
			return false;
		}
		
		return true;
		
	}
	
	// 파일 삭제
	public static void doFileDelete(String fileName, String path) {
		
		try {
			
			String filePath = path = File.separator + fileName;
			
			File f = new File(filePath);
			
			if(f.exists())
				f.delete();	// 파일 삭제
			
		} catch (Exception e) {
			System.out.println(e.toString()+"fileDelete");
		}
		
	}

}
