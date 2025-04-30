package com.kpmg.kdb.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.Vector;

public class StringUtil {

	/** An empty string constant */
	public static final String EMPTY = "";

	/**
	 * 초성
	 */
	private static final char[] firstSounds = { 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ',
			'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' };

	/**
	 * 문자 하나가 한글인지 검사
	 *
	 * @param c 검사 하고자 하는 문자
	 * @return 한글 여부에 따라 'true' or 'false'
	 */
	public static boolean isKorean(char c) {
		if (c < 0xAC00 || c > 0xD7A3)
			return false;
		return true;
	}

	/**
	 * 문자열이 한글인지 검사
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @return 한글 여부에 따라 'true' or 'false'
	 */
	public static boolean isKorean(String str) {
		if (str == null)
			return false;

		str = str.trim();
		int len = str.length();
		if (len == 0)
			return false;

		for (int i = 0; i < len; i++) {
			if (!isKorean(str.charAt(i)))
				return false;
		}
		return true;
	}

	/**
	 * 문자 하나가 알파벳인지 검사
	 *
	 * @param str 검사 하고자 하는 문자
	 * @return 알파벳인지의 여부에 따라 'true' or 'false'
	 */
	public static boolean isAlpha(char c) {
		if ((c < 'a' || c > 'z') && (c < 'A' || c > 'Z') && c != '_' && c != ' ')
			return false;
		return true;
	}

	/**
	 * 문자열이 알파벳인지 검사
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @return 알파벳인지의 여부에 따라 'true' or 'false'
	 */
	public static boolean isAlpha(String str) {
		if (str == null)
			return false;

		str = str.trim();
		int len = str.length();
		if (len == 0)
			return false;

		for (int i = 0; i < len; i++) {
			if (!isAlpha(str.charAt(i)))
				return false;
		}
		return true;
	}

	/**
	 * 문자 하나가 숫자인지 검사
	 *
	 * @param str 검사 하고자 하는 문자
	 * @return 숫자인지의 여부에 따라 'true' or 'false'
	 */
	public static boolean isNumber(char c) {
		if (c < '0' || c > '9')
			return false;
		return true;
	}

	/**
	 * 문자열이 숫자인지 검사
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @return 숫자인지의 여부에 따라 'true' or 'false'
	 */
	public static boolean isNumber(String str) {
		if (str == null)
			return false;

		str = str.trim();
		int len = str.length();
		if (len == 0)
			return false;

		for (int i = 0; i < len; i++) {
			if (!isNumber(str.charAt(i)))
				return false;
		}
		return true;
	}

	/**
	 * 문자 하나가 한글 또는 알파벳인지 검사
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @return 한글또는 알파벳 여부에 따라 'true' or 'false'
	 */
	public static boolean isHanAlp(char c) {
		if (!isAlpha(c) && !isKorean(c))
			return false;
		return true;
	}

	/**
	 * 문자열이 한글 또는 알파벳인지 검사
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @return 한글 여부에 따라 'true' or 'false'
	 */
	public static boolean isHanAlp(String str) {
		if (str == null)
			return false;

		str = str.trim();
		int len = str.length();
		if (len == 0)
			return false;

		for (int i = 0; i < len; i++) {
			if (!isHanAlp(str.charAt(i)))
				return false;
		}
		return true;
	}

	/**
	 * 문자 하나가 알파벳 또는 숫자인지 검사
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @return 알파벳 또는 숫자인지의 여부에 따라 'true' or 'false'
	 */
	public static boolean isAlpNum(char c) {
		if (!isAlpha(c) && !isNumber(c))
			return false;
		return true;
	}

	/**
	 * 문자열이 알바벳 또는 숫자인지 검사
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @return 알파벳 또는 숫자인지의 여부에 따라 'true' or 'false'
	 */
	public static boolean isAlpNum(String str) {
		if (str == null)
			return false;

		str = str.trim();
		int len = str.length();
		if (len == 0)
			return false;

		for (int i = 0; i < len; i++) {
			if (!isAlpNum(str.charAt(i)))
				return false;
		}
		return true;
	}

	/**
	 * 이메일의 형식을 검사한다.
	 *
	 * @param str 검사 하고자 하는 이메일 문자열.
	 * @return 문자열이 이메일이 맞으면 'true', 아니면 'false'
	 */
	public static boolean isEmail(String email) {
		if (email == null)
			return false;

		email = email.trim();
		int i = email.indexOf('@');
		if (i != email.lastIndexOf('@'))
			return false;

		if (email.indexOf("..") > -1)
			return false;

		if (email.indexOf("--") > -1)
			return false;

		return true;
	}

	/**
	 * 주민등록번호의 형식을 검사한다.
	 *
	 * @param regcode1 주민등록 번호 앞자리.
	 * @param regcode2 주민등록 번호 뒷자리.
	 * @param str      검사 하고자 하는 주민등록번호의 문자열.
	 * @return 문자열이 주민등록번호이면 'true', 아니면 'false'
	 */
	public static boolean isRegcode(String regcode1, String regcode2) {
		return isRegcode(regcode1 + regcode2);
	}

