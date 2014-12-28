package by.my.logic;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import by.my.entity.Event;
import by.my.entity.User;

public class ImageFromDBLoader {

	private final String PATH_EVENT = "/src/main/webapp/WEB-INF/resources/images/events/";
	private final String PATH_AVATAR = "/src/main/webapp/WEB-INF/resources/images/avatars/";

	@SuppressWarnings("resource")
	public void loadEventImage(Event event) {
		if (event.getImage() != null) {
			try {
				InputStream in = event.getImage().getBinaryStream();
				OutputStream out;
				String appPath = System.getProperty("user.dir");

				out = new FileOutputStream(appPath + PATH_EVENT + event.getId()
						+ ".jpg");

				byte[] buff = new byte[4096];

				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				System.out.println(appPath + PATH_EVENT + event.getId()
						+ ".jpg" + " file created");
			} catch (Exception e) {

				e.printStackTrace();
			}
		}
	}

	@SuppressWarnings("resource")
	public void loadUserAvatar(User user) {

		if (user.getAvatar() != null) {
			try {
				InputStream in = user.getAvatar().getBinaryStream();
				OutputStream out;
				String appPath = System.getProperty("user.dir");

				out = new FileOutputStream(appPath + PATH_AVATAR + user.getId()
						+ ".jpg");

				byte[] buff = new byte[4096];

				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				System.out.println(appPath + PATH_EVENT + user.getId() + ".jpg"
						+ " file created");
			} catch (Exception e) {

				e.printStackTrace();
			}
		}

	}

}
