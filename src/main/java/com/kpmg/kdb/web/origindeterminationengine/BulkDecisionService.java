package com.kpmg.kdb.web.origindeterminationengine;

/**
 * 벌크 판정(내수 개별판정/월판정/수출 개별판정) 서비스 공통 인터페이스. 그룹(또는 대상)마다
 * {@link OriginDecisionPipeline} 을 새로 만들어 실행하고 결과를 {@link BulkDecisionResult} 로 취합하는
 * 흐름은 동일하지만 구현체마다 입력 타입이 달라 제네릭 파라미터로 흡수한다.
 */
public interface BulkDecisionService<T> {

	BulkDecisionResult run(T request);
}
