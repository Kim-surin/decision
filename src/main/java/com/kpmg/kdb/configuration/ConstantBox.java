package com.kpmg.kdb.configuration;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;


/**
 * Static 변수에 @value 함수를 이용하여 주입하기 위한 Component Class
 * create by DamnCat 
 */
@Component
public class ConstantBox {

	public static String tmpFilePath;
	public static String excludePattern;
	
	public static String productAssetsType;
	public static String partAssetsType;
	
	/**
	 * 파일 업로드 임시파일 저장 path
	 * @param tmpFilePath
	 */
	@Value("${temp.upload.path}")
	public void setTmpFilePath(String tmpFilePath) {
        this.tmpFilePath = tmpFilePath;
    }
	
	/**
	 * XXS Filter 미적용 URL 목록
	 * @param excludePattern
	 */
	@Value("${lucy.xxs.excludePattern}")
	public void setExcludePattern(String excludePattern) {
        this.excludePattern = excludePattern;
    }
	
	
	/**
	 * 자가생산품 자산구분 
	 * @param excludePattern
	 */
	@Value("${biz.product.assets.type}")
	public void setProductAssetsType(String productAssetsType) {
        this.productAssetsType = productAssetsType;
    }
	
	
	/**
	 * 투입원재료 자산구분
	 * @param excludePattern
	 */
	@Value("${biz.part.assets.type}")
	public void setPartAssetsType(String partAssetsType) {
        this.partAssetsType = partAssetsType;
    }
	
	
    
}