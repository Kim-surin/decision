package com.kpmg.kdb.web.origindeterminationexecution.dto;

import java.math.BigDecimal;

/**
 * {@link com.kpmg.kdb.web.origindeterminationexecution.ItemPriceService#resolveItemPriceWithNote} 결과. FC10_GET_ITEM_PRICE
 * 조회 과정에서 가격을 찾은 그 행의 데이터로 근거 텍스트(NOTE)를 함께 만들어, 원래 별도 함수였던
 * FC10_GET_ITEM_PRICE_NOTE 를 위한 추가 조회를 하지 않는다 — {@link com.kpmg.kdb.web.origindeterminationexecution.ItemPriceService}
 * 클래스 주석 참고.
 */
public class ItemPriceWithNote {

	private final BigDecimal price;
	private final String priceNote;

	public ItemPriceWithNote(BigDecimal price, String priceNote) {
		this.price = price;
		this.priceNote = priceNote;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public String getPriceNote() {
		return priceNote;
	}
}