	/**
	 * 주민등록번호의 형식을 검사한다.
	 *
	 * @param regcode 주민등록 번호.
	 * @return 문자열이 주민등록번호이면 'true', 아니면 'false'
	 */
	public static boolean isRegcode(String regcode) {
		if (regcode == null)
			return false;

		regcode = replace(regcode, "-", "");

		if (!compareLength(regcode, 13) || !isNumber(regcode))
			return false;

		if (Integer.parseInt(regcode.substring(2, 4)) > 12)
			return false;

		if (Integer.parseInt(regcode.substring(4, 6)) > 31)
			return false;

		if ("1234".indexOf(regcode.charAt(6)) < 0)
			return false;

		int sum = 0;
		byte code = 2;

		for (int i = 0; i < 12; i++) {
			sum += Integer.parseInt(regcode.substring(i, i + 1)) * code++;

			if (code > 9)
				code = 2;
		}
		sum = 11 - (sum % 11);
		if (sum > 9)
			sum -= 10;

		if (Integer.parseInt(regcode.substring(12)) != sum)
			return false;
		return true;
	}

	/**
	 * 한글 문자의 마지막 문자의 종성 코드값을 추출
	 *
	 * @param c 추출 하고자 하는 문자
	 * @return 존재하지 않으면 '0', 존재하면 코드값 (한글이 아닐때 '-1')
	 */
	public static int getLastElementCode(char c) {
		if (!isKorean(c))
			return -1;
		return (c - 0xAC00) % 28;
	}

	/**
	 * 한글 문자열의 마지막 문자의 종성 코드값을 추출
	 *
	 * @param str 추출 하고자 하는 문자열
	 * @return 존재하지 않으면 '0', 존재하면 코드값 (한글이 아닐때 '-1')
	 */
	public static int getLastElementCode(String str) {
		if (str == null)
			return -1;

		str = str.trim();
		int len = str.length();
		if (len == 0)
			return -1;

		return getLastElementCode(str.charAt(len - 1));
	}

	/**
	 * 마지막 한글 문자의 종성이 존제하는 검사
	 *
	 * @param c 검사 하고자 하는 문자
	 * @return 존재하지 않으면 'false', 존재하면 'true'
	 */
	public static boolean hasLastElement(char c) {
		if (getLastElementCode(c) > 0)
			return true;
		return false;
	}

	/**
	 * 한글 만자열의 마지막 문자의 종성이 존제하는 검사
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @return 존재하지 않으면 'false', 존재하면 'true'
	 */
	public static boolean hasLastElement(String str) {
		if (str == null)
			return false;

		str = str.trim();
		int len = str.length();
		if (len == 0)
			return false;

		return hasLastElement(str.charAt(len - 1));
	}

	/**
	 * 한글 문자의 초성을 추출
	 *
	 * @param c 첫번째 문자의 요소를 추출할 문자열
	 * @return 한글 문자의 초성
	 */
	public static char getFirstElement(char c) {
		if (!isKorean(c))
			return c;
		return firstSounds[(c - 0xAC00) / (21 * 28)];
	}

	/**
	 * 문자열의 첫번째 요소를 추출 (한글일 경우 초성을 추출)
	 *
	 * @param str 첫번째 문자의 요소를 추출할 문자열
	 * @return 첫번째 요소 (한글일 경우 첫번째 문자의 자음)
	 */
	public static char getFirstElement(String str) {
		if (str == null)
			return '\u0000';

		str = str.trim();
		int len = str.length();
		if (len == 0)
			return '\u0000';

		return getFirstElement(str.charAt(0));
	}

	/**
	 * 문자열의 바이트 길이를 주어진 길이와 비교한다.
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @param len 검사 하고자 하는 길이
	 * @return 문자열의 바이트 길이가 주어진 길이와 같으면 'true' or 'false'
	 */
	public static boolean compareByteLength(String str, int len) {
		return compareByteLength(str, len, "8859_1");
	}

	/**
	 * 문자열의 바이트 길이를 주어진 길이와 비교한다.
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @param len 검사 하고자 하는 길이
	 * @param enc 문자 인코딩
	 * @return 문자열의 바이트 길이가 주어진 길이와 같으면 'true' or 'false'
	 */
	public static boolean compareByteLength(String str, int len, String enc) {
		str = str.trim();
		try {
			int l = str.getBytes(enc).length;
			if (l == len)
				return true;
		} catch (UnsupportedEncodingException _ex) {
		}
		return false;
	}

	/**
	 * 문자열의 바이트 길이를 주어진 최소, 최대 길이와 비교한다.
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @param min 검사 하고자 하는 최소 길이
	 * @param max 검사 하고자 하는 최대 길이
	 * @return 문자열의 바이트 길이가 유효하면 'true' or 'false'
	 */
	public static boolean compareByteLength(String str, int min, int max) {
		return compareByteLength(str, min, max, "8859_1");
	}

	/**
	 * 문자열의 바이트 길이를 주어진 최소, 최대 길이와 비교한다.
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @param min 검사 하고자 하는 최소 길이
	 * @param max 검사 하고자 하는 최대 길이
	 * @param enc 문자 인코딩
	 * @return 문자열의 바이트 길이가 유효하면 'true' or 'false'
	 */
	public static boolean compareByteLength(String str, int min, int max, String enc) {
		str = str.trim();
		try {
			int l = str.getBytes(enc).length;
			if (l >= min && l <= max)
				return true;
		} catch (UnsupportedEncodingException _ex) {
		}
		return false;
	}

