/* eslint-disable */
/**
 * AUIGrid 에서 사용되는 메세지들을 정의합니다. - 한국어
 * 마지막 추가된 버전 : v3.0.12
 */
var AUIGridMessages = {
    /*
     * 그리드에 출력시킬 데이터가 없는 메세지
     */
    noDataMessage: '出力するデータがありません。',

    /*
     * 그룹핑 패널 메세지
     */
    groupingMessage: 'ここに列をドラッグするとグループ化されます。',

    /*
     * 필터 메뉴 메세지들
     */
    filterNoValueText: '(フィールド値なし)',
    filterCheckAllText: '(全選択)',
    filterClearText: 'フィルターをリセット',
    filterSearchCheckAllText: '(検索 全て選択)',
    filterSearchCheckAddText: '(現在の選択フィルターに累積して適用)',
    filterSearchPlaceholder: '現在の選択フィルターに累積して適用', // 필터 검색 플레이홀더 텍스트
    filterOkText: '確 認',
    filterCancelText: 'キャンセル',
    filterCloseText: '閉じる',

    filterItemMoreMessage: 'Too many items...Search words',
    filterNumberOperatorList: ['等しい(=)', '大きい(>)', '以上(>=)', '小さい(<)', '以下(<=)', '等しくない(!=)'],

    filterExMenuTextLabel: 'テキストユーザーフィルター',
    filterExMenuNumberLabel: '数値ユーザーフィルター',
    filterModalTitle: 'ユーザー定義フィルター',
    filterModalFieldText: 'フィールド名',
    filterModalAndLabel: 'そして',
    filterModalOrLabel: 'または',
    filterExMenuTextList: ['等しい', '等しくない', '_$line', '先頭文字', '最後の文字', '_$line', '含む', '含まない'],
    filterExMenuNumberList: [
        '等しい(=)',
        '等しくない(!=)',
        '_$line',
        'より大きい(>)',
        '以上(>=)',
        'より小さい(<)',
        '以下(<=)',
        '該当範囲',
        '_$line',
        '上位 10',
        '平均を超える',
        '平均未満',
    ],

    /*
     * 천 단위 구분자
     */
    thousandSeparator: ',',

    /*
     * 소수점 구분자
     */
    decimalSeparator: '.',

    /*
     * 그룹핑 썸머리 합계 메세지
     */
    summaryText: '合計',

    /*
     * 행번호 칼럼의 헤더 텍스트
     */
    rowNumHeaderText: 'No.',

    /*
     * 원격(리모트) 리스트 렌더러 검색 텍스트
     */
    remoterPlaceholder: '検索語を入力してください。',

    /*
     * 드랍다운리스트 전체 선택 텍스트
     */
    dropDownCheckAllTxt: '( 全選択 )',

    /*
     * 기본 컨텍스트 메뉴
     */
    contextTexts: [
        '$value だけ表示',
        '$value を削除してすべて表示',
        '$value を削除して表示',
        'すべてのフィルタリングをリセット',
        'カラム固定',
        'カラム固定をリセット',
    ],

    /*
     * 달력
     */
    calendar: {
        titles: ['日', '月', '火', '水', '木', '金', '土'],
        formatYearString: 'yyyy年',
        monthTitleString: 'm月',
        formatMonthString: 'yyyy年 mm月',
        todayText: '今日を選択',
        uncheckDateText: '日付の選択解除',
        firstDay: 0,
    },

    /*
     * date 의 formatString mmm, mmmm
     */
    monthNames: [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
    ],

    /*
     * date 의 formatString ddd, dddd
     */
    dayNames: ['日', '月', '火', '水', '木', '金', '土', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],

    /*
     * date 의 formatString t tt T TT
     */
    meridiems: ['午前', '午後', 'am', 'pm', 'A', 'P', 'AM', 'PM'],

    /*
     * 내보내기 진행 표시
     */
    exportProgress: {
        init: 'エクスポートを初期化中..',
        progress: 'エクスポートを進行中...',
        complete: 'エクスポートがまもなく完了します。',
    },

    /*
     * 행 드래그 시 나타나는 기본 메세지
     */
    dragRowsText: '$value 行',

    /*
     * 체크박스 헤더 텍스트
     */
    checkHeaderText: '',
};
if (typeof window !== 'undefined') window.AUIGridMessages = AUIGridMessages;
