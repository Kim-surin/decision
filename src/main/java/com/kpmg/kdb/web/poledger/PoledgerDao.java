package com.kpmg.kdb.web.poledger;

import java.util.List;
import java.util.Map;

public interface PoledgerDao {
    public List retrievPoledger(Map<String, Object> param);
    public List poLedgerDtlList(Map<String, Object> param);
}