	/**
	 * 문자열의 길이를 주어진 길이와 비교한다.
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @param len 검사 하고자 하는 길이
	 * @return 문자열의 길이가 주어진 길이와 같으면 'true' or 'false'
	 */
	public static boolean compareLength(String str, int len) {
		str = str.trim();
		int l = str.length();
		if (l == len)
			return true;
		return false;
	}

	/**
	 * 문자열의 길이를 주어진 최소, 최대 길이와 비교한다.
	 *
	 * @param str 검사 하고자 하는 문자열
	 * @param min 검사 하고자 하는 최소 길이
	 * @param max 검사 하고자 하는 최대 길이
	 * @return 문자열의 길이가 유효하면 'true' or 'false'
	 */
	public static boolean compareLength(String str, int min, int max) {
		str = str.trim();
		int l = str.length();
		if (l < min || l > max)
			return false;
		return true;
	}

	/**
	 * 문자열을 주어진 길이만큼 자른후 ...을 붙인다.
	 *
	 * @param s   자를 문자열.
	 * @param len 자를 문자열의 길이.
	 * @return 바뀐 문자열.
	 */
	public static String cut(String s, int len) {
		return cut(s, len, "...");
	}

	/**
	 * 문자열을 주어진 길이만큼 자른 후 prefix를 붙인다..
	 *
	 * @param s      자를 문자열.
	 * @param len    자를 문자열의 길이.
	 * @param prefix 자른후에 뒤에 붙일 문자열.
	 * @return 바뀐 문자열.
	 */
	public static String cut(String s, int len, String prefix) {
		if (s == null)
			return null;

		s = s.trim();
		if (s.equals(""))
			return s;

		int l = s.length();
		if (0 >= len)
			return "";
		if (l < len)
			return s;

		return s.substring(0, len) + prefix;
	}

	/**
	 * 파일에 문자열을 추가
	 * 
	 * @param fil String
	 * @param str String
	 * @throws IOException
	 */
	public static void appendStr(String fil, String str) throws IOException {
		FileInputStream i = new FileInputStream(fil);
		byte buf[];
		buf = new byte[10000];
		i.read(buf, 1, i.available());
		i.close();
		String old = new String(buf);
		FileOutputStream f = new FileOutputStream(fil);
		f.write(old.getBytes());
		f.write(str.getBytes());
		f.close();
	}

	/**
	 * ASCII 를 KSC5601 변환
	 */
	public static String asc2ksc(String str) {
		if (str == null || str.equals(""))
			return "";
		String result = null;
		try {
			byte[] raws = str.getBytes("8859_1");
			result = new String(raws, "KSC5601");
		} catch (java.io.UnsupportedEncodingException e) {
			// System.out.println(e.toString());
		}
		return result;
	}

	/**
	 * KSC5601 를 ASCII 변환
	 */
	public static String ksc2asc(String str) {
		if (str.equals(""))
			return "";
		String result = null;

		try {
			byte[] raws = str.getBytes("KSC5601");
			result = new String(raws, "8859_1");
		} catch (java.io.UnsupportedEncodingException e) {
			// System.out.println(e.toString());
		}
		return result;
	}

	/**
	 * KSC5601 를 ASCII 변환하여 URLEncoding 처리를 한다.
	 */
	public static String HURLEncode(String str) {
		return java.net.URLEncoder.encode(str);
	}

	/**
	 * 문자열을 바꾼다.
	 *
	 * @param src    바꿀 문자열.
	 * @param oldStr 과거의 문자열.
	 * @param newStr 새로운 문자열.
	 * @return 바뀐 문자열.
	 */
	public static String replace(String src, String oldstr, String newstr) {
		if (src == null || oldstr == null)
			return null;

		if (src == "" || oldstr == "")
			return src;

		try {
			StringBuffer dest = new StringBuffer("");
			int len = oldstr.length();
			int srclen = src.length();
			int pos = 0;
			int oldpos = 0;

			while ((pos = src.indexOf(oldstr, oldpos)) >= 0) {
				dest.append(src.substring(oldpos, pos));
				dest.append(newstr);
				oldpos = pos + len;
			}

			if (oldpos < srclen)
				dest.append(src.substring(oldpos, srclen));

			return dest.toString();
		} catch (Exception ex) {
			// System.out.println("StringUtil Error : " + ex);
			return src;
		}

	}

	/**
	 * 파일로부터 읽어 온 문자열을 리턴한다
	 */
	public static String toStr(String file) throws IOException {
		FileInputStream f = new FileInputStream(file);
		byte buf[];
		buf = new byte[10000];
		f.read(buf, 1, f.available());
		f.close();
		return new String(buf);
	}

	/**
	 * 특정 delimiter로 String을 Vector로 변환한다.
	 */
	public static Vector split(String s, String del) {
		Vector v = new Vector();
		if (!s.trim().equals("")) {
			try {
				StringTokenizer stringToken = new StringTokenizer(s, del);
				while (stringToken.hasMoreTokens()) {
					String sElement = stringToken.nextToken();
					if (sElement != null) {
						v.addElement(sElement);
					} else {
						v.addElement("");
					}
				}
			} catch (Exception e) {
				// System.out.println("Split Exception Occured!!");
			}
		}
		return v;
	}

	/**
	 * 특정 delimiter로 Vector를 String으로 변환한다.
	 */
	public static String merge(Vector v, String del) {
		String s = "";
		for (int i = 0; i < v.size(); i++) {
			if (i != v.size() - 1)
				s += v.elementAt(i).toString() + del;
			else
				s += v.elementAt(i).toString();
		}
		return s;
	}

