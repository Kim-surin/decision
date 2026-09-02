package com.kpmg.kdb.web.document;

import java.util.List;
import java.util.Map;


/**
 * third Party Report Application 구현 Class
 * 
 * @author D.Cat
 */
public interface DocumentDao {
	
	public List retrieveCooIssueDocumentInfo(Map param);
	
	public Map<String, Object> retrieveIssueReport_One(Map<String, Object> param);
	
	public Map<String, Object> retrievePrintDocumentInformation(Map<String, Object> param);
}