package voting.application.candidate.entities;

import java.io.IOException;

import java.util.Base64;

import org.springframework.web.multipart.MultipartFile;

public class Utils {
	public static String getBase64Image(MultipartFile image) {
		
		try {
			byte[] imageBytes = image.getBytes();
			return Base64.getEncoder().encodeToString(imageBytes);
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		return null;
	}

}