	/**
	 * 특정 Object를 "0000..."의 자리수로 변환한다.
	 */
	public static String format(Object source, int formatLen) {
		return format(source, formatLen, '0', "");
	}

	/**
	 * 특정 Object를 "0000..."의 자리수로 변환하며 앞에 prefix를 포함한다. formatLen 는 prefix를 포함한 길이임.
	 */
	public static String format(Object source, int formatLen, String prefix) {
		return format(source, formatLen, '0', prefix);
	}

	/**
	 * 특정 Object를 특정 Charater 자리수로 변환한다.
	 */
	public static String format(Object source, int formatLen, char formatChar) {
		return format(source, formatLen, formatChar, "");
	}

	/**
	 * 특정 Object를 특정 Charater 자리수로 변환한다.
	 */
	public static String format(Object source, int formatLen, char formatChar, String prefix) {
		StringBuffer sb = new StringBuffer(formatLen);
		sb.insert(0, prefix);
		for (int i = prefix.length(); i < formatLen; i++) {
			sb.insert(i, formatChar);
		}
		return format(source, sb.toString());
	}

	/**
	 * String을 특정 String의 자리수로 변환한다.
	 */
	public static String format(Object source, String formatStr) {
		return formatStr.substring(0, formatStr.length() - source.toString().length()) + source.toString();
	}

	/**
	 * LF를 <BR>
	 * 로 바꾼다. space 를 &nbsp; 로 <% %> 를 &lt;% %&gt;
	 */
	public static String string2HTML(String source) {
		return string2HTML(source, false); // 기본은 HTML을 사용하지 않음
	}

	/**
	 * LF를 <BR>
	 * 로 바꾼다. space 를 &nbsp; 로 <% %> 를 &lt;% %&gt; HTML 사용 여부
	 */
	public static String string2HTML(String source, boolean useHtml) {

		if (source == null)
			return null;
		StringBuffer dest = new StringBuffer(source);
		for (int i = 0; i < dest.length(); i++) {
			switch (dest.charAt(i)) {
			case '\n':
				dest = dest.replace(i, i + 1, "<br>");
				break;
			case ' ':
				try {
					if (dest.charAt(i + 1) == ' ')
						dest = dest.replace(i, i + 1, "&nbsp;");
				} catch (Exception ex) {
				}
				break;
			case '%':
				try {
					if (dest.charAt(i - 1) == '<')
						dest = dest.replace(i - 1, i, "&lt;");
					if (dest.charAt(i + 1) == '>')
						dest = dest.replace(i + 1, i + 2, "&gt;");
				} catch (Exception ex) {
				}
				break;
			// html 막기
			case '<':
				if (!useHtml) {
					dest = dest.replace(i, i + 1, "&lt;");
				}
				break;
			}
		}
		return dest.toString();
	}

	/**
	 * <BR>
	 * 를 LF 로 바꾼다. &nbsp; 를 space로 &lt;% %&gt; 를 <% %>
	 */
	public static String HTML2String(String source) {
		if (source == null)
			return null;
		String stemp = source;
		stemp = replace(stemp, "<br>", "\n");
		stemp = replace(stemp, "&nbsp;", " ");
		stemp = replace(stemp, "&lt;", "<");
		stemp = replace(stemp, "&gt;", ">");
		return stemp;
	}
	/*
		*//**
			 * BASE64 Encoding
			 *//*
				 * public static String Base64Encoding(String source) { return
				 * Base64Encoding(source, true); }
				 */

	/*	*//**
			 * BASE64 Encoding
			 *//*
				 * public static String Base64Encoding(String source, boolean urlEncode) { if
				 * (source == null) return null; BASE64Encoder be = new BASE64Encoder(); if
				 * (urlEncode) return java.net.URLEncoder.encode(be.encode(source.getBytes()));
				 * else return be.encode(source.getBytes());
				 * 
				 * }
				 */

	/*	*//**
			 * BASE64 Decoding
			 *//*
				 * public static String Base64Decoding(String source){ if (source == null)
				 * return null; try { BASE64Decoder be = new BASE64Decoder(); return new
				 * String(be.decodeBuffer(source),"euc-kr"); } catch (Exception e) { return
				 * source; } }
				 */

	/**
	 * 첫자를 대문자로
	 * 
	 * @param args String src
	 */
	public static String capitalize(final String string) throws Exception {
		if (string == null)
			throw new RuntimeException("Source string is null.");
		if (string.equals(""))
			throw new RuntimeException("Source string is Empty.");

		return Character.toUpperCase(string.charAt(0)) + string.substring(1);
	}

	/**
	 * 문자열 뽑아내기
	 *
	 * @param buff   Stirng buffer to use for substitution (buffer is not reset)
	 * @param from   String to substitute from
	 * @param to     String to substitute to
	 * @param string String to look for from in
	 * @return Substituted string
	 */
	public static String subst(final StringBuffer buff, final String from, final String to, final String string) {
		int begin = 0, end = 0;

		while ((end = string.indexOf(from, end)) != -1) {
			// append the first part of the string
			buff.append(string.substring(begin, end));

			// append the replaced string
			buff.append(to);

			// update positions
			begin = end + from.length();
			end = begin;
		}

		// append the rest of the string
		buff.append(string.substring(begin, string.length()));

		return buff.toString();
	}

