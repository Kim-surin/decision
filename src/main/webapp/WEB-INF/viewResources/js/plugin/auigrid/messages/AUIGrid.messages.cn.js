/* eslint-disable */
/**
 * AUIGrid 에서 사용되는 메세지들을 정의합니다. - 한국어
 * 마지막 추가된 버전 : v3.0.12
 */
var AUIGridMessages = {
    /*
     * 그리드에 출력시킬 데이터가 없는 메세지
     */
    noDataMessage: '没有要打印的数据。',

    /*
     * 그룹핑 패널 메세지
     */
    groupingMessage: '如果将列拖到此处，它将被分组。',

    /*
     * 필터 메뉴 메세지들
     */
    filterNoValueText: '（无字段值）',
    filterCheckAllText: '（全选）',
    filterClearText: '过滤器重置',
    filterSearchCheckAllText: '（选择全部搜索）',
    filterSearchCheckAddText: '（累积应用于当前选择过滤器）',
    filterSearchPlaceholder: '搜索', // 필터 검색 플레이홀더 텍스트
    filterOkText: '查 看',
    filterCancelText: '消 除',
    filterCloseText: '关闭',

    filterItemMoreMessage: 'Too many items...Search words',
    filterNumberOperatorList: ['一样(=)', '大的(>)', '大于或等于(>=)', '小的(<)', '小于或等于(<=)', '不一样(!=)'],

    filterExMenuTextLabel: '文本用户过滤器',
    filterExMenuNumberLabel: '数字用户过滤器',
    filterModalTitle: '自定义过滤器',
    filterModalFieldText: '字段名称',
    filterModalAndLabel: '还是',
    filterModalOrLabel: '或者',
    filterExMenuTextList: ['等价', '不等式', '_$line', '起始信', '结束符', '_$line', '包括', '不包含'],
    filterExMenuNumberList: [
        '等价(=)',
        '不等式(!=)',
        '_$line',
        '大于(>)',
        '大于或等于(>=)',
        '少于(<)',
        '小于或等于(<=)',
        '适用范围',
        '_$line',
        '前 10',
        '高于平均水平',
        '低于平均值',
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
    summaryText: '和',

    /*
     * 행번호 칼럼의 헤더 텍스트
     */
    rowNumHeaderText: 'No.',

    /*
     * 원격(리모트) 리스트 렌더러 검색 텍스트
     */
    remoterPlaceholder: '请输入您的搜索词。',

    /*
     * 드랍다운리스트 전체 선택 텍스트
     */
    dropDownCheckAllTxt: '( 全选 )',

    /*
     * 기본 컨텍스트 메뉴
     */
    contextTexts: ['$value 只查看', '去除 $value  并显示全部', '去除 $value 并查看', '重置所有过滤', '柱架固定', '柱架固定初始化'],

    /*
     * 달력
     */
    calendar: {
        titles: ['星期天', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
        formatYearString: 'yyyy年',
        monthTitleString: 'm月',
        formatMonthString: 'yyyy年 mm月',
        todayText: '选择今天',
        uncheckDateText: '取消选择日期',
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
    dayNames: ['星期天', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],

    /*
     * date 의 formatString t tt T TT
     */
    meridiems: ['上午', '下午', 'am', 'pm', 'A', 'P', 'AM', 'PM'],

    /*
     * 내보내기 진행 표시
     */
    exportProgress: {
        init: '导出初始化中...',
        progress: '导出进行中...',
        complete: '导出即将完成。',
    },

    /*
     * 행 드래그 시 나타나는 기본 메세지
     */
    dragRowsText: '$value 行',

    /*
     * 체크박스 헤더 텍스트
     */
    checkHeaderText: '',

    /* AUI GRID 메세지 공통 텍스트 */
    MSG_GRDTOOLTIPCOPIED: '复制到剪贴板。',
    DROP_DOWN_PASTE_VALIDATION: '您粘贴了下拉菜单中没有的数据。',
    MSG_INVALID_NUMBER_ONLY_PLUS: '只能输入正数。',
    MSG_NOT_NUMBER_VALUE: '仅允许输入数字格式的值。',
    MSG_EXCEEDED_ALLOWED_INT_LENGTH: '存在固定的小数位数。可输入的最大整数为 #{intLength} 位。',
    MSG_EXCEEDED_ALLOWED_TOTAL_LENGTH: '允许输入的数字总位数（包括整数部分和小数部分）最多为16位',
    MSG_EXCEEDED_ALLOWED_LENGTH: '超出了允许的位数.(整数部分最多 #{int_length} 位，小数部分最多 #{dec_length} 位.)',
    MSG_ALLOW_ZERO_TO_HUNDRED: '仅允许输入0到100之间的数字。',
    MSG_INVALID_DATE_RANGE: '只允许输入 #{start_date} 到 #{end_date} 之间的值.',
};
if (typeof window !== 'undefined') window.AUIGridMessages = AUIGridMessages;
