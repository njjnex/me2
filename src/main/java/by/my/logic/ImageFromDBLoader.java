package by.my.logic;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import by.my.entity.Event;

public class ImageFromDBLoader {

	private String path = "/src/main/webapp/WEB-INF/resources/images/events/";

		@SuppressWarnings("resource")
		public void loadImage(Event event) {
		if (event.getImage() != null) {
			try {
				InputStream in = event.getImage().getBinaryStream();
				OutputStream out;
				String appPath = System.getProperty("user.dir");
				
				out = new FileOutputStream(appPath + path
						+ event.getId() + ".jpg");

				byte[] buff = new byte[4096];

				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				System.out.println(appPath + path
						+ event.getId() + ".jpg"
						+ " file created");
			} catch (Exception e) {

				e.printStackTrace();
			}
		}
	}
	
		
	}

