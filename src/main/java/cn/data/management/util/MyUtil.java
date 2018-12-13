package cn.data.management.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

public class MyUtil {
	public static ResponseEntity<byte[]> buildResponseEntity(File file, String fileName) throws IOException {
		byte[] body = null;
		// 获取文件
		InputStream is = new FileInputStream(file);
		body = new byte[is.available()];
		is.read(body);
		HttpHeaders headers = new HttpHeaders();
		// 设置文件类型
		headers.add("Content-Disposition", "attchement;filename=" + fileName);
		// 设置Http状态码
		HttpStatus statusCode = HttpStatus.OK;
		// 返回数据
		ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(body, headers, statusCode);
		return entity;
	}
}