	/**
	 * 문자열 뽑아내기
	 *
	 * @param from   String to substitute from
	 * @param to     String to substitute to
	 * @param string String to look for from in
	 * @return Substituted string
	 */
	public static String subst(final String from, final String to, final String string) {
		return subst(new StringBuffer(), from, to, string);
	}

	/**
	 * 문자열 뽑아내기
	 *
	 * @param buff       String buffer to use for substitution (buffer is not reset)
	 * @param string     String to subst mappings in
	 * @param map        Map of from->to strings
	 * @param beginToken Beginning token
	 * @param endToken   Ending token
	 * @return Substituted string
	 */
	public static String subst(final StringBuffer buff, final String string, final Map map, final String beginToken,
			final String endToken) {
		int begin = 0, rangeEnd = 0;
		Range range;

		while ((range = rangeOf(beginToken, endToken, string, rangeEnd)) != null) {
			// append the first part of the string
			buff.append(string.substring(begin, range.begin));

			// Get the string to replace from the map
			String key = string.substring(range.begin + beginToken.length(), range.end);
			Object value = map.get(key);
			// if mapping does not exist then use empty;
			if (value == null)
				value = EMPTY;

			// append the replaced string
			buff.append(value);

			// update positions
			begin = range.end + endToken.length();
			rangeEnd = begin;
		}

		// append the rest of the string
		buff.append(string.substring(begin, string.length()));

		return buff.toString();
	}

	/**
	 * 문자열 뽑아내기
	 *
	 * @param string     String to subst mappings in
	 * @param map        Map of from->to strings
	 * @param beginToken Beginning token
	 * @param endToken   Ending token
	 * @return Substituted string
	 */
	public static String subst(final String string, final Map map, final String beginToken, final String endToken) {
		return subst(new StringBuffer(), string, map, beginToken, endToken);
	}

	/**
	 * Substitute index identifiers with the replacement value from the given array
	 * for the corresponding index.
	 *
	 * @param buff    The string buffer used for the substitution (buffer is not
	 *                reset).
	 * @param string  String substitution format.
	 * @param replace Array of strings whose values will be used as replacements in
	 *                the given string when a token with their index is found.
	 * @param token   The character token to specify the start of an index
	 *                reference.
	 * @return Substituted string.
	 */
	public static String subst(final StringBuffer buff, final String string, final String replace[], final char token) {
		int i = string.length();
		for (int j = 0; j >= 0 && j < i; j++) {
			char c = string.charAt(j);

			// if the char is the token, then get the index
			if (c == token) {

				// if we aren't at the end of the string, get the index
				if (j != i) {
					int k = Character.digit(string.charAt(j + 1), 10);

					if (k == -1) {
						buff.append(string.charAt(j + 1));
					} else if (k < replace.length) {
						buff.append(replace[k]);
					}

					j++;
				}
			} else {
				buff.append(c);
			}
		}

		return buff.toString();
	}

	/**
	 * Substitute index identifiers with the replacement value from the given array
	 * for the corresponding index.
	 *
	 * @param string  String substitution format.
	 * @param replace Array of strings whose values will be used as replacements in
	 *                the given string when a token with their index is found.
	 * @param token   The character token to specify the start of an index
	 *                reference.
	 * @return Substituted string.
	 */
	public static String subst(final String string, final String replace[], final char token) {
		return subst(new StringBuffer(), string, replace, token);
	}

	/**
	 * Substitute index identifiers (with <code>%</code> for the index token) with
	 * the replacement value from the given array for the corresponding index.
	 *
	 * @param string  String substitution format.
	 * @param replace Array of strings whose values will be used as replacements in
	 *                the given string when a token with their index is found.
	 * @return Substituted string.
	 */
	public static String subst(final String string, final String replace[]) {
		return subst(new StringBuffer(), string, replace, '%');
	}

	/**
	 * Return the range from a begining token to an ending token.
	 *
	 * @param beginToken String to indicate begining of range.
	 * @param endToken   String to indicate ending of range.
	 * @param string     String to look for range in.
	 * @param fromIndex  Beginning index.
	 * @return (begin index, end index) or <i>null</i>.
	 */
	public static Range rangeOf(final String beginToken, final String endToken, final String string,
			final int fromIndex) {
		int begin = string.indexOf(beginToken, fromIndex);

		if (begin != -1) {
			int end = string.indexOf(endToken, begin + 1);
			if (end != -1) {
				return new Range(begin, end);
			}
		}

		return null;
	}

	/**
	 * Return the range from a begining token to an ending token.
	 *
	 * @param beginToken String to indicate begining of range.
	 * @param endToken   String to indicate ending of range.
	 * @param string     String to look for range in.
	 * @return (begin index, end index) or <i>null</i>.
	 */
	public static Range rangeOf(final String beginToken, final String endToken, final String string) {
		return rangeOf(beginToken, endToken, string, 0);
	}

	/////////////////////////////////////////////////////////////////////////
	// Range Methods //
	/////////////////////////////////////////////////////////////////////////

	/**
	 * Represents a range between two integers.
	 */
	public static class Range {
		/** The beginning of the range. */
		public int begin;

		/** The end of the range. */
		public int end;

		/**
		 * Construct a new range.
		 *
		 * @param begin The beginning of the range.
		 * @param end   The end of the range.
		 */
		public Range(int begin, int end) {
			this.begin = begin;
			this.end = end;
		}

