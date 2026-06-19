package com.kpmg.kdb.web.poledger;

import java.util.List;

import com.kpmg.kdb.web.poledger.dto.PoLedgerRequestDto;
import com.kpmg.kdb.web.poledger.dto.PoLedgerResponseDto;

public interface PoledgerDao {
	public List<PoLedgerResponseDto> retrievePoledger(PoLedgerRequestDto param);
}