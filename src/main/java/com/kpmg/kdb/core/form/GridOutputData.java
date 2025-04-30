package com.kpmg.kdb.core.form;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kpmg.kdb.util.StringUtil;
import com.kpmg.kdb.schedule.quartz.job.ApplicationConstants;


//import com.isource.dao.mybatis.manager.Page;

/**
 * JQGrid용 공통 컴포넌트.
 * 
 * gridData      - Grid에 뿌려질 데이터 값
 * 
 * totalPages   - 전체 페이지
 * currentPage - 현재 페이지
 * total- 전체 레코드 수
 * 
 * 이 4개의 Parameter는 jqGrid jsonReader에 이미 선언되어 있다.
 * 
 * jsonReader:{
 *                  root:"gridData",
 *                  page: "currentPage",
 *                  total: "totalPages",
 *               records: "total",
 *         repeatitems: false             
 *  },
 * @author Damned.Cat
 *
 */
public class GridOutputData<T> {
	
	static Logger logger = LoggerFactory.getLogger(GridOutputData.class);
	
	protected Map<String, Object> headerData;
	protected List<T> gridData;	
	protected List<T> rows;
	


	protected int page;	
	protected long records;
	protected int total;
	
	
	public GridOutputData() {
		
	}
	
	public GridOutputData(List<T> gridData, int page, int rowCnt, long total ) {
		this.rows = gridData;
		this.gridData = gridData;
		this.page = page;
		this.records = total;
		this.total = this.records == 0 ? 1 : ((int)(this.records-1)/rowCnt+1);
	}
	
	public GridOutputData(List<T> gridData, Map<String, Object> headerData, int page, int rowCnt, long total ) {
		this.rows = gridData;
		this.gridData = gridData;
		this.headerData = headerData;
		this.page = page;
		this.records = total;
		this.total = this.records == 0 ? 1 : ((int)(this.records-1)/rowCnt+1);
	}
	
	public GridOutputData(List<T> gridData, Map<String, Object> param ) {
		
		int listSize = null==gridData ? 0 : gridData.size();
    	logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    	
    	String pageParam = StringUtil.null2String(param.get("page"), "1");
    	String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(ApplicationConstants.EXCEL_MAX_ROWS));
    	int page = Integer.parseInt(pageParam);
    	int rows = Integer.parseInt(rowsParam);
    	int total = 0;
    	
    	if(gridData != null && gridData.size() > 0 ){
    		total = Integer.parseInt(((Map<String, Object>)gridData.get(0)).get("TOTAL_RECORDS").toString());
    	}
    	
		this.rows = gridData;
		this.gridData = gridData;
		this.page = page;
		this.records = total;
		this.total = this.records == 0 ? 1 : ((int)(this.records-1)/rows+1);
	}
	
	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public long getRecords() {
		return records;
	}

	public void setRecords(long records) {
		this.records = records;
	}
	
	public List<T> getGridData() {
		return gridData;
	}

	public void setGridData(List<T> gridData) {
		this.gridData = gridData;
	}	
	
	public Map<String, Object> getHeaderData() {
		return headerData;
	}

	public void setHeaderData(Map<String, Object> headerData) {
		this.headerData = headerData;
	}
	
	public String toString() {
				return "GridData ["
					+ "LIST = " + String.valueOf(gridData)
					+ "HEADER_DATA = " + String.valueOf(headerData)
					+ "]";

	}
}
