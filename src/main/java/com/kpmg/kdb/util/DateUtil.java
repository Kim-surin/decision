package com.kpmg.kdb.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

/**
 * Date관련 자료 모음
 * 
 * @author D.Cat
 * 
 */
public class DateUtil {

	public static final String getYYYYMMDD(int year, int month, int day, String sep) {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.YEAR, year);
		cal.add(cal.MONTH, month);
		cal.add(cal.DATE, day);
		String yyyy = StringUtil.format(new Integer(cal.get(Calendar.YEAR)), 4);
		String mm = StringUtil.format(new Integer(cal.get(Calendar.MONTH) + 1), 2);
		String dd = StringUtil.format(new Integer(cal.get(Calendar.DATE)), 2);
		return (yyyy + sep + mm + sep + dd);
	}

	/**
	 * isMaxDate is true then return value is actual lastDay 20120831 isMaxDate
	 * is false then return value is actual firstDay 20120801
	 */
	public static final String getYYYYMMDate(int year, int month, boolean isMaxDate, String sep) {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.YEAR, year);
		cal.add(cal.MONTH, month);
		String yyyy = StringUtil.format(new Integer(cal.get(Calendar.YEAR)), 4);
		String mm = StringUtil.format(new Integer(cal.get(Calendar.MONTH) + 1), 2);
		String dd = StringUtil.format(new Integer(isMaxDate ? cal.getActualMaximum(Calendar.DATE) : cal.getActualMinimum(Calendar.DATE)), 2);
		return (yyyy + sep + mm + sep + dd);
	}
	
	public static String getYYYYMMDateTimeMilliSecond() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalYear(cd) + getFormalMonth(cd) + getFormalDay(cd) + getFormalHour(cd) + getFormalMin(cd) + getFormalSec(cd) + getFormalMSec(cd);
    }

	public static final String getToday(String sep) {
		return getYYYYMMDD(0, 0, 0, sep);
	}

	public static final String getCurrentYear() {
		return getYYYYMMDD(0, 0, 0, "").substring(0, 4);
	}

	public static final String getCurrentYearMM() {
		return getYYYYMMDD(0, 0, 0, "").substring(0, 6);
	}

	public static int getLastDay(int year, int month) {
		Calendar cal = Calendar.getInstance();

		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month - 1); // 왜 달은 0 부터 시작할까..ㅎㅎ
		return cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 달의 최대 일수를 구한다.
	}

	public static String getAfterMonth(int year, int month, String sep) {
		int afterMonth = month + 1;
		int afterYear = year;
		if (afterMonth == 13) {
			afterYear = year + 1;
			afterMonth = 1;
		}
		String pYear = StringUtil.format(new Integer(afterYear), 4);
		String pMonth = StringUtil.format(new Integer(afterMonth), 2);

		return pYear + sep + pMonth;
	}

	public static String getBeforeMonth(int year, int month, String sep) {
		int beforeMonth = month - 1;
		int beforeYear = year;
		if (beforeMonth == 0) {
			beforeYear = year - 1;
			beforeMonth = 12;
		}
		String pYear = StringUtil.format(new Integer(beforeYear), 4);
		String pMonth = StringUtil.format(new Integer(beforeMonth), 2);

		return pYear + sep + pMonth;
	}

	public static String getBeforeMonth(String yyyymm, String sep) {
		int index = sep.equals("") ? 4 : yyyymm.indexOf(sep) + 1;
		return getBeforeMonth(Integer.parseInt(yyyymm.substring(0, 4)), Integer.parseInt(yyyymm.substring(index, index + 2)), sep);
	}

	public static String getAfterMonth(String yyyymm, String sep) {
		int index = sep.equals("") ? 4 : yyyymm.indexOf(sep) + 1;
		return getAfterMonth(Integer.parseInt(yyyymm.substring(0, 4)), Integer.parseInt(yyyymm.substring(index, index + 2)), sep);

	}

	public static String getCurrentYYYYMMDDHHMMSS() {
		Calendar currentDate = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmssssss");
		return df.format(currentDate.getTime());

	}

	/**
	 * 지정된 포맷으로 date를 String으로 리턴한다.
	 * 
	 * @return
	 */
	public static String getSimpleDate(String format) {
		SimpleDateFormat df = new SimpleDateFormat(format);
		return df.format(new Date());
	}

	/**
	 * <p>
	 * 특정 날짜를 인자로 받아 그 일자로부터 주어진 기간만큼 추가한 날을 계산하여 문자열로 리턴한다.
	 * </p>
	 * 
	 * <pre>
	 * String result = DateHelper.getCalcDateAsString(&quot;2004&quot;, &quot;10&quot;, &quot;30&quot;, 2, &quot;day&quot;);
	 * </pre>
	 * 
	 * <p>
	 * <code>result</code>는 "20041101"의 값을 갖는다.
	 * </p>
	 * 
	 * @param sYearPara
	 *            년도
	 * @param sMonthPara
	 *            월
	 * @param sDayPara
	 *            일
	 * @param iTerm
	 *            기간
	 * @param sGuBun
	 *            구분("day":일에 기간을 더함,"month":월에 기간을 더함,"year":년에 기간을 더함.)
	 * @return "년+월+일"
	 */
	public static String getCalcDateAsString(String sYearPara, String sMonthPara, String sDayPara, int iTerm, String sGuBun) {
		return getCalcDateAsString(sYearPara, sMonthPara, sDayPara, iTerm, sGuBun, null);
	}

	/**
	 * <p>
	 * 특정 날짜를 인자로 받아 그 일자로부터 주어진 기간만큼 추가한 날을 계산하여 문자열로 리턴한다.
	 * </p>
	 * 
	 * <pre>
	 * String result = DateHelper.getCalcDateAsString(&quot;2004&quot;, &quot;10&quot;, &quot;30&quot;, 2, &quot;day&quot;);
	 * </pre>
	 * 
	 * <p>
	 * <code>result</code>는 "20041101"의 값을 갖는다.
	 * </p>
	 * 
	 * @param sYearPara
	 *            년도
	 * @param sMonthPara
	 *            월
	 * @param sDayPara
	 *            일
	 * @param iTerm
	 *            기간
	 * @param sGuBun
	 *            구분("day":일에 기간을 더함,"month":월에 기간을 더함,"year":년에 기간을 더함.)
	 * @param sRest
	 *            리턴할 날짜구분("day":날짜만 리턴, "month":월만 리턴, "year":년만 리턴, null:년월일
	 *            리턴)
	 * @return "년+월+일"
	 */
	public static String getCalcDateAsString(String sYearPara, String sMonthPara, String sDayPara, int iTerm, String sGuBun, String sRest) {

		Calendar cd = new GregorianCalendar(Integer.parseInt(sYearPara), Integer.parseInt(sMonthPara) - 1, Integer.parseInt(sDayPara));

		if (StringUtil.compare(sGuBun, "day")) {
			cd.add(Calendar.DATE, iTerm);
		} else if (StringUtil.compare(sGuBun, "month")) {
			cd.add(Calendar.MONTH, iTerm);
		} else if (StringUtil.compare(sGuBun, "year")) {
			cd.add(Calendar.YEAR, iTerm);
		}

		String result = null;

		if ("day".equals(sRest)) {
			result = getFormalDay(cd);
		} else if ("month".equals(sRest)) {
			result = getFormalMonth(cd);
		} else if ("year".equals(sRest)) {
			result = getFormalYear(cd);
		} else {
			result = getFormalYear(cd) + getFormalMonth(cd) + getFormalDay(cd);
		}

		return result;
	}

	/**
	 * <p>
	 * 년도 표시를 네자리로 형식화 한다.
	 * </p>
	 * 
	 * @param cd
	 *            년도를 포함하는 <strong>Calendar</strong> 오브젝트
	 * @return 네자리로 형식화된 년도
	 */
	private static String getFormalYear(Calendar cd) {
		return toString(cd.getTime(), "yyyy", Locale.KOREA);
	}

	/**
	 * <p>
	 * 월(Month) 표시를 두자리로 형식화 한다.
	 * </p>
	 * 
	 * @param cd
	 *            월을 포함하는 <strong>Calendar</strong> 오브젝트
	 * @return 두자리로 형식화된 월
	 */
	private static String getFormalMonth(Calendar cd) {

		return toString(cd.getTime(), "MM", Locale.KOREA);

	}

	/**
	 * <p>
	 * 일(Day) 표시를 두자리로 형식화 한다.
	 * </p>
	 * 
	 * @param cd
	 *            일자를 포함하는 <strong>Calendar</strong> 오브젝트
	 * @return 두자리로 형식화된 일
	 */
	private static String getFormalDay(Calendar cd) {

		return toString(cd.getTime(), "dd", Locale.KOREA);

	}

	/**
	 * <p>
	 * 시간(Hour) 표시를 두자리로 형식화 한다.
	 * </p>
	 * 
	 * @param cd
	 *            시간을 포함하는 <strong>Calendar</strong> 오브젝트
	 * @return 두자리로 형식화된 시간
	 */
	private static String getFormalHour(Calendar cd) {

		return toString(cd.getTime(), "HH", Locale.KOREA);

	}

	/**
	 * <p>
	 * 분(Minute) 표시를 두자리로 형식화 한다.
	 * </p>
	 * 
	 * @param cd
	 *            분을 포함하는 <strong>Calendar</strong> 오브젝트
	 * @return 두자리로 형식화된 분
	 */
	private static String getFormalMin(Calendar cd) {

		return toString(cd.getTime(), "mm", Locale.KOREA);

	}

	/**
	 * <p>
	 * 초(sec) 표시를 두자리로 형식화 한다.
	 * </p>
	 * 
	 * @param cd
	 *            초를 포함하는 <strong>Calendar</strong> 오브젝트
	 * @return 두자리로 형식화된 초
	 */
	private static String getFormalSec(Calendar cd) {

		return toString(cd.getTime(), "ss", Locale.KOREA);

	}

	/**
	 * <p>
	 * 밀리초(millisec) 표시를 세자리로 형식화 한다.
	 * </p>
	 * 
	 * @param cd
	 *            밀리초를 포함하는 <strong>Calendar</strong> 오브젝트
	 * @return 세자리로 형식화된 밀리초
	 */
	private static String getFormalMSec(Calendar cd) {

		return toString(cd.getTime(), "SSS", Locale.KOREA);

	}

	/**
	 * <p>
	 * Date -> String
	 * </p>
	 * 
	 * @param date
	 *            Date which you want to change.
	 * @return String The Date string. Type, yyyyMMdd HH:mm:ss.
	 */
	public static String toString(Date date, String format, Locale locale) {

		if (StringUtil.isNull(format)) {
			format = "yyyy-MM-dd HH:mm:ss";
		}

		if (locale == null) {
			locale = java.util.Locale.KOREA;
		}

		SimpleDateFormat sdf = new SimpleDateFormat(format, locale);

		String tmp = sdf.format(date);

		return tmp;
	}

	/**
	 * <p>
	 * 월의 마지막 일자 구하기
	 * <p>
	 * 
	 * @param year
	 * @param month
	 * @return
	 */
	public static String getLastDay(String year, String month) {
		Integer[] lastdate = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }; // 각
																					// 달의
																					// 마지막
																					// 날짜

		int yearInt = Integer.parseInt(year);
		int monthInt = Integer.parseInt(month);

		if ((0 == (yearInt % 4) && 0 != (yearInt % 100)) || 0 == (yearInt % 400)) { // year를
																					// 가지고
																					// 윤년인지
																					// 검사.
			lastdate[1] = 29; // 윤년인 경우 2월의 마지막 날짜를 29로 입력
		}

		Integer day = lastdate[monthInt - 1];

		return day.toString();
	}

	/**
	 * <p>
	 * 현재 년도를 YYYY 형태로 리턴
	 * </p>
	 * 
	 * @return 년도(YYYY)
	 */
	public static String getCurrentYearAsString() {

		Calendar cd = new GregorianCalendar(Locale.KOREA);

		return getFormalYear(cd);
	}

	/**
	 * <P>
	 * 현재 월을 MM 형태로 리턴
	 * </p>
	 * 
	 * @return 월(MM)
	 */
	public static String getCurrentMonthAsString() {

		Calendar cd = new GregorianCalendar(Locale.KOREA);

		return getFormalMonth(cd);
	}

	/**
	 * <p>
	 * 현재 일을 DD 형태로 리턴
	 * </p>
	 * 
	 * @return 일(DD)
	 */
	public static String getCurrentDayAsString() {

		Calendar cd = new GregorianCalendar(Locale.KOREA);

		return getFormalDay(cd);
	}

	/**
	 * <p>
	 * 현재 시간을 HH 형태로 리턴
	 * </p>
	 * 
	 * @return 시간(HH)
	 */
	public static String getCurrentHourAsString() {

		Calendar cd = new GregorianCalendar(Locale.KOREA);

		return getFormalHour(cd);
	}

	/**
	 * <p>
	 * 현재 분을 mm 형태로 리턴
	 * </p>
	 * 
	 * @return 분(mm)
	 */
	public static String getCurrentMinuteAsString() {

		Calendar cd = new GregorianCalendar(Locale.KOREA);

		return getFormalMin(cd);
	}

	/**
	 * <p>
	 * 현재 초를 ss 형태로 리턴
	 * </p>
	 * 
	 * @return 초(ss)
	 */
	public static String getCurrentSecondAsString() {

		Calendar cd = new GregorianCalendar(Locale.KOREA);

		return getFormalSec(cd);
	}

	/**
	 * <p>
	 * 현재 밀리초를 sss 형태로 리턴
	 * </p>
	 * 
	 * @return 밀리초(sss)
	 */
	public static String getCurrentMilliSecondAsString() {

		Calendar cd = new GregorianCalendar(Locale.KOREA);

		return getFormalMSec(cd);
	}

	private static Calendar stringToCalendar(String day) {
		String strYear = "";
		String strMonth = "";
		String strDate = "";

		strYear = day.substring(0, 4);
		strMonth = day.substring(4, 6);
		strDate = day.substring(6);

		int iYear = Integer.parseInt(strYear);
		int iMonth = Integer.parseInt(strMonth) - 1;
		int iDate = Integer.parseInt(strDate);

		Calendar cz_Tmp = Calendar.getInstance();
		cz_Tmp.set(iYear, iMonth, iDate);
		return cz_Tmp;
	}

	public static int getDays(String from, String to) {
		Calendar calFrom = stringToCalendar(from);
		Calendar calTo = stringToCalendar(to);
		long gab = calTo.getTimeInMillis() - calFrom.getTimeInMillis();
		long lDays = gab / (1000 * 60 * 60 * 24);
		return (int) lDays + 1;
	}
	
	/**
	 * 입력받은 전주의 일요일에 대한 날짜를 리턴합니다. 
	 * @param yyyy
	 * @param mm
	 * @param wk
	 * @return
	 */
	public static String getPreSunday(String yyyyMMdd){
 		
		if(yyyyMMdd == null || yyyyMMdd.length() < 1) {return null;}
		
 		int yyyy=Integer.parseInt(yyyyMMdd.substring(0,4));
 		int mm=Integer.parseInt(yyyyMMdd.substring(4,6))-1;
 		int dd=Integer.parseInt(yyyyMMdd.substring(6,8));
 		
 		
 		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		
		cal.set(yyyy, mm, dd);
		cal.add(Calendar.DATE, -7);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);

 		return formatter.format(cal.getTime());

 	}
	
	
	/**
	 * 입력받은 전주의 일요일에 대한 날짜를 리턴합니다. 
	 * @param yyyy
	 * @param mm
	 * @param wk
	 * @return
	 */
	public static String getPreSaturday(String yyyyMMdd){
 		
 		int yyyy=Integer.parseInt(yyyyMMdd.substring(0,4));
 		int mm=Integer.parseInt(yyyyMMdd.substring(4,6))-1;
 		int dd=Integer.parseInt(yyyyMMdd.substring(6,8));
 		
 		
 		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		
		cal.set(yyyy, mm, dd);
		cal.add(Calendar.DATE, -7);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);

 		return formatter.format(cal.getTime());

 	}
	
	/**
	 * 입력받은 날짜에 대해서 정합성 체크진행 후 true/false return
	 * 
	 * 
	 *  System.out.println(DateUtil.dateCheck("201801", "yyyyMM"));		--> true
        System.out.println(DateUtil.dateCheck("201821", "yyyyMM"));		--> false
        System.out.println(DateUtil.dateCheck("20180101", "yyyyMMdd")); --> true
        System.out.println(DateUtil.dateCheck("20182101", "yyyyMMdd")); --> false
        System.out.println(DateUtil.dateCheck("20180151", "yyyyMMdd")); --> false
        System.out.println(DateUtil.dateCheck("aaaaaa", "yyyyMMdd"));   --> false
        
	 * @param date
	 * @param format
	 * @return
	 */
	public static boolean dateCheck(String date, String format) {
        SimpleDateFormat dateFormatParser = new SimpleDateFormat(format, Locale.KOREA);
        dateFormatParser.setLenient(false);
        try {
            dateFormatParser.parse(date);
            return true;
        } catch (Exception Ex) {
            return false;
        }
    }





}