		/**
		 * Default constructor.
		 */
		public Range() {
		}
	}

	/////////////////////////////////////////////////////////////////////////
	// Spliting Methods //
	/////////////////////////////////////////////////////////////////////////

	/**
	 * Split up a string into multiple strings based on a delimiter.
	 *
	 * @param string String to split up.
	 * @param delim  Delimiter.
	 * @param limit  Limit the number of strings to split into (-1 for no limit).
	 * @return Array of strings.
	 */
	public static String[] split2Array(final String string, final String delim, final int limit) {
		// get the count of delim in string, if count is > limit
		// then use limit for count. The number of delimiters is less by one
		// than the number of elements, so add one to count.
		int count = count(string, delim) + 1;
		if (limit > 0 && count > limit) {
			count = limit;
		}

		String strings[] = new String[count];
		int begin = 0;

		for (int i = 0; i < count; i++) {
			// get the next index of delim
			int end = string.indexOf(delim, begin);

			// if the end index is -1 or if this is the last element
			// then use the string's length for the end index
			if (end == -1 || i + 1 == count)
				end = string.length();

			// if end is 0, then the first element is empty
			if (end == 0)
				strings[i] = EMPTY;
			else
				strings[i] = string.substring(begin, end);

			// update the begining index
			begin = end + 1;
		}

		return strings;
	}

	/**
	 * Split up a string into multiple strings based on a delimiter.
	 *
	 * @param string String to split up.
	 * @param delim  Delimiter.
	 * @return Array of strings.
	 */
	public static String[] split2Array(final String string, final String delim) {
		return split2Array(string, delim, -1);
	}

	/////////////////////////////////////////////////////////////////////////
	// Joining/Concatenation Methods //
	/////////////////////////////////////////////////////////////////////////

	/**
	 * Join an array of strings into one delimited string.
	 *
	 * @param buff  String buffered used for join (buffer is not reset).
	 * @param array Array of objects to join as strings.
	 * @param delim Delimiter to join strings with or <i>null</i>.
	 * @return Joined string.
	 */
	public static String join(final StringBuffer buff, final Object array[], final String delim) {
		boolean haveDelim = (delim != null);

		for (int i = 0; i < array.length; i++) {
			buff.append(array[i]);

			// if this is the last element then don't append delim
			if (haveDelim && (i + 1) < array.length) {
				buff.append(delim);
			}
		}

		return buff.toString();
	}

	/**
	 * Join an array of strings into one delimited string.
	 *
	 * @param array Array of objects to join as strings.
	 * @param delim Delimiter to join strings with or <i>null</i>.
	 * @return Joined string.
	 */
	public static String join(final Object array[], final String delim) {
		return join(new StringBuffer(), array, delim);
	}

	/**
	 * Convert and join an array of objects into one string.
	 *
	 * @param array Array of objects to join as strings.
	 * @return Converted and joined objects.
	 */
	public static String join(final Object array[]) {
		return join(array, null);
	}

	/**
	 * Convert and join an array of bytes into one string.
	 *
	 * @param array Array of objects to join as strings.
	 * @return Converted and joined objects.
	 */
	public static String join(final byte array[]) {
		Byte bytes[] = new Byte[array.length];
		for (int i = 0; i < bytes.length; i++) {
			bytes[i] = new Byte(array[i]);
		}

		return join(bytes, null);
	}

	/**
	 * Return a string composed of the given array.
	 *
	 * @param buff      Buffer used to construct string value (not reset).
	 * @param array     Array of objects.
	 * @param prefix    String prefix.
	 * @param separator Element sepearator.
	 * @param suffix    String suffix.
	 * @return String in the format of: prefix + n ( + separator + n+i)* + suffix.
	 */
	public static String join(final StringBuffer buff, final Object[] array, final String prefix,
			final String separator, final String suffix) {
		buff.append(prefix);
		join(buff, array, separator);
		buff.append(suffix);

		return buff.toString();
	}

	/**
	 * Return a string composed of the given array.
	 *
	 * @param array     Array of objects.
	 * @param prefix    String prefix.
	 * @param separator Element sepearator.
	 * @param suffix    String suffix.
	 * @return String in the format of: prefix + n ( + separator + n+i)* + suffix.
	 */
	public static String join(final Object[] array, final String prefix, final String separator, final String suffix) {
		return join(new StringBuffer(), array, prefix, separator, suffix);
	}

	/////////////////////////////////////////////////////////////////////////
	// Counting Methods //
	/////////////////////////////////////////////////////////////////////////

	/**
	 * Count the number of instances of substring within a string.
	 *
	 * @param string    String to look for substring in.
	 * @param substring Sub-string to look for.
	 * @return Count of substrings in string.
	 */
	public static int count(final String string, final String substring) {
		int count = 0;
		int idx = 0;

		while ((idx = string.indexOf(substring, idx)) != -1) {
			idx++;
			count++;
		}

		return count;
	}

	/**
	 * Count the number of instances of character within a string.
	 *
	 * @param string String to look for substring in.
	 * @param c      Character to look for.
	 * @return Count of substrings in string.
	 */
	public static int count(final String string, final char c) {
		return count(string, String.valueOf(c));
	}

	/////////////////////////////////////////////////////////////////////////
	// Padding Methods //
	/////////////////////////////////////////////////////////////////////////

