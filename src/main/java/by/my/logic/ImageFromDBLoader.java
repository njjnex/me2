package by.my.logic;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import by.my.entity.Event;
import by.my.entity.User;

/**
 * @author njjnex
 *Loads image from db to server side in mentioned path
 */
public class ImageFromDBLoader {

	private final String PATH_EVENT = "/src/main/webapp/WEB-INF/resources/images/events/";
	private final String PATH_AVATAR = "/src/main/webapp/WEB-INF/resources/images/avatars/";

	/**
	 * Loads event image to PATH_EVENT from database 
	 * @param event which event image should be loaded
	 */
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
	/**
	 * Loads user avatar to PATH_AVATAR from database 
	 * @param user which user image should be loaded
	 */
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
