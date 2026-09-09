package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;
import java.util.function.Consumer;

// 배치 조회를 바인드 파라미터 상한 방지를 위해 chunkSize건씩 나눠 처리하는 반복문. 여러 prefetch* 메서드가
// 각자 구현하던 것을 공용화했으며, 청크의 DAO 호출/결과 취합 방식은 호출부마다 달라 그대로 둔다.
final class BatchChunker {

	private BatchChunker() {
	}

	static <T> void forEachChunk(List<T> items, int chunkSize, Consumer<List<T>> chunkHandler) {
		for (int from = 0; from < items.size(); from += chunkSize) {
			chunkHandler.accept(items.subList(from, Math.min(from + chunkSize, items.size())));
		}
	}
}
