package com.kpmg.kdb.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLConnection;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.ResourceBundle;

import org.apache.commons.lang.StringUtils;

import com.kpmg.kdb.schedule.quartz.job.ApplicationConstants;

public class SystemHelper {
	public static final String URL_SPACE = "%20";
	public static final String SYSTEM_SPACE = " ";

	private SystemHelper() {
	}

	public static String getSystemProperty(String key, String defaultValue) {
		try {
			Properties prop = System.getProperties();

			return prop.getProperty(key, defaultValue);
		} catch (Throwable th) {
			return defaultValue;
		}

	}

	public static String setSystemProperty(String key, String value) {
		return System.setProperty(key, value);
	}

	public static String getSystemProperty(String key) {
		return getSystemProperty(key, null);
	}

	public static ResourceBundle getResourceBundle(String name) {
		return ResourceBundle.getBundle(name);
	}

	public static InputStream getResourceAsStream(String name) throws IOException {
		return getResourceAsStream(getClassLoader(), name);
	}

	public static InputStream getResourceAsStream(ClassLoader loader, String name) throws IOException {
		InputStream in = null;
		if (loader == null) {
			in = getClassLoader().getResourceAsStream(name);
		} else {
			in = loader.getResourceAsStream(name);
		}

		if (in == null) {
			throw new IOException("Could not find resource " + name);
		}
		return in;
	}

	public static URL getResourceURL(String name) throws IOException {
		return getResourceURL(getClassLoader(), name);
	}

	public static Enumeration<URL> getResourceURLs(String name) throws IOException {
		return getResourceURLs(getClassLoader(), name);
	}

	public static URL getResourceURL(ClassLoader loader, String name) throws IOException {
		URL url = null;
		if (loader == null) {
			url = getClassLoader().getResource(name);
		} else {
			url = loader.getResource(name);
		}

		if (url == null) {
			url = ClassLoader.getSystemResource(name);
		}
		if (url == null) {
			throw new IOException("Could not find name " + name);
		}
		return url;
	}

	public static Enumeration<URL> getResourceURLs(ClassLoader loader, String name) throws IOException {
		Enumeration<URL> urls = null;
		if (loader == null) {
			urls = getClassLoader().getResources(name);
		} else {
			urls = loader.getResources(name);
		}
		return urls;
	}

	public static Properties getResourceAsProperties(String name) throws IOException {
		Properties props = new Properties();
		InputStream in = null;
		String propfile = name;
		in = getResourceAsStream(propfile);
		props.load(in);
		in.close();
		return props;
	}

	public static Properties getResourceAsProperties(ClassLoader loader, String name) throws IOException {
		Properties props = new Properties();
		InputStream in = null;
		String propfile = name;
		in = getResourceAsStream(loader, propfile);
		props.load(in);
		in.close();
		return props;
	}

	public static Reader getResourceAsReader(String name) throws IOException {
		return new InputStreamReader(getResourceAsStream(name));
	}

	public static Reader getResourceAsReader(ClassLoader loader, String name) throws IOException {
		return new InputStreamReader(getResourceAsStream(loader, name));
	}

	public static File getResourceAsFile(String name) throws IOException {
		return new File(getResourceURL(name).getFile().replace(URL_SPACE, SYSTEM_SPACE));
	}

	public static File[] getResourcesAsFile(ClassLoader loader, String name) throws IOException {
		Enumeration<URL> urls = getResourceURLs(loader, name);
		List<File> files = new ArrayList<File>();

		while (urls.hasMoreElements()) {
			files.add(new File(urls.nextElement().getFile().replace(URL_SPACE, SYSTEM_SPACE)));
		}

		return files.toArray(new File[files.size()]);
	}

	public static File[] getResourcesAsFile(String name) throws IOException {
		Enumeration<URL> urls = getResourceURLs(name);
		List<File> files = new ArrayList<File>();

		while (urls.hasMoreElements()) {
			files.add(new File(urls.nextElement().getFile()));
		}

		return files.toArray(new File[files.size()]);
	}

	public static File getResourceAsFile(ClassLoader loader, String name) throws IOException {
		return new File(getResourceURL(loader, name).getFile());
	}

	public static InputStream getUrlAsStream(String urlString) throws IOException {
		URL url = new URL(urlString);
		URLConnection conn = url.openConnection();
		return conn.getInputStream();
	}

	public static Reader getUrlAsReader(String urlString) throws IOException {
		return new InputStreamReader(getUrlAsStream(urlString));
	}

	public static Properties getUrlAsProperties(String urlString) throws IOException {
		Properties props = new Properties();
		InputStream in = null;
		String propfile = urlString;
		in = getUrlAsStream(propfile);
		props.load(in);
		in.close();
		return props;
	}

	public static String getPackagePath(Object obj) {
		if (obj != null) {
			return obj.getClass().getPackage().getName().replace('.', '/');
		} else {
			return null;
		}
	}

	public static String getPackagePath(Class<?> clazz) {
		if (clazz != null) {
			return clazz.getPackage().getName().replace('.', '/');
		} else {
			return null;
		}
	}

	public static ClassLoader getClassLoader() {
		return Thread.currentThread().getContextClassLoader();
	}

	public static String getHostname() {
		return getHostname(null);
	}

	public static String getHostname(String defName) {
		String hostname = defName;
		try {
			InetAddress localMachine = InetAddress.getLocalHost();
			hostname = localMachine.getHostName();
		} catch (UnknownHostException e) {
		}

		return hostname;
	}

	public static Locale getLocale(String locale) {
		Locale rLocale = null;

		// Message 처리시 기본값 처리
		if (StringUtil.isNull(locale)) {
			locale = ApplicationConstants.DEFAULT_LANGUAGE;
		}

		if (StringUtils.isEmpty(locale)) {
			if (Locale.KOREA.getLanguage().equals(Locale.getDefault().getLanguage())) {
				locale = "KOR";
				rLocale = Locale.KOREA;
			} else if (Locale.ENGLISH.getLanguage().equals(Locale.getDefault().getLanguage())) {
				locale = "ENG";
				rLocale = Locale.ENGLISH;
			} else {
				locale = "LOC";
				rLocale = Locale.getDefault();
			}
		} else {
			if (locale.equals("KOR")) {
				locale = "ko";
			} else if (locale.equals("ENG")) {
				locale = "en";
			}

			if (locale.equals(Locale.KOREA.getLanguage())) {
				locale = "KOR";
				rLocale = Locale.KOREA;
			} else if (locale.equals(Locale.ENGLISH.getLanguage())) {
				locale = "ENG";
				rLocale = Locale.ENGLISH;
			} else {
				locale = "LOC";
				rLocale = Locale.getDefault();
			}
		}

		return rLocale;
	}
}
