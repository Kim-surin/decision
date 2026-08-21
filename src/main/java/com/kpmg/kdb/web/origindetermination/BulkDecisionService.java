package com.kpmg.kdb.web.origindetermination;

/**
 * 벌크 판정(내수 개별판정/월판정/수출 개별판정) 서비스 공통 인터페이스. 그룹(또는 대상)마다 {@link
 * OriginDecisionPipeline} 을 새로 만들어 실행하고 결과를 {@link BulkDecisionResult} 로 취합하는 흐름은
 * 세 구현체({@link IndividualBulkDecisionService}, {@link DomesticBulkDecisionService}, {@link
 * ExportBulkDecisionService}) 모두 동일하지만, 입력 형태는 서로 달라(개별판정은 companyCode+원본 행
 * 목록을 묶은 {@link IndividualBulkDecisionRequest}, 월판정은 {@link
 * com.kpmg.kdb.web.origindetermination.dto.VirtualSalesGenerationParams} 필터 1건, 수출은 {@link
 * ExportDecisionTarget} 목록) 제네릭 타입 파라미터로 흡수한다.
 */
public interface BulkDecisionService<T> {

	BulkDecisionResult run(T request);
}
