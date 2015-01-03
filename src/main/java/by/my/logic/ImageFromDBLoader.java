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

	/**
	 * Loads event image to PATH_EVENT from database 
	 * @param event which event image should be loaded
	 */
	@SuppressWarnings("resource")
	public void loadEventImage(Event event) {
		if (event.getImage() != null) {
			try {
				InputStream in = event.getImage().getBinaryStream();
				OutputStream out = new FileOutputStream(
						System.getenv("OPENSHIFT_DATA_DIR") + "event"
								+ event.getId() + ".jpg");

				byte[] buff = new byte[4096];
				int len = 0;
				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				System.out.println(System.getenv("OPENSHIFT_DATA_DIR")
						+ "event" + event.getId() + ".jpg" + " file created");
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
				OutputStream out = new FileOutputStream(
						System.getenv("OPENSHIFT_DATA_DIR") + "avatar"
								+ user.getId() + ".jpg");

				byte[] buff = new byte[4096];

				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				System.out.println(System.getenv("OPENSHIFT_DATA_DIR")
						+ "avatar" + user.getId() + ".jpg" + "file created");
			} catch (Exception e) {

				e.printStackTrace();
			}
		}

	}

}