	/**
	 * Return a string padded with the given string for the given count.
	 *
	 * @param buff   String buffer used for padding (buffer is not reset).
	 * @param string Pad element.
	 * @param count  Pad count.
	 * @return Padded string.
	 */
	public static String pad(final StringBuffer buff, final String string, final int count) {
		for (int i = 0; i < count; i++) {
			buff.append(string);
		}

		return buff.toString();
	}

	/**
	 * Return a string padded with the given string for the given count.
	 *
	 * @param string Pad element.
	 * @param count  Pad count.
	 * @return Padded string.
	 */
	public static String pad(final String string, final int count) {
		return pad(new StringBuffer(), string, count);
	}

	/**
	 * Return a string padded with the given string value of an object for the given
	 * count.
	 *
	 * @param obj   Object to convert to a string.
	 * @param count Pad count.
	 * @return Padded string.
	 */
	public static String pad(final Object obj, final int count) {
		return pad(new StringBuffer(), String.valueOf(obj), count);
	}

	/////////////////////////////////////////////////////////////////////////
	// Misc Methods //
	/////////////////////////////////////////////////////////////////////////

	/**
	 * <p>
	 * Compare two strings.
	 *
	 * <p>
	 * Both or one of them may be null.
	 *
	 * @return true if object equals or intern ==, else false.
	 */
	public static boolean compare(final String me, final String you) {
		// If both null or intern equals
		if (me == you)
			return true;

		// if me null and you are not
		if (me == null && you != null)
			return false;

		// me will not be null, test for equality
		return me.equals(you);
	}

	/**
	 * Check if the given string is empty.
	 *
	 * @param string String to check
	 * @return True if string is empty
	 */
	public static boolean isEmpty(final String string) {
		return string.equals(EMPTY);
	}

	public static boolean isNull(String srcString) {
		return isNull(srcString, true);
	}

	public static boolean isNull(String src, boolean isTrim) {
		boolean isNullStr = false;

		if (isTrim && src != null && !src.isEmpty()) {
			src = src.trim();
		}

		if (src == null || src.isEmpty()) {
			isNullStr = true;
		}

		return isNullStr;
	}

	/**
	 * Return the <i>nth</i> index of the given token occurring in the given string.
	 *
	 * @param string String to search.
	 * @param token  Token to match.
	 * @param index  <i>Nth</i> index.
	 * @return Index of <i>nth</i> item or -1.
	 */
	public static int nthIndexOf(final String string, final String token, final int index) {
		int j = 0;

		for (int i = 0; i < index; i++) {
			j = string.indexOf(token, j + 1);
			if (j == -1)
				break;
		}

		return j;
	}

	/**
	 * Trim each string in the given string array.
	 *
	 * <p>
	 * This modifies the string array.
	 *
	 * @param strings String array to trim.
	 * @return String array with each element trimmed.
	 */
	public static String[] trim(final String[] strings) {
		for (int i = 0; i < strings.length; i++) {
			strings[i] = strings[i].trim();
		}

		return strings;
	}

	/**
	 * Make a URL from the given string.
	 *
	 * <p>
	 * If the string is a properly formatted file URL, then the file portion will be
	 * made canonical.
	 *
	 * <p>
	 * If the string is an invalid URL then it will be converted into a file URL.
	 *
	 * @param urlspec        The string to construct a URL for.
	 * @param relativePrefix The string to prepend to relative file paths, or null
	 *                       to disable prepending.
	 * @return A URL for the given string.
	 *
	 * @throws MalformedURLException Could not make a URL for the given string.
	 */
	public static URL toURL(String urlspec, final String relativePrefix) throws MalformedURLException {
		urlspec = urlspec.trim();

		URL url;

		try {
			url = new URL(urlspec);
			if (url.getProtocol().equals("file")) {
				url = makeURLFromFilespec(url.getFile(), relativePrefix);
			}
		} catch (Exception e) {
			// make sure we have a absolute & canonical file url
			try {
				url = makeURLFromFilespec(urlspec, relativePrefix);
			} catch (IOException n) {
				//
				// jason: or should we rethrow e?
				//
				throw new MalformedURLException(n.toString());
			}
		}

		return url;
	}

	/** A helper to make a URL from a filespec. */
	private static URL makeURLFromFilespec(final String filespec, final String relativePrefix) throws IOException {
		// make sure the file is absolute & canonical file url
		File file = new File(filespec);

		// if we have a prefix and the file is not abs then prepend
		if (relativePrefix != null && !file.isAbsolute()) {
			file = new File(relativePrefix, filespec);
		}

		// make sure it is canonical (no ../ and such)
		file = file.getCanonicalFile();

		return file.toURL();
	}

	/**
	 * Make a URL from the given string.
	 *
	 * @see #toURL(String,String)
	 *
	 * @param urlspec The string to construct a URL for.
	 * @return A URL for the given string.
	 *
	 * @throws MalformedURLException Could not make a URL for the given string.
	 */
	public static URL toURL(final String urlspec) throws MalformedURLException {
		return toURL(urlspec, null);
	}

	/**
	 * Returns a new string with all the whitespace removed
	 *
	 * @param s the source string
	 * @return the string without whitespace or null
	 */
	public static String removeWhiteSpace(String s) {
		String retn = null;

		if (s != null) {
			int len = s.length();
			StringBuffer sbuf = new StringBuffer(len);

			for (int i = 0; i < len; i++) {
				char c = s.charAt(i);

				if (!Character.isWhitespace(c))
					sbuf.append(c);
			}
			retn = sbuf.toString();
		}
		return retn;
	}

	/**
	 * Object가 null 또는 "null"인 경우에 공백("")을 리턴하는 함수
	 * 
	 * @param o
	 * @return
	 */
	public static String null2String(Object o) {
		String result = null;

		if (null == o || "null".equals(o.toString())) {
			result = EMPTY;
		} else {
			result = o.toString();
		}
		return result;
	}

	public static String null2String(Object source, String value) {
		if (source == null) {
			return value;
		}

		if (source instanceof String) {
			if (new String(source.toString()).isEmpty()) {
				return value;
			}
		}

		return new String(source.toString());
	}

	public static String getReplaceString(String sString, String sDefault) {
		String returnStr = "";
		if (sString == null || sString.equals("null")) {
			return sDefault;
		} else {
			if (sString.contains("\\")) {
				returnStr = sString.replaceAll("\\\\", "￦");
			} else {
				returnStr = sString;
			}

		}
		/*
		 * replaceAll()에.... 1.[]씌워야 할 것들
		 * 
		 * ⇒ [*] + ⇒ [+] $ ⇒ [$] | ⇒ [|]
		 * 
		 * 
		 * 2. \\를 붙여줘야 하는 것들.
		 * 
		 * ( ⇒ \\( ) ⇒ \\) { ⇒ \\{ } ⇒ \\} ^ ⇒ \\^ [ ⇒ \\[ ] ⇒ \\]
		 * 
		 * 
		 * 3. 자바의 특수문자는 \을 쓴다.
		 * 
		 * " ⇒ \"
		 */
		return returnStr;
	}

///////////////////////////////////////////////////////////////////////////////////////////

	public static boolean getBoolean(String value, boolean defaultValue) {
		if (value == null)
			return defaultValue;
		if (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("on") || value.equalsIgnoreCase("y")
				|| value.equalsIgnoreCase("t") || value.equalsIgnoreCase("yes"))
			return true;
		return false;
	}

	public static boolean isNullNotTrim(String str) {
		if (str == null || str.length() == 0)
			return true;
		return false;
	}

	public static String toDbStyle(String name) {
		StringBuilder sb = new StringBuilder(name.replace('.', '_'));
		for (int i = 1; i < sb.length() - 1; i++) {
			if (Character.isLowerCase(sb.charAt(i - 1)) && Character.isUpperCase(sb.charAt(i))
					&& Character.isLowerCase(sb.charAt(i + 1))) {
				sb.insert(i++, '_');
			}
		}
		return sb.toString().toUpperCase();
	}

	public static float null2float(String source) {
		if (isNull(source)) {
			return 0.0F;
		}
		return Float.parseFloat(source);
	}

	public static int null2zero(Object obj, int val) {
		int returnVal = 0;

		if (obj == null) {
			return val;
		} else {
			returnVal = Integer.parseInt(obj.toString());
		}

		return returnVal;
	}

	public static int null2zero(Object obj) {
		return null2zero(obj, 0);
	}

	public static String unescape(String str) {
		String reStr = str;
		String[] oStr = { "&amp;", "&lt;", "&gt;", "&quot;", "&apos;" };
		String[] nStr = { "&", "<", ">", "\"", "'" };

		for (int i = 0; i < oStr.length; i++) {
			reStr = reStr.replaceAll(oStr[i], nStr[i]);
		}

		return reStr;
	}

	public static boolean null2boolean(Object obj, boolean flag) {
		boolean returnVal = false;

		if (obj == null) {
			return flag;
		} else {
			returnVal = Boolean.parseBoolean(obj.toString());
		}

		return returnVal;
	}

	/**
	 * CLOB를 String으로 변환해서 리턴합니다.
	 * 
	 * @param clob
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	public static String clobToString(Clob clob) throws SQLException, IOException {

		if (clob == null) {
			return "";
		}

		StringBuffer strOut = new StringBuffer();

		String str = "";

		BufferedReader br = new BufferedReader(clob.getCharacterStream());

		while ((str = br.readLine()) != null) {
			strOut.append(str);
		}
		return strOut.toString();
	}
	
	/**
	 * 난수 생성 
	 * @param clob
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	public static String createRandomString() throws SQLException, IOException {
		
		String returnRandomStr = "";
		String pswd = "";StringBuffer sb = new StringBuffer();
		StringBuffer sc = new StringBuffer("!\"#$%&'()*+,-./:;<=>?@[＼]^_`{|}~");
		
		sb.append((char)((Math.random() * 26)+65));
		
		for( int i = 0; i<3; i++) {
			sb.append((char)((Math.random() * 26)+65));
		}
		
		for( int i = 0; i<4; i++) {
			sb.append((char)((Math.random() * 26)+97));
		}
		
		for( int i = 0; i<2; i++) {
			sb.append((char)((Math.random() * 10)+48));
		}
		
		sb.setCharAt(((int)(Math.random()*3)+1), sc.charAt((int)(Math.random()*sc.length()-1)));
		sb.setCharAt(((int)(Math.random()*4)+4), sc.charAt((int)(Math.random()*sc.length()-1)));
		
		returnRandomStr = sb.toString();
		
		return returnRandomStr;
	}
	

} // class StringUtil