/***************************************************************************************************************
 * 
 * 
 * 
 * package.common-2.3.js
 * 
 * @since 2025.02.01
 * @author 망할고양이
 *
 * 시스템 공통 함수 구현 Jquery,Js
 * 
 ***************************************************************************************************************
 *날짜        |  기능명                                 | 변경사항
 ***************************************************************************************************************
 2022.08.23     KpackageOBJ.object.getFormValue        formId를 ""로 입력할경우 ID 값으로만 값을 가져오도록 기능 변경

 ********************************************************************************************/
/***************************************************************************************************************
 * jQgrid Default Css Remove Function
 ***************************************************************************************************************/
var currentLocale = "ko";
function jQgrid_Common_Css() {
    $(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
    $(".ui-jqgrid-view")
        .children()
        .removeClass("ui-widget-header ui-state-default");
    $(".ui-jqgrid-labels, .ui-search-toolbar")
        .children()
        .removeClass("ui-state-default ui-th-column ui-th-ltr");
    $(".ui-jqgrid-pager").removeClass("ui-state-default");
    $(".ui-jqgrid").removeClass("ui-widget-content");

    // add classes
    $(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
    $(".ui-jqgrid-btable").addClass("table table-bordered table-striped");

    $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
    $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus");
    $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil");
    $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o");
    $(".ui-icon.ui-icon-search").removeClass().addClass("fa fa-search");
    $(".ui-icon.ui-icon-refresh").removeClass().addClass("fa fa-refresh");
    $(".ui-icon.ui-icon-disk")
        .removeClass()
        .addClass("fa fa-save")
        .parent(".btn-primary")
        .removeClass("btn-primary")
        .addClass("btn-success");
    $(".ui-icon.ui-icon-cancel")
        .removeClass()
        .addClass("fa fa-times")
        .parent(".btn-primary")
        .removeClass("btn-primary")
        .addClass("btn-danger");

    $(".ui-icon.ui-icon-seek-prev").wrap(
        "<div class='btn btn-sm btn-default'></div>"
    );
    $(".ui-icon.ui-icon-seek-prev").removeClass().addClass("fa fa-backward");

    $(".ui-icon.ui-icon-seek-first").wrap(
        "<div class='btn btn-sm btn-default'></div>"
    );
    $(".ui-icon.ui-icon-seek-first")
        .removeClass()
        .addClass("fa fa-fast-backward");
    $(".ui-icon.ui-icon-seek-next").wrap(
        "<div class='btn btn-sm btn-default'></div>"
    );
    $(".ui-icon.ui-icon-seek-next").removeClass().addClass("fa fa-forward");

    $(".ui-icon.ui-icon-seek-end").wrap(
        "<div class='btn btn-sm btn-default'></div>"
    );
    $(".ui-icon.ui-icon-seek-end").removeClass().addClass("fa fa-fast-forward");
}

var KpackageOBJ = {
    prototype: {
        seperator: "-",
        errorClass: "validatebox-invalid",
        errorElement: "div",
        validation_highlight: function(element) {
            $(element).parent().removeClass("state-success").addClass("state-error");
            $(element).removeClass("valid");
        },
        validation_unhighlight: function(element) {
            $(element).parent().removeClass("state-error").addClass("state-success");
            $(element).addClass("valid");
        },
        topDownPx: -60,
        USER: "사용자 조회",
        MAX_EMAIL_ATTACH_SIZE: 5000000,
        unKnown: false, //우측의 설정모드를 활성화 합니다.
        regexp_notPaging: /^((?!paging).)*$/,
        minusHeight: 250,
        minimumHeight: 150,
        toastGridCell_Height: 33, //최소 사이즈 25
        toastGridHeader_Height: 33, //Header height
        toastGridCss_Setting: {
            selection: {
                background: "#4daaf9",
                border: "#004082",
            },
            scrollbar: {
                background: "#f5f5f5",
                //border: '#5A5D61',
                thumb: "#d9d9d9",
                emptySpace: "#f5f5f5", //emptySpace: '#747D87',
                active: "#c1c1c1",
            },
            row: {
                dummy: {
                    background: "#747D87",
                },

                hover: {
                    background: "#f1f1f1",
                },
            },
            cell: {
                normal: {
                    background: "#fefefe",
                    border: "#D9D9D9", //'#e0e0e0',
                    showVerticalBorder: true,
                },
                header: {
                    //background: '#747D87', //'#e4edff',
                    //border: '#5A5D61', //'#cedce7',
                    background: "#f5f5f5",
                    border: "#d9d9d9",
                    text: "#222",
                    showVerticalBorder: true,
                },
                rowHeader: {
                    //background: '#747D87', //'#e4edff',
                    //border: '#5A5D61', //'#cedce7',
                    background: "#f5f5f5",
                    border: "#d9d9d9",
                    text: "#222",
                    showVerticalBorder: true,
                },
                editable: {
                    background: "#fafdff",
                },
                selectedHeader: {
                    background: "#d8d8d8",
                },
                focused: {
                    border: "#418ed4",
                },
                disabled: {
                    text: "#b0b0b0",
                },
            },
            area: {
                header: {
                    background: "#f5f5f5", // 해더의 컬럼이 없는 부분의 배경 색
                },
            },
        },

        pop_L_Width: $(window).width() - 100,
        pop_L_Height: $(window).height() - 100,
        pop_M_Width: $(window).width() * 0.7,
        pop_M_Height: $(window).height() * 0.7,
        pop_S_Width: $(window).width() * 0.3,
        pop_S_Height: $(window).height() * 0.3,
    },
    pieChart: {
        chartColor01: ["#0091da", "#00338d"],
        chartColor02: ["#00338d", "#0091da"],
        chartColor03: [
            "#00338d",
            "#005eb8",
            "#0091da",
            "#483698",
            "#470a68",
            "#85468d",
            "#00a3a1",
            "#009a44",
            "#43b02a",
            "#eaaa00",
            "#f68d2e",
            "#c2345b",
            "#e36877",
            "#00338d",
            "#0091da",
            "#6d2077",
            "#005eb8",
            "#00a3a1",
            "#eaaa00",
            "#43b02a",
            "#c6007e",
            "#753f19",
            "#9b642e",
            "#9d9375",
            "#e3bc9f",
            "#e36877",
        ],
    },
    chart: {
        create: function(
            p_Type,
            p_CanvasId,
            p_Data,
            p_Title,
            p_Responsive,
            customOption
        ) {
            var l_Responsive = true;

            if (p_Type == undefined) {
                return null;
            }
            if (p_Data == undefined) {
                return null;
            }
            if (p_Title == undefined) {
                return null;
            }

            if (p_Responsive != undefined) {
                l_Responsive = p_Responsive;
            }

            if (customOption == undefined || customOption == null) {
                if ("doughnut" == p_Type) {
                    return new Chart(document.getElementById(p_CanvasId), {
                        type: p_Type,
                        data: p_Data,
                        options: {
                            responsive: l_Responsive,
                            title: {
                                display: true,
                                text: p_Title,
                                fontSize: 15,
                                padding: 20,
                            },

                            legend: {
                                display: false,
                                position: "bottom",
                                reverse: true,
                            },
                            layout: {
                                padding: {
                                    bottom: 10,
                                },
                            },
                        },
                    });
                } else if ("bar" == p_Type) {
                    return new Chart(document.getElementById(p_CanvasId), {
                        type: p_Type,
                        data: p_Data,

                        options: {
                            responsive: l_Responsive,
                            title: {
                                display: true,
                                text: p_Title,
                                fontSize: 15,
                                padding: 20,
                            },
                            layout: {
                                padding: {
                                    top: 0,
                                },
                            },
                            scales: {
                                xAxes: [
                                    {
                                        display: true,
                                        maxBarThickness: 20,
                                    },
                                ],
                                yAxes: [
                                    {
                                        display: true,
                                        position: "left",
                                        scaleLabel: {
                                            display: false,
                                            labelString: "",
                                        },
                                        ticks: {
                                            callback: function(value, index, values) {
                                                return KpackageOBJ.formatter.commas(value);
                                            },
                                        },
                                    },
                                ],
                            },
                            legend: {
                                position: "bottom",
                            },
                        },
                    });
                }
            } else {
                if ("doughnut" == p_Type) {
                    return new Chart(document.getElementById(p_CanvasId), {
                        type: p_Type,
                        data: p_Data,
                        options: {
                            responsive: l_Responsive,
                            title: {
                                display: true,
                                text: p_Title,
                                fontSize: 15,
                                padding: 20,
                            },

                            legend: {
                                display: false,
                                position: "bottom",
                                reverse: true,
                            },
                            layout: {
                                padding: {
                                    bottom: 10,
                                },
                            },
                            tooltips: customOption,
                        },
                    });
                } else if ("bar" == p_Type) {
                    return new Chart(document.getElementById(p_CanvasId), {
                        type: p_Type,
                        data: p_Data,

                        options: {
                            responsive: l_Responsive,
                            title: {
                                display: true,
                                text: p_Title,
                                fontSize: 15,
                                padding: 20,
                            },
                            layout: {
                                padding: {
                                    top: 0,
                                },
                            },
                            scales: {
                                xAxes: [
                                    {
                                        display: true,
                                        maxBarThickness: 20,
                                    },
                                ],
                                yAxes: [
                                    {
                                        display: true,
                                        position: "left",
                                        scaleLabel: {
                                            display: false,
                                            labelString: "",
                                        },
                                        ticks: {
                                            callback: function(value, index, values) {
                                                return KpackageOBJ.formatter.commas(value);
                                            },
                                        },
                                    },
                                ],
                            },
                            legend: {
                                position: "bottom",
                            },
                        },
                    });
                }
            }

            return null;
        },
    },

    perityChart: {

        create(selector, type) {

            $(selector).peity(type);

        }
    },

    /*******************************************************************
     * 게시판 관련 기능 추가 2022.07.05 add By Cheezred
     *******************************************************************/
    board: {
        /************************************************************************************************************************************/
        /**
         * Function Name : KpackageOBJ.board.retrieve(p_TargetListDiv, p_RetrieveUrl, params, p_drawBodyFunc, p_TargetPage)
         *
         * Description   : Table tag에 리스트를 생성할 때 사용합니다. 리스트 body는 직접 그리셔야합니다. 데이터만 가져다 드려요♡
         *
         * Parameters    : p_TargetListDiv      - <String> tbody tag id
         *        p_RetrieveUrl          - <String> 조회시 요청할 URL default 그리드 정보에 있는 URL
         *        p_drawBodyFunc       - <String> body를 그릴때 사요알 function name
         *        p_TargetPage - <Number> 시작 페이지 default 1
         */
        retrieve: function(
            p_TargetListDiv,
            p_RetrieveUrl,
            params,
            p_drawBodyFunc,
            p_TargetPage
        ) {
            if (
                "" == p_TargetListDiv ||
                null == p_TargetListDiv ||
                undefined == p_TargetListDiv
            ) {
                return false;
            }

            if (
                "" == p_drawBodyFunc ||
                null == p_drawBodyFunc ||
                undefined == p_drawBodyFunc
            ) {
                return false;
            } else {
                $("#" + p_TargetListDiv).data("drawBodyFunc", p_drawBodyFunc);
            }

            if (
                "" == params ||
                null == params ||
                undefined == params ||
                {} == params
            ) {
                params = {
                    DUMMY: "DUMMY",
                };
            }

            if (oUtil.isNull(p_RetrieveUrl)) {
                p_RetrieveUrl = $("#" + p_TargetListDiv).data("url");
            } else {
                $("#" + p_TargetListDiv).data("url", p_RetrieveUrl);
            }

            params["rows"] = $("#" + p_TargetListDiv).data("rows");

            if (oUtil.isNull(p_TargetPage)) {
                params["page"] = $("#" + p_TargetListDiv).data("page");
            } else {
                params["page"] = p_TargetPage;
            }
            params["CURR_LOCALE"] = currentLocale;
            $("#" + p_TargetListDiv).data("object-id", p_TargetListDiv);
            $("#" + p_TargetListDiv).data("sp", JSON.stringify(params));

            if (
                "" == p_RetrieveUrl ||
                null == p_RetrieveUrl ||
                undefined == p_RetrieveUrl
            ) {
                return false;
            }

            KpackageOBJ.ajax.doSubmit(p_RetrieveUrl, params, function(arg) {
                // success Handler
                eval(p_drawBodyFunc + "(arg.value.gridData)");
                if ("Y" == $("#" + p_TargetListDiv).data("pagingYn")) {
                    $("." + p_TargetListDiv + "_paging")
                        .eq(0)
                        .paging("destroy");
                    $("." + p_TargetListDiv + "_paging")
                        .eq(0)
                        .paging({
                            current: arg.value.page,
                            max: arg.value.total,
                            onclick: KpackageOBJ.board.movepaging,
                        });
                }
                if ("Y" == $("#" + p_TargetListDiv).data("captionYn")) {
                    if (currentLocale == "en") {
                        $("#" + p_TargetListDiv)
                            .parent()
                            .children("caption:eq(0)")
                            .html(
                                "Result : " + KpackageOBJ.formatter.commas(arg.value.records)
                            );
                    } else {
                        $("#" + p_TargetListDiv)
                            .parent()
                            .children("caption:eq(0)")
                            .html(
                                "총 건수 : " +
                                KpackageOBJ.formatter.commas(arg.value.records) +
                                "건"
                            );
                    }
                }
            });
        }, // End : retrieve
        movepaging: function() {
            var arg = arguments;
            var listObjectId = $($(arg[2])[0].origin).attr("class");
            listObjectId = listObjectId.replace("_paging", "");
            //var c = ($(arg[2].origin).prev()).data();
            listObjectId = listObjectId.replace("page ", "");
            var c = $("#" + listObjectId).data();
            if (c.sp != undefined) {
                var sp = JSON.parse(c.sp);
                KpackageOBJ.board.retrieve(
                    c.objectId,
                    c.url,
                    sp,
                    c.drawBodyFunc,
                    arg[1]
                );
            }
            try {
                event.preventDefault();
                event.stopPropagation();
            } catch (e) {
                return false;
            }
        },
        /**
         * 체크박스가 있는 게시판 목록의 (체크된) 키 값을 Array 형태로 리턴합니다.
         * arguments : TBODY ID
         * return Array [ {index , keyValue} ]
         */
        getCheckedData: function() {
            var arg = arguments;
            var returnArr = [];
            $("#" + arg[0] + " input:checkbox[name='_CHK']").each(function() {
                if ($(this).is(":checked")) {
                    returnArr.push({
                        index: arguments[0],
                        value: $(this.parentElement.parentElement).data("keyvalue"),
                    });
                }
            });
            return returnArr;
        },
        /**
         * 게시판에 목록에 있는 모든 데이터의 키값을 Array 형태로 리턴합니다.
         * arguments : TBODY ID
         * return Array
         */
        getData: function() {
            var arg = arguments;
            var returnArr = [];
            $("#" + arg[0] + " tr").each(function() {
                returnArr.push({
                    index: arguments[0],
                    value: $(this).data("keyvalue"),
                });
            });
            return returnArr;
        },
        /**
         * 게시판에 조회된 게시물의 목록수를 리턴합니다.
         * arguments : TBODY ID
         * return Int
         */
        getLength: function() {
            var arg = arguments;
            return $("#" + arg[0] + " tr").length;
        },
    },
    /************************************************************************************************************************************/
    object: {
        /************************************************************************************************************************************/

        /**
         * 패스워드에 대한 정합성을 체크합니다.
         * --- Rule -------------------
         *  - 비밀번호 8자리 이상
         *  - 숫자 포함
         *  - 영대 문자 포함
         *  - 영소 문자 포함
         *  - 특수문자 포함
         *  - 공백 X
         *  - 같은 문자 4번 반복 X
         *  - 아이디 포함 X
         *  - 한글 X
         * -----------------------------
         * return code
         *  - EMT : INPUT 값 없음
         *  - ERR_A : 비밀번호는 8자 이상이어야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.
         *  - ERR_B : 같은 문자를 4번 이상 사용하실 수 없습니다.
         *  - ERR_C : 비밀번호에 아이디가 포함되었습니다.
         *  - ERR_D : 비밀번호는 공백 없이 입력해주세요.
         *  - ERR_E : 비밀번호에 한글을 사용 할 수 없습니다.
         *  - SUCCESS : 성공
         */
        getCheckPwdRule: function(userId, inputPwd) {
            if (oUtil.isNull(userId)) {
                return "X";
            }
            if (oUtil.isNull(inputPwd)) {
                return "X";
            }

            var reg =
                /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
            var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

            if (false === reg.test(inputPwd)) {
                return "ERR_A";
            } else if (/(\w)\1\1\1/.test(inputPwd)) {
                return "ERR_B";
            } else if (inputPwd.search(userId) > -1) {
                return "ERR_C";
            } else if (inputPwd.search(/\s/) != -1) {
                return "ERR_D";
            } else if (hangulcheck.test(inputPwd)) {
                return "ERR_E";
            } else {
                return "SUCCESS";
            }
        },
        /**
         * Function Name : KpackageOBJ.object.createTextEditor(txtObjectID, p_height, p_placeholder)
         *
         * Description   :
         *
         * Parameters    : txtObjectID      - <String> Text Editor가 될 Object ID
         *                 p_height         - <INT> 에디터 높이
         *                 p_placeholder     - <STRING> 플레이스 홀더 텍스트
         */
        createTextEditor: function(txtObjectID, p_height, p_placeholder) {
            if (
                "" == txtObjectID ||
                null == txtObjectID ||
                txtObjectID == undefined
            ) {
                return false;
            }
            if ("" == p_height || null == p_height || p_height == undefined) {
                p_height = 300;
            }
            if (
                "" == p_placeholder ||
                null == p_placeholder ||
                p_placeholder == undefined
            ) {
                p_placeholder = "please fill in the contents";
            }
            $("#" + txtObjectID).summernote({
                height: p_height, // 에디터 높이
                minHeight: null, // 최소 높이
                maxHeight: null, // 최대 높이
                focus: true, // 에디터 로딩후 포커스를 맞출지 여부
                lang: "ko-KR", // 한글 설정
                placeholder: p_placeholder, //placeholder 설정
                toolbar: [
                    // [groupName, [list of button]]
                    ["style", ["bold", "italic", "underline", "clear"]],
                    ["font", ["strikethrough", "superscript", "subscript"]],
                    ["fontsize", ["fontsize"]],
                    ["color", ["color"]],
                    ["para", ["ul", "ol", "paragraph"]],
                    ["height", ["height"]],
                ],
            });
            $("#" + txtObjectID)
                .next()
                .attr("id", "EDITOR_" + txtObjectID);
        },
        /**
         * Function Name : KpackageOBJ.object.createDropZone(dropZoneObjectID, successFunc, paramSetFunc)
         *
         * Description   : DropZone 파일 업로드 플러그인을 생성합니다.
         *
         * Parameters    : dropZoneObjectID      - <String> DropZone Object가 될 Object
         *                                                  Dropzone Object 생성시 <오브젝트이름>_fail 오브젝트를 생성하여
         *                                                  지원하지 않는 브라우저에 대한 처리를 해야한다.
         *                 successFunc      - <Function Object> 성공시 동작할 함수
         *                 paramSetFunc     - <Function Object> 파일전송시 필요한 파라메터 셋팅
         */
        createDropZone: function(dropZoneObjectID, successFunc, paramSetFunc) {
            var t_Dz_o = null;
            if (
                "" == dropZoneObjectID ||
                null == dropZoneObjectID ||
                dropZoneObjectID == undefined
            ) {
                return false;
            }
            if (
                "" == successFunc ||
                null == successFunc ||
                successFunc == undefined
            ) {
                return false;
            }
            if (
                "" == paramSetFunc ||
                null == paramSetFunc ||
                paramSetFunc == undefined
            ) {
                return false;
            }
            $("#" + dropZoneObjectID).dropzone({
                url: "/file/uploadFiles",
                init: function() {
                    dzObjet = this;
                    t_Dz_o = this;
                    this.on("complete", successFunc);

                    this.on("sending", paramSetFunc);

                    this.on("error", function(file, message) {
                        alert(message);
                        t_Dz_o.removeFile(file);
                        return false;
                    });
                },
                // 지원하지 않는 IE 10 미만일 경우
                fallback: function() {
                    $("#" + dropZoneObjectID).hide();
                    $("#" + dropZoneObjectID + "_fail").show();
                },
                autoProcessQueue: false,
                clickable: true, // 클릭가능여부
                thumbnailHeight: 60, // Upload icon size
                thumbnailWidth: 60, // Upload icon size
                maxFiles: 5, // 업로드 파일수
                maxFilesize: 20, // 최대업로드용량 : 10MB
                parallelUploads: 99, // 동시파일업로드 수(이걸 지정한 수 만큼 여러파일을 한번에 컨트롤러에 넘긴다.)
                addRemoveLinks: true, // 삭제버튼 표시 여부
                dictRemoveFile: "Delete", // 삭제버튼 표시 텍스트
                uploadMultiple: true, // 다중업로드 기능
                paramName: "file",
                //params : KpackageOBJ.data.makePostData("NOTICE_WRITE_FORM")
                params: {
                    DUMMY: "DUMMY",
                },
            });
        },
        /**
         * Function Name : KpackageOBJ.object.drawFileList(targetObjecId, fileMasterSeq)
         *
         * Description   : 게시판 상세 페이지의 파일 다운로드가 가능한 파일 리스트를 작성합니다.
         *
         * Parameters    : targetObjecId      - <String> 파일 리스트가 렌더링 될 부모 오브젝트
         *                 fileMasterSeq      - <String> 파일 마스터 키
         */
        drawFileList: function(
            targetObjecId,
            fileMasterSeq /*, callbackFuncName*/
        ) {
            if (
                "" == targetObjecId ||
                null == targetObjecId ||
                targetObjecId == undefined
            ) {
                return false;
            }
            if (
                "" == fileMasterSeq ||
                null == fileMasterSeq ||
                fileMasterSeq == undefined
            ) {
                return false;
            }
            var param = {
                FILE_MST_SEQ: fileMasterSeq,
                TARGET_OBJECT_ID: targetObjecId,
            };
            KpackageOBJ.ajax.doSubmit(
                "/common/retrieveFileList",
                param,
                KpackageOBJ.object.drawFileList_CallBack
            );
        },

        drawFileList_CallBack: function(result) {
            if (result.success) {
                var fileList = result.value;
                if (fileList.length > 0) {
                    var targetObjecId = fileList[0]["TARGET_OBJECT_ID"];
                    $("#" + targetObjecId).empty();
                    for (var inx = 0;inx < fileList.length;inx++) {
                        var row = fileList[inx];
                        var fileStr = "";
                        var tmpfileName = row["ORIGIN_FILE_NAME"];
                        tmpfileName = KpackageOBJ.object.getExtension(tmpfileName);
                        tmpfileName = tmpfileName.toLowerCase();
                        fileStr += '<div class="file">';
                        fileStr += '<i class="#fileTypeClass#"></i>';
                        fileStr +=
                            '<a href="/file/downloadAttach/#MST_KEY#/#SUB_KEY#" class="file">#fileName#</a>';
                        fileStr += "</div>";
                        if (tmpfileName.indexOf("doc") > -1) {
                            fileStr = fileStr.replace("#fileTypeClass#", "file_i_word");
                        } else if (tmpfileName.indexOf("xls") > -1) {
                            fileStr = fileStr.replace("#fileTypeClass#", "file_i_excel");
                        } else if (tmpfileName.indexOf("ppt") > -1) {
                            fileStr = fileStr.replace("#fileTypeClass#", "file_i_ppt");
                        } else {
                            fileStr = fileStr.replace("#fileTypeClass#", "file_i_etc");
                        }
                        $("#" + targetObjecId).append(
                            fileStr
                                .replace("#fileName#", row["ORIGIN_FILE_NAME"])
                                .replace("#MST_KEY#", row["FILE_MST_SEQ"])
                                .replace("#SUB_KEY#", row["FILE_SUB_SEQ"])
                        );
                    }
                }

                if (fileList.length == 0) {
                    $("#" + targetObjecId).empty();
                }
            }
        },
        /**
         * Function Name : KpackageOBJ.object.drawModifyFileList(targetObjecId, fileMasterSeq)
         *
         * Description   : 게시판 상세 페이지의 파일 삭제가 가능한 파일 리스트를 작성합니다.
         *
         * Parameters    : targetObjecId      - <String> 파일 리스트가 렌더링 될 부모 오브젝트
         *                 fileMasterSeq      - <String> 파일 마스터 키
         */
        drawModifyFileList: function(
            targetObjecId,
            fileMasterSeq /*, callbackFuncName*/
        ) {
            if (
                "" == targetObjecId ||
                null == targetObjecId ||
                targetObjecId == undefined
            ) {
                return false;
            }

            if (
                "" == fileMasterSeq ||
                null == fileMasterSeq ||
                fileMasterSeq == undefined
            ) {
                return false;
            }

            var param = {
                FILE_MST_SEQ: fileMasterSeq,
                TARGET_OBJECT_ID: targetObjecId,
            };
            KpackageOBJ.ajax.doSubmit(
                "/common/retrieveFileList",
                param,
                KpackageOBJ.object.drawModifyFileList_CallBack
            );
        },
        drawModifyFileList_CallBack: function(result) {
            if (result.success) {
                var fileList = result.value;
                if (fileList.length > 0) {
                    var targetObjecId = fileList[0]["TARGET_OBJECT_ID"];
                    $("#" + targetObjecId).empty();
                    for (var inx = 0;inx < fileList.length;inx++) {
                        var row = fileList[inx];
                        var fileStr = "";
                        var tmpfileName = row["ORIGIN_FILE_NAME"];
                        tmpfileName = KpackageOBJ.object.getExtension(tmpfileName);
                        tmpfileName = tmpfileName.toLowerCase();
                        fileStr += '<div class="file">';
                        fileStr +=
                            '<button type="button" class="btn_i_del" onclick="javascript:KpackageOBJ.object.deleteOneFile(\'' +
                            targetObjecId +
                            "','#mKey#','#sKey#');\">삭제</button>";
                        fileStr += '<i class="#fileTypeClass#"></i>';
                        fileStr +=
                            '<a href="/file/downloadAttach/#MST_KEY#/#SUB_KEY#" class="file">';
                        fileStr += "#fileName#";
                        fileStr += "</a>";
                        fileStr += "</div>";
                        if (tmpfileName.indexOf("doc") > -1) {
                            fileStr = fileStr.replace("#fileTypeClass#", "file_i_word");
                        } else if (tmpfileName.indexOf("xls") > -1) {
                            fileStr = fileStr.replace("#fileTypeClass#", "file_i_excel");
                        } else if (tmpfileName.indexOf("ppt") > -1) {
                            fileStr = fileStr.replace("#fileTypeClass#", "file_i_ppt");
                        } else {
                            fileStr = fileStr.replace("#fileTypeClass#", "file_i_etc");
                        }
                        $("#" + targetObjecId).append(
                            fileStr
                                .replace("#mKey#", row["FILE_MST_SEQ"])
                                .replace("#sKey#", row["FILE_SUB_SEQ"])
                                .replace("#fileName#", row["ORIGIN_FILE_NAME"])
                                .replace("#MST_KEY#", row["FILE_MST_SEQ"])
                                .replace("#SUB_KEY#", row["FILE_SUB_SEQ"])
                        );
                    }
                }

                if (fileList.length == 0) {
                    $("#" + targetObjecId).empty();
                }
            } else {
                $("#" + result.value).empty();
            }
        },
        /**
         * Function Name : KpackageOBJ.object.deleteOneFile(targetDivId, mKey, sKey)
         *
         * Description   : 게시판 상세 페이지의 파일 삭제가 가능한 파일 리스트를 작성합니다.
         *
         * Parameters    : targetObjecId      - <String> 파일 리스트가 렌더링 될 부모 오브젝트
         *                 mKey               - <String> 파일 마스터 키
         *                 sKey               - <String> 파일 서브 키
         */
        deleteOneFile: function(targetDivId, mKey, sKey) {
            if (
                "" == targetDivId ||
                null == targetDivId ||
                targetDivId == undefined ||
                "" == mKey ||
                null == mKey ||
                targetDivId == mKey ||
                "" == sKey ||
                null == sKey ||
                sKey == undefined
            ) {
                return false;
            }

            var text = "해당 파일을 삭제하시겠습니까?";
            if (currentLocale == "en") {
                text = "Are you sure you want to delete the file?";
            }
            if (confirm(text)) {
                var param = {
                    FILE_MST_SEQ: mKey,
                    FILE_SUB_SEQ: sKey,
                    TARGET_OBJECT_ID: targetDivId,
                };
                KpackageOBJ.ajax.doSubmit(
                    "/common/deleteFile",
                    param,
                    KpackageOBJ.object.deleteOneFile_calback
                );
            }
        },

        deleteOneFile_calback: function(result) {
            if (result.success) {
                var paramMap = result.value;
                KpackageOBJ.object.drawModifyFileList(
                    paramMap["TARGET_OBJECT_ID"],
                    paramMap["FILE_MST_SEQ"]
                );
            }
        },

        /************************************************************************************************************************************/
        /************************************************************************************************************************************/
        /************************************************************************************************************************************/
        /** 작은 사이즈의 알림창을 호출합니다. */
        alert: function(confrim_Message) {
            /** bootboxjs.com/examples.html */
            if (
                "" == confrim_Message ||
                null == confrim_Message ||
                confrim_Message == undefined
            ) {
                confrim_Message = "No Message";
            }
            bootbox.alert({
                message: confrim_Message,
                size: "small",
            });
        },
        /** 큰 사이즈의 알림창을 호출합니다.(confirm text가 길 경우 사용하세요) */
        largeAlert: function(confrim_Message) {
            /** bootboxjs.com/examples.html */
            if (
                "" == confrim_Message ||
                null == confrim_Message ||
                confrim_Message == undefined
            ) {
                confrim_Message = "No Message";
            }
            bootbox.alert({
                message: confrim_Message,
            });
        },
        /** 작은 사이즈의 확인창을 호출합니다. */
        confirm: function(confrim_Message, trueFunc) {
            /** bootboxjs.com/examples.html */
            if (
                "" == confrim_Message ||
                null == confrim_Message ||
                confrim_Message == undefined
            ) {
                confrim_Message = "No Message";
            }

            bootbox.confirm({
                message: confrim_Message,
                size: "small",
                buttons: {
                    cancel: {
                        label: '<i class="fa fa-times"></i> Cancel',
                    },
                    confirm: {
                        label: '<i class="fa fa-check"></i> Confirm',
                    },
                },
                callback: function(result) {
                    if (result) {
                        eval(trueFunc(result));
                    }
                },
            });
        },
        /** 큰 사이즈의 확인창을 호출합니다.(confirm text가 길 경우 사용하세요) */
        largeConfirm: function(confrim_Message, trueFunc) {
            /** bootboxjs.com/examples.html */
            if (
                "" == confrim_Message ||
                null == confrim_Message ||
                confrim_Message == undefined
            ) {
                confrim_Message = "No Message";
            }

            bootbox.confirm({
                message: confrim_Message,
                buttons: {
                    cancel: {
                        label: '<i class="fa fa-times"></i> Cancel',
                    },
                    confirm: {
                        label: '<i class="fa fa-check"></i> Confirm',
                    },
                },
                callback: function(result) {
                    if (result) {
                        eval(trueFunc(result));
                    }
                },
            });
        },

        getFormObject: function(ofmId, _i) {
            var obj;
            if (typeof ofmId == "object") {
                return ofmId;
            } else if (typeof ofmId == "string") {
                if (oUtil.isNull(_i)) {
                    obj = $("#" + ofmId);
                } else {
                    obj = $("#" + ofmId + " [name='" + _i + "']");
                }

                return obj;
            }
        },
        setFormValue: function(ofmId, _i, _v) {
            if ("" == ofmId) {
                $("#" + _i).val(_v);
            } else {
                if ($("#" + ofmId + " #" + _i + "").length > 0) {
                    $("#" + ofmId + " #" + _i + "").val(_v);
                } else {
                    $("#" + ofmId + " [name=" + _i + "]").val(_v);
                }
            }
        },

        getFormValue: function(ofmId, _i) {
            var returnValue;
            if ("" == ofmId) {
                if ($("#" + _i + "").length > 0) {
                    returnValue = $("#" + _i + "").val();
                }
            } else {
                if ($("#" + ofmId + " #" + _i + "").length > 0) {
                    returnValue = $("#" + ofmId + " #" + _i + "").val();
                } else {
                    returnValue = $("#" + ofmId + " [name=" + _i + "]").val();
                }

                if (oUtil.isNull(returnValue)) {
                    returnValue = null;
                }
            }

            return returnValue;
        },

        getFormRadioValue: function(ofmId, _i) {
            return $("#" + ofmId + " input:radio[name='" + _i + "']:checked").val();
        },

        readOnly: function(ofmId, objId, flag) {
            if (flag) {
                $("#" + ofmId + " #" + objId + "").attr("readonly", "readonly");
            } else {
                $("#" + ofmId + " #" + objId + "").removeAttr("readonly");
            }
        },
        show: function(ofmId, objId, flag) {
            if ("" == ofmId) {
                if (flag) {
                    $("#" + objId).show();
                } else {
                    $("#" + objId).hide();
                }
            } else {
                if (flag) {
                    $("#" + ofmId + " #" + objId).show();
                } else {
                    $("#" + ofmId + " #" + objId).hide();
                }
            }
        },

        getExtension: function(file_path) {
            var type = "";
            var inx = -1;

            inx = file_path.lastIndexOf(".");

            if (inx != -1) {
                type = file_path.substring(inx + 1, file_path.length);
            } else {
                type = "";
            }

            return type.toUpperCase();
        },

        setCheckBox: function(ofmId, objId, flag) {
            KpackageOBJ.object.getFormObject(ofmId, objId).prop("checked", flag);
        },

        blockUILayer: function(p_TargetDiv, p_WorkFlag) {
            var divTag =
                '<div id="loadingbox_layer' +
                p_TargetDiv +
                '" class="loadingbox_layer"><div class="aniwrap"><span class="pnt01 jump"></span><span class="pnt02 jump"></span><span class="pnt03 jump"></span></div></div>';
            if (p_WorkFlag) {
                $("#" + p_TargetDiv).prepend(divTag);
            } else {
                $("#loadingbox_layer" + p_TargetDiv).remove();
            }
        },
        setCheckBox: function(ofmId, objId, flag) {
            KpackageOBJ.object.getFormObject(ofmId, objId).prop("checked", flag);
        },

        switchFilter: function(obj, arg) {
            if ($("#" + arg + "-HIDDEN-FILTER").is(":visible")) {
                $("#" + arg + "-HIDDEN-FILTER").hide();
                $(obj).children(0).removeClass("fa-arrow-up");
                $(obj).children(0).addClass("fa-arrow-down");
            } else {
                $("#" + arg + "-HIDDEN-FILTER").show();
                $(obj).children(0).removeClass("fa-arrow-down");
                $(obj).children(0).addClass("fa-arrow-up");
            }
        },
    },
    /**
     * 3단위별로 콤마를 찍습니다.
     * 소수점 이하는 콤마를 찍지 않습니다.
     * 마이너스 숫자의 경우도 콤마를 찍습니다.
     */
    formatter: {
        commas: function(x) {
            var rtnVal = "";
            var decPre, decNext, decDot;
            var sapMinus_Yn = false;
            try {
                if (x.toString().indexOf("-") > -1) {
                    rtnVal = x.toString().replace(/-/gi, "").toString();
                    rtnVal = Number(rtnVal);
                    rtnVal = rtnVal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    sapMinus_Yn = true;
                } else {
                    rtnVal = x.toString();
                    rtnVal = Number(rtnVal);
                    rtnVal = rtnVal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                }

                if (rtnVal.indexOf(".") > -1) {
                    decDot = rtnVal.indexOf(".");
                    decPre = rtnVal.substring(0, decDot);
                    decNext = rtnVal.substring(decDot + 1, rtnVal.length);
                    rtnVal = decPre + "." + decNext.replace(/,/gi, "");
                }
                if (sapMinus_Yn) {
                    rtnVal = "-" + rtnVal;
                }
            } catch (e) {
                rtnVal = "";
            }
            return $.trim(rtnVal);
        },
        /** hscode6 hscode10 통합*/
        hscode: function(x) {
            var rtnVal = "";
            if (oUtil.isNull(x)) {
                return x;
            }
            if (x.length == 6) {
                var tmp1, tmp2, tmp3;
                try {
                    tmp1 = x.substring(0, 4);
                    tmp2 = x.substring(4, 6);
                    rtnVal = tmp1 + "." + tmp2;
                } catch (e) {
                    rtnVal = "";
                }
                return $.trim(rtnVal);
            } else if (x.length > 6) {
                var tmp1, tmp2, tmp3;
                try {
                    tmp1 = x.substring(0, 4);
                    tmp2 = x.substring(4, 6);
                    tmp3 = x.substring(6, x.length);
                    rtnVal = tmp1 + "." + tmp2 + "." + tmp3;
                } catch (e) {
                    rtnVal = "";
                }
                return $.trim(rtnVal);
            } else {
                return x;
            }
        },
        hscode10: function(x) {
            var rtnVal = "";

            if (oUtil.isNull(x)) {
                return "";
            }
            if (x.length != 10) {
                return x;
            }

            var tmp1, tmp2, tmp3;
            try {
                tmp1 = x.substring(0, 4);
                tmp2 = x.substring(4, 6);
                tmp3 = x.substring(6, 10);

                rtnVal = tmp1 + "." + tmp2 + "-" + tmp3;
            } catch (e) {
                rtnVal = "";
            }
            return $.trim(rtnVal);
        },
        hscode6: function(x) {
            var rtnVal = "";
            if (x.length != 6) {
                return x;
            }

            var tmp1, tmp2, tmp3;
            try {
                tmp1 = x.substring(0, 4);
                tmp2 = x.substring(4, 6);

                rtnVal = tmp1 + "." + tmp2;
            } catch (e) {
                rtnVal = "";
            }
            return $.trim(rtnVal);
        },
        rawmtrl_se: function(x) {
            var rtnVal = "";
            if (x.length != 2) {
                return x;
            }

            try {
                if (x == "00") {
                    rtnVal = "수입신고필증";
                } else if (x == "02") {
                    rtnVal = "기납증";
                } else if (x == "03") {
                    rtnVal = "평사증";
                } else if (x == "04") {
                    rtnVal = "분증";
                } else if (x == "05") {
                    rtnVal = "부산물";
                }
            } catch (e) {
                rtnVal = "";
            }
            return $.trim(rtnVal);
        },
        month: function() {
            var arg = arguments;
            return arg[0].substring(0, 4) + "-" + arg[0].substring(4, 6);
        },

        date: function() {
            var arg = arguments;
            return KpackageOBJ.date.makeDateFormat(arg[0]);
        },
    },
    selectbox: {
        create: function(
            ofmId,
            objId,
            _url,
            _pd,
            _cp,
            _np,
            data,
            p_width,
            _sel_value_,
            chg_HandlerFnc
        ) {
            var tag = $("#" + ofmId + " #" + objId);
            var panelWidth = null;
            if (oUtil.isNull(p_width) || p_width <= 0) {
                if (!oUtil.isNull(tag.css("width"))) {
                    panelWidth = tag.css("width");
                } else {
                    panelWidth = "auto";
                }
            } else {
                panelWidth = p_width + "px";
            }
            tag.css("width", panelWidth);
            $("#" + ofmId + " #" + objId + " option").remove();

            var params = {};
            var url = "";
            if (!oUtil.isNull(_url)) {
                if (typeof _url == "string") {
                    url = _url;
                    params = {};
                } else {
                    url = _url.href;
                    params = _url.queryParams;
                }
            }
            if (!oUtil.isNull(chg_HandlerFnc)) {
                tag.attr("onChange", "javascript:" + chg_HandlerFnc + "();");
            }
            chageFlag = false;

            if (oUtil.isNull(url)) {
                if (!oUtil.isNull(data) && data.length > 0) {
                    $.each(data, function(i) {
                        var item = data[i];
                        var code = item[_cp];
                        var name = item[_np];
                        var select = "";

                        if (oUtil.isNull(_sel_value_) && i == 0) {
                            select = "selected";
                        }
                        if (!oUtil.isNull(_sel_value_) && code == _sel_value_) {
                            select = "selected";
                        }

                        tag.append(
                            "<option value='" +
                            code +
                            "' " +
                            select +
                            ">" +
                            name +
                            "</option>"
                        );

                        if (i == data.length - 1) {
                            var maxLen = getMaxDataLength(data, _np);
                            if (tag.width() < maxLen) {
                                //tag.css("width",maxLen+10);
                            }

                            if (!oUtil.isNull(chg_HandlerFnc)) {
                                eval(chg_HandlerFnc + '("' + tag.val() + '")');
                            }
                        }
                    });
                }
            } else {
                _pd = JSON.stringify(_pd);
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");

                var doAjax = $.ajax({
                    url: url,
                    data: _pd,
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    cache: false,
                    traditional: true,
                    dataType: "json",
                    async: false,
                    beforeSend: function(xhr) {
                        if (
                            token != "" &&
                            header != "" &&
                            token != undefined &&
                            header != undefined
                        ) {
                            xhr.setRequestHeader(header, token);
                        }
                    },
                });
                doAjax.done(function(data, textStatus) {
                    var array = data.value;
                    var htmlBox = [];
                    $.each(array, function(i) {
                        var item = array[i];
                        var code = item[_cp];
                        var name = item[_np];
                        var select = "";

                        if (oUtil.isNull(_sel_value_) && i == 0) {
                            select = "selected";
                        }
                        if (!oUtil.isNull(_sel_value_) && code == _sel_value_) {
                            select = "selected";
                        }
                        if (oUtil.isNull(code)) {
                            code = "";
                        }

                        tag.append(
                            "<option value='" +
                            code +
                            "' " +
                            select +
                            ">" +
                            name +
                            "</option>"
                        );
                        if (i == array.length - 1) {
                            var maxLen = getMaxDataLength(array, _np);
                            if (tag.width() < maxLen) {
                                //tag.css("width",maxLen+10);
                            }
                            if (!oUtil.isNull(chg_HandlerFnc)) {
                                eval(chg_HandlerFnc + '("' + tag.val() + '")');
                            }
                        }
                    });
                });
            }

            return true;
        },

        setValue: function(ofmId, objId, selectValue) {
            if (!oUtil.isNull(selectValue)) {
                $("#" + ofmId + " #" + objId + "").val(selectValue);
            } else {
                $("#" + ofmId + " #" + objId + "").val(
                    $("#" + ofmId + " #" + objId + " option:first").val()
                );
            }
        },
        readOnly: function(ofmId, objId, flag) {
            var tagCurrObj = $("#" + ofmId + " #" + objId + "");
            if (flag) {
                tagCurrObj.addClass("input_readonly");
            } else {
                tagCurrObj.not(":selected").removeAttr("disabled");
                tagCurrObj.removeClass("input_readonly");
            }
        },

        getText: function(ofmId, objId) {
            return $("#" + ofmId + " #" + objId + " option:selected").text();
        },

        changeItem: function(ofmId, objId, url, param, _cp, _np) {
            var _url = url;

            var params = param;
            var tag = $("#" + ofmId + " #" + objId + "");
            $("#" + ofmId + " #" + objId + " option").remove(); //option초기화
            var oAjax = $.ajax({
                url: _url,
                data: JSON.stringify(params),
                contentType: "application/json; charset=utf-8",
                type: "post",
                async: false,
            });
            oAjax.done(function(data, textStatus, jqXHR) {
                var array = data.value;
                $.each(array, function(i) {
                    var item = array[i];
                    var code = item[_cp];
                    var name = item[_np];
                    var select = "";

                    tag.append("<option value='" + code + "'>" + name + "</option>");
                });
            });
        },
    }, // selectbox End
    
	yearPicker: {
	
	    create: function (objId, startYear, endYear, value) {
	
	        var $input = $("#" + objId);
	
	        if (!$input.length) {
	            return;
	        }
	
	        var currentYear = new Date().getFullYear();
	
	        if (oUtil.isNull(startYear)) {
	            startYear = currentYear - 10;
	        }
	
	        if (oUtil.isNull(endYear)) {
	            endYear = currentYear + 10;
	        }
	
	        /*
	         * value가 넘어온 경우에만 input에 기본값 설정
	         */
	        if (
	            oUtil.isNull($input.val()) &&
	            !oUtil.isNull(value)
	        ) {
	            $input.val(value);
	        }
	
	        $input
	            .attr("readonly", true)
	            .off("click.yearPicker")
	            .on("click.yearPicker", function (event) {
	
	                event.preventDefault();
	                event.stopPropagation();
	
	                var inputElement = this;
	
	                KpackageOBJ.yearPicker.open(
	                    inputElement,
	                    startYear,
	                    endYear,
	                    $(inputElement).val(),
	                    function (year) {
	                        $(inputElement)
	                            .val(year)
	                            .trigger("change");
	                    }
	                );
	            });
	    },
	
	
	    open: function (
	        target,
	        startYear,
	        endYear,
	        selectedValue,
	        callback
	    ) {
	
	        var currentYear = new Date().getFullYear();
	
	        if (oUtil.isNull(startYear)) {
	            startYear = currentYear - 10;
	        }
	
	        if (oUtil.isNull(endYear)) {
	            endYear = currentYear + 10;
	        }
	
	        startYear = Number(startYear);
	        endYear = Number(endYear);
	
	        /*
	         * 선택값은 값이 있는 경우에만 숫자로 변환
	         */
	        if (!oUtil.isNull(selectedValue)) {
	            selectedValue = Number(
	                String(selectedValue).substring(0, 4)
	            );
	        } else {
	            selectedValue = null;
	        }
	
	        /*
	         * 기존에 열려 있는 연도 팝업 제거
	         */
	        $(".custom-year-picker").remove();
	
	        var pickerId =
	            "yearPicker_" +
	            new Date().getTime() +
	            "_" +
	            Math.floor(Math.random() * 1000);
	
	        var $popup = $(
	            '<div id="' + pickerId + '" ' +
	                 'class="custom-year-picker">' +
	
	                '<div class="custom-year-picker-header">' +
	
	                    '<button type="button" ' +
	                            'class="year-prev-btn">' +
	                        '&lt;' +
	                    '</button>' +
	
	                    '<span class="year-range-title"></span>' +
	
	                    '<button type="button" ' +
	                            'class="year-next-btn">' +
	                        '&gt;' +
	                    '</button>' +
	
	                '</div>' +
	
	                '<div class="custom-year-picker-body"></div>' +
	
	            '</div>'
	        );
	
	        /*
	         * CSS에 display:none이 있어도 보이도록 강제 설정
	         */
	        $popup.css({
	            display: "block",
	            position: "absolute",
	            zIndex: 999999
	        });
	
	        $("body").append($popup);
	
	        var pageSize = 12;
	        var columnCount = 4;
	
	        /*
	         * 선택된 값이 있으면 선택값 기준 페이지
	         * 없으면 시작 연도 기준 페이지
	         */
	        var baseYear =
	            selectedValue !== null
	                ? selectedValue
	                : startYear;
	
	        var pageStartYear =
	            Math.floor(baseYear / pageSize) * pageSize;
	
	
	        function renderYears() {
	
	            var $body =
	                $popup.find(".custom-year-picker-body");
	
	            $body.empty();
	
	            $body.css({
	                display: "grid",
	                gridTemplateColumns:
	                    "repeat(" + columnCount + ", 1fr)"
	            });
	
	            $popup
	                .find(".year-range-title")
	                .text(
	                    pageStartYear +
	                    " - " +
	                    (pageStartYear + pageSize - 1)
	                );
	
	            for (
	                var year = pageStartYear;
	                year < pageStartYear + pageSize;
	                year++
	            ) {
	
	                /*
	                 * 반복문 안에서 클릭 연도를 보존하기 위해
	                 * 별도 함수로 생성
	                 */
	                createYearButton(year);
	            }
	        }
	
	
	        function createYearButton(year) {
	
	            var $button = $("<button>", {
	                type: "button",
	                text: year,
	                class: "year-item"
	            });
	
	            if (
	                selectedValue !== null &&
	                selectedValue === year
	            ) {
	                $button.addClass("selected");
	            }
	
	            if (
	                year < startYear ||
	                year > endYear
	            ) {
	                $button.prop("disabled", true);
	            }
	
	            $button.on("click", function (event) {
	
	                event.preventDefault();
	                event.stopPropagation();
	
	                if ($button.prop("disabled")) {
	                    return;
	                }
	
	                if ($.isFunction(callback)) {
	                    callback(year);
	                }
	
	                closePopup();
	            });
	
	            $popup
	                .find(".custom-year-picker-body")
	                .append($button);
	        }
	
	
	        function closePopup() {
	
	            $(document).off(
	                "mousedown." + pickerId
	            );
	
	            $(window).off(
	                "resize." + pickerId +
	                " scroll." + pickerId
	            );
	
	            $popup.remove();
	        }
	
	
	        /*
	         * 좌표 객체로 호출한 경우
	         * AUIGrid에서 사용
	         */
	        if (
	            target &&
	            typeof target === "object" &&
	            target.pageX !== undefined &&
	            target.pageY !== undefined
	        ) {
	
	            $popup.css({
	                left: Number(target.pageX),
	                top: Number(target.pageY) + 5
	            });
	
	        } else {
	
	            /*
	             * 일반 input DOM으로 호출한 경우
	             */
	            var $target = $(target);
	
	            if (!$target.length) {
	                closePopup();
	                return;
	            }
	
	            var offset = $target.offset();
	
	            if (!offset) {
	                closePopup();
	                return;
	            }
	
	            $popup.css({
	                left: offset.left,
	                top:
	                    offset.top +
	                    $target.outerHeight() +
	                    5,
	                minWidth: $target.outerWidth()
	            });
	        }
	
	
	        renderYears();
	
	
	        /*
	         * 팝업 내부 클릭 시 닫히지 않게 처리
	         */
	        $popup.on(
	            "mousedown.yearPicker click.yearPicker",
	            function (event) {
	                event.stopPropagation();
	            }
	        );
	
	
	        $popup
	            .find(".year-prev-btn")
	            .on("click", function (event) {
	
	                event.preventDefault();
	                event.stopPropagation();
	
	                pageStartYear -= pageSize;
	
	                renderYears();
	            });
	
	
	        $popup
	            .find(".year-next-btn")
	            .on("click", function (event) {
	
	                event.preventDefault();
	                event.stopPropagation();
	
	                pageStartYear += pageSize;
	
	                renderYears();
	            });
	
	
	        /*
	         * 팝업을 연 클릭 이벤트가 종료된 다음
	         * 외부 클릭 이벤트 등록
	         */
	        setTimeout(function () {
	
	            $(document).on(
	                "mousedown." + pickerId,
	                function (event) {
	
	                    if (
	                        $(event.target).closest(
	                            "#" + pickerId
	                        ).length
	                    ) {
	                        return;
	                    }
	
	                    closePopup();
	                }
	            );
	
	        }, 0);
	
	
	        /*
	         * 화면이 움직이면 팝업 종료
	         */
	        $(window).on(
	            "resize." + pickerId +
	            " scroll." + pickerId,
	            function () {
	                closePopup();
	            }
	        );
	    },
	
	
	    getValue: function (objId) {
	        return $("#" + objId).val();
	    },
	
	
	    setValue: function (objId, yearValue) {
	
	        /*
	         * 기존 코드의 .val(value)는
	         * value 변수가 선언되지 않아 오류 발생
	         */
	        var $input = $("#" + objId);
	
	        if (!$input.length) {
	            return;
	        }
	
	        if (oUtil.isNull(yearValue)) {
	            $input
	                .val("")
	                .trigger("change");
	
	            return;
	        }
	
	        var year =
	            String(yearValue).substring(0, 4);
	
	        $input
	            .val(year)
	            .trigger("change");
	    },
	
	    close: function () {

		    $(".custom-year-picker").remove();
		
		    $(document).off(".yearPickerPopup");
		    $(window).off(".yearPickerPopup");
		},
	
	    disable: function (objId, disabled) {
	
	        if (oUtil.isNull(disabled)) {
	            disabled = true;
	        }
	
	        var $input =
	            $("#" + objId);
	
	        $input.prop("disabled", disabled);
	
	        if (disabled) {
	            $(".custom-year-picker").remove();
	        }
	    },
	
	
	    destroy: function (objId) {
	
	        var $input =
	            $("#" + objId);
	
	        $input.off(".yearPicker");
	
	        $(".custom-year-picker").remove();
	    },
	
	
	    _getPageStartYear: function (
	        year,
	        pageSize
	    ) {
	        return Math.floor(year / pageSize) * pageSize;
	    }
	},

    monthPicker: {
        create: function(ofmId, objId, startYear) {
            if (oUtil.isNull(startYear)) {
                startYear = KpackageOBJ.date.getCurrYear();
            }
            $("#" + ofmId + " #" + objId).MonthPicker({
                StartYear: startYear,
                Button:
                    '<img src="/rcs/img/cal_btn_001.png" style="margin-left: -30px;vertical-align: text-bottom;"/>',
                MonthFormat: "yy-mm",
                UseInputMask: true,
            });
        },

        getValue: function(ofmId, _i) {
            var rtnVal = KpackageOBJ.object.getFormValuen(ofmId, _i);
            return rtnVal.replace(/-/gi, "");
        },

        setValue: function(ofmId, objId, dateValue) {
            var tagCurrObj = $("#" + ofmId + " #" + objId + "");
            var y = dateValue.substring(0, 4);
            var m = dateValue.substring(4, 6);
            tagCurrObj.val(y + KpackageOBJ["prototype"]["seperator"] + m);
        },

        disable: function(ofmId, _i, _bl) {
            if (oUtil.isNull(_bl)) {
                _bl = true;
            }
            $("#" + ofmId + " #" + _i).MonthPicker("option", "Disabled", _bl);
        },
    },
    calendar: {
        create: function(ofmId, objId, seperator, func, editable) {
            var tagCurrObj = $(document).find(
                "#" + ofmId + " input[name=" + objId + "]"
            );
            if (oUtil.isNull(seperator)) {
                KpackageOBJ["prototype"]["seperator"] = "-";
            } else {
                KpackageOBJ["prototype"]["seperator"] = seperator;
            }
            if (oUtil.isNull(editable)) editable = true;

            $.datepicker.regional["ko"] = {
                closeText: "닫기",
                prevText: '<i class="fa fa-chevron-left"></i>',
                nextText: '<i class="fa fa-chevron-right"></i>',
                currentText: "오늘",
                //monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
                monthNamesShort: [
                    "01",
                    "02",
                    "03",
                    "04",
                    "05",
                    "06",
                    "07",
                    "08",
                    "09",
                    "10",
                    "11",
                    "12",
                ],
                //dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                weekHeader: "Wk",
                firstDay: 0,
                isRTL: false,
                showMonthAfterYear: true,
                changeMonth: true,
                changeYear: true,
            };

            tagCurrObj
                .datepicker({
                    dateFormat: "yy-mm-dd",
                    buttonImage: "/rcs/img/cal_btn_001.png",
                    buttonImageOnly: true,
                    buttonText: "달력",
                    showOn: "both",
                    beforeShow: function(el) {
                        setTimeout(function() {
                            $(".ui-datepicker").css("z-index", 999);
                        }, 0);
                    },
                    onSelect: function(dateText, inst) {
                        var date = KpackageOBJ.calendar.getDateValue(dateText);
                        var year = date.getFullYear();
                        var month = date.getMonth() + 1;
                        var day = date.getDate();
                        if (month < 10) month = "0" + month;
                        if (day < 10) day = "0" + day;
                        $(document)
                            .find("input[name=" + objId + "]")
                            .val(
                                year +
                                KpackageOBJ["prototype"]["seperator"] +
                                month +
                                KpackageOBJ["prototype"]["seperator"] +
                                day
                            );
                        if (objId != objId.replace("_CALENDAR", "").replace("CAL_", "")) {
                            $(document)
                                .find(
                                    "input[name=" +
                                    objId.replace("_CALENDAR", "").replace("CAL_", "") +
                                    "]"
                                )
                                .val(year + "" + month + "" + day);
                        }

                        if (!oUtil.isNull(func)) {
                            new Function(func + "()")();
                        }
                    },
                    formatter: function(date) {
                        var y = date.getFullYear();
                        var m = date.getMonth() + 1;
                        var d = date.getDate();
                        return (
                            y +
                            KpackageOBJ["prototype"]["seperator"] +
                            (m < 10 ? "0" + m : m) +
                            KpackageOBJ["prototype"]["seperator"] +
                            (d < 10 ? "0" + d : d)
                        );
                    },
                })
                .inputmask("yyyy-mm-dd")
                .on("change", function() {
                    if ($(this).val() != "") {
                        var date = KpackageOBJ.calendar.getDateValue($(this).val());
                        var year = date.getFullYear();
                        var month = date.getMonth() + 1;
                        var day = date.getDate();
                        if (month < 10) month = "0" + month;
                        if (day < 10) day = "0" + day;
                        $(document)
                            .find("input[name=" + objId + "]")
                            .val(
                                year +
                                KpackageOBJ["prototype"]["seperator"] +
                                month +
                                KpackageOBJ["prototype"]["seperator"] +
                                day
                            );
                        if (objId != objId.replace("_CALENDAR", "").replace("CAL_", "")) {
                            $(document)
                                .find(
                                    "input[name=" +
                                    objId.replace("_CALENDAR", "").replace("CAL_", "") +
                                    "]"
                                )
                                .val(year + "" + month + "" + day);
                        }
                    } else {
                        $(document)
                            .find("input[name=" + objId + "]")
                            .val("");
                        if (objId != objId.replace("_CALENDAR", "").replace("CAL_", "")) {
                            $(document)
                                .find(
                                    "input[name=" +
                                    objId.replace("_CALENDAR", "").replace("CAL_", "") +
                                    "]"
                                )
                                .val("");
                        }
                    }

                    if (!oUtil.isNull(func)) {
                        new Function(func + "()")();
                    }
                });

            $(".datePicker").keypress(function(event) {
                event.preventDefault();
            });
            $.datepicker.setDefaults($.datepicker.regional["ko"]);
            $("img.ui-datepicker-trigger").css({
                cursor: "pointer",
                "margin-left": "-30px",
            }); //아이콘(icon) 위치
            $("img.ui-datepicker-trigger").attr("align", "absmiddle");
            if (
                $("#" + ofmId)
                    .attr("class")
                    .indexOf("form-dialog") > -1
            ) {
                $("img.ui-datepicker-trigger").css({ "margin-top": "8px" }); //dialog 아이콘(icon) 위치
            }
        },

        getDateValue: function(dateString) {
            var year = dateString.substr(0, 4);
            var month = parseInt(dateString.substr(5, 2));
            if (month == 0) {
                month = dateString.substr(5, 2).replace("0", "");
            }
            month = (parseInt(month) - 1).toString();
            var day = dateString.substr(8, 2);
            return new Date(year, month, day);
        },

        setValue: function(ofmId, objId, dateValue) {
            var tagCurrObj = $("#" + ofmId + " #" + objId + "");
            var y = dateValue.substring(0, 4);
            var m = dateValue.substring(4, 6);
            var d = dateValue.substring(6, 8);
            tagCurrObj.datepicker(
                "setDate",
                y +
                KpackageOBJ["prototype"]["seperator"] +
                m +
                KpackageOBJ["prototype"]["seperator"] +
                d
            );
        },

        setFormValue: function(ofmId, objId, value) {
            var y = value.substring(0, 4);
            var m = value.substring(4, 6);
            var d = value.substring(6, 8);

            var dateValue =
                y +
                KpackageOBJ["prototype"]["seperator"] +
                m +
                KpackageOBJ["prototype"]["seperator"] +
                d;

            if ($("#" + ofmId + " #" + objId + "").length > 0) {
                $("#" + ofmId + " #" + objId + "").val(dateValue);
            } else {
                $("#" + ofmId + " [name=" + objId + "]").val(dateValue);
            }
        },

        getValue: function(ofmId, objId) {
            var tagCurrObj = $("#" + ofmId + " #" + objId + "").val();
            return replaceAll(tagCurrObj, KpackageOBJ["prototype"]["seperator"], "");
        },

        disabled: function(ofmId, objId, flag) {
            var tagCurrObj = $("#" + ofmId + " #" + objId + "");
            if (oUtil.isNull(flag)) {
                flag = false;
            }
            if (flag) {
                tagCurrObj.datepicker("option", "disabled", true);
                tagCurrObj.next("img").css("cursor", "pointer");
                tagCurrObj.next("img").css("margin-left", "-30px");
            } else {
                tagCurrObj.datepicker("option", "disabled", false);
            }
        },
    }, // calendar End

    data: {
        makePostData: function(ofmId) {
            return $("#" + ofmId).serializeObject();
        },
        /**
         * GCIM System 전용 클릭한 검색 기능 표시
         */
        patinSearchCondition: function(ofmId) {
            if (
                oUtil.isNull(KpackageOBJ.object.getFormValue(ofmId, "SCH_TYPE")) ||
                oUtil.isNull(ofmId)
            ) {
                return;
            }
            if ("TypeA" == KpackageOBJ.object.getFormValue(ofmId, "SCH_TYPE")) {
                $(".sehwrap .condition").addClass("searchType");
                $(".sehwrap .period").removeClass("searchType");
            } else if (
                "TypeB" == KpackageOBJ.object.getFormValue(ofmId, "SCH_TYPE")
            ) {
                $(".sehwrap .condition").removeClass("searchType");
                $(".sehwrap .period").addClass("searchType");
            }
        },
        /**
         * GCIM System 전용 검색조건 파라메터 생성 함수
         */
        makeGcimPostData: function(ofmId) {
            var gpData = $("#" + ofmId).serializeObject();
            var sch_month = gpData["SCH_MONTH"];
            if ("string" == typeof sch_month) {
                var monthArr = [];
                monthArr.push(sch_month);
                gpData["SCH_MONTH"] = monthArr;
            }

            KpackageOBJ.data.patinSearchCondition(ofmId);
            return gpData;
        },
        /**
         * GCIM System 년도 선택이 다중건인 검색조건에 사용되는 검색조건 파라메터 생성 함수
         */
        makeGcimMultiYearPostData: function(ofmId) {
            var gpData = $("#" + ofmId).serializeObject();
            var sch_month = gpData["SCH_MONTH"];
            if ("string" == typeof sch_month) {
                var monthArr = [];
                monthArr.push(sch_month);
                gpData["SCH_MONTH"] = monthArr;
            }
            var sch_year = gpData["SCH_YEAR"];
            if ("string" == typeof sch_year) {
                var yearArr = [];
                yearArr.push(sch_year);
                gpData["SCH_YEAR"] = yearArr;
            }
            KpackageOBJ.data.patinSearchCondition(ofmId);

            return gpData;
        },

		setFormData: function(ofmId, jsondata) {
		    if (!oUtil.isNull(ofmId)) {
		        for (var property in jsondata) {
		            var value = jsondata[property];
		            var objId = property.toString();
		            var $target = $("#" + ofmId + " [name=" + objId + "]");

		            // 라디오 박스 체크
		            if ($("#" + ofmId + " input[name=" + objId + "]:radio").length > 0) {
		                $("#" + ofmId + " input[name=" + objId + "]:radio:input[value=" + value + "]").attr("checked", true);
		            }
		            // date / month 타입 처리
		            else if ($target.length > 0 && ($target.attr("type") === "date" || $target.attr("type") === "month")) {
		                var inputType = $target.attr("type");
		                var formattedValue = "";

		                if (!oUtil.isNull(value)) {
		                    var strValue = String(value).trim();

		                    if (inputType === "date") {
		                        // 20260601 -> 2026-06-01
		                        if (/^\d{8}$/.test(strValue)) {
		                            formattedValue = strValue.substring(0, 4) + "-" + strValue.substring(4, 6) + "-" + strValue.substring(6, 8);
		                        }
		                        // 2026-06-01, 2026-06-01 10:20:30, 2026-06-01T10:20:30
		                        else if (/^\d{4}-\d{2}-\d{2}/.test(strValue)) {
		                            formattedValue = strValue.substring(0, 10);
		                        }
		                    } else if (inputType === "month") {
		                        // 202606 -> 2026-06
		                        if (/^\d{6}$/.test(strValue)) {
		                            formattedValue = strValue.substring(0, 4) + "-" + strValue.substring(4, 6);
		                        }
		                        // 2026-06, 2026-06-01, 2026-06-01 10:20:30
		                        else if (/^\d{4}-\d{2}/.test(strValue)) {
		                            formattedValue = strValue.substring(0, 7);
		                        }
		                    }
		                }

		                $target.val(formattedValue);
		            }
		            // 일반 input/select/textarea 처리
		            else {
		                $target.val(value);
		            }
		        }
		    }
		},
        makeGetData: function(ofmId) {
            var returnParam = "";
            var getFormData = $("#" + ofmId).serializeArray();
            $.each(getFormData, function(key, data) {
                returnParam += data.name + "=" + data.value + "&";
            });
            return returnParam.substring(0, returnParam.length - 1);
        },
        object2parameter: function(params) {
            return Object.keys(params)
                .map(function(key) {
                    return (
                        encodeURIComponent(key) + "=" + encodeURIComponent(params[key])
                    );
                })
                .join("&");
        },
    }, // data End
    validation: function(ofmId) {
        var obj = $("#" + ofmId + "");

        $.validator.addMethod(
            "month",
            function(value, element) {
                return this.optional(element) || /^[\d]{4}(0[1-9]|1[0-2])$/.test(value);
            },
            "달력(월) 양식에 맞지 않습니다."
        );

        $.validator.setDefaults({
            errorClass: "validatebox-invalid",
            messageClass: "isc-valid-tooltip",
            errorElement: "b",
            meta: "validate",
        });

        $.extend(jQuery.validator.messages, {
            required: "필수입력 항목 입니다.", //required:true
            email: "이메일을 입력하세요", //email:true
            url: "Please enter a valid URL.", //url:true
            date: "달력(날짜)형식에 맞지 않습니다.", //date:true
            number: "숫자 형식에 맞지 않습니다.", //number:true Integer로 되어있는거는 number로 사용
            digits: "Please enter only digits.", //digits:true
            equalTo: $.validator.format("{1} 의 값과 입력한 값이 일치하지 않습니다."), //equalTo:['#PASSWORD',PWD] 기준이 되는 필드ID, 제목
            maxlength: $.validator.format("최대 {0}자까지 입력하실수 있습니다. "), //maxlength:10
            minlength: $.validator.format("최소 {0}자 이상 입력해주세요."), //minlength:10
            rangelength: $.validator.format(
                "최소 {0}자이상 최대{1}자 이하까지만 입력가능합니다."
            ), //rangelength:[1,10]
            max: $.validator.format(
                "Please enter a value less than or equal to {0}."
            ), //max:1
            min: $.validator.format(
                "Please enter a value greater than or equal to {0}."
            ), //min:1
            step: $.validator.format("Please enter a multiple of {0}."), //step:1
        });
        return obj.valid();
    },
    ajax: {
        doSubmit: function(
            requrl,
            _pd,
            successHandler,
            errorHandler,
            useProgress,
            p_async = true
        ) {
            if (useProgress == undefined) {
                useProgress = true;
            }
            _pd["CURR_LOCALE"] = currentLocale;
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");

            $.ajax({
                url: requrl,
                type: "POST",
                cache: false,
                data: JSON.stringify(_pd),
                contentType: "application/json; charset=utf-8",
                traditional: true,
                async: p_async,
                dataType: "json",
                beforeSend: function(xhr) {
                    if (useProgress) {
                        load_BlockUI2(true);
                    }
                    if (
                        token != "" &&
                        header != "" &&
                        token != undefined &&
                        header != undefined
                    ) {
                        xhr.setRequestHeader(header, token);
                    }
                },
                success: function(result) {
					if (useProgress) {
					    load_BlockUI2(false);
					}

					if (typeof successHandler === "function") {
					    successHandler(result);

					} else if (typeof successHandler === "string") {
					    var successHandlerFunction = window[successHandler];

					    if (typeof successHandlerFunction === "function") {
					        successHandlerFunction(result);
					    } else {
					        console.warn("successHandler 함수가 존재하지 않습니다:", successHandler);
					    }
					}
                },
                error: function(result, a, b, c, d) {
                    //load_BlockUI2(false);
                    if (useProgress) {
                        load_BlockUI2(false);
                    }
                    if ("error" == a && "Forbidden" == b) {
                        alert("사용자 정보가 불일치하여 로그인화면으로 돌아갑니다.");
                        $(location).attr("href", "/loginform");
                    } else if (result.responseText.indexOf("oLoginPage") > 0) {
                        // 세션이 상실되어 로그인 페이지에 대한 html을 리턴 받을 경우
                        alert("사용자 정보가 불일치하여 로그인화면으로 돌아갑니다.");
                        $(location).attr("href", "/loginform");
                    } else {
                        alert("서버와 통신 중 오류가 발생하였습니다.");
                    }
                },
            });
        },
        doFormSubmit: function(ofmId, urlParam, successHandler) {
            var frm = $("#" + ofmId);
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");

            frm.ajaxSubmit({
                url: urlParam,
                dataType: "json",
                type: "post",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                beforeSubmit: function(formData, jqForm, options) {
                    if (
                        token != "" &&
                        header != "" &&
                        token != undefined &&
                        header != undefined
                    ) {
                        options.headers = {
                            header: token,
                        };
                    }

                    //load_BlockUI2(true);
                    load_BlockUI2(true);
                },
                success: function(result, status) {
                    //load_BlockUI2(false);
                    load_BlockUI2(false);

                    if (typeof successHandler == "function") {
                        successHandler(result);
                    } else if (typeof successHandler == "string") {
                        var successHandlerFunction = eval(successHandler);
                        successHandlerFunction(result);
                    }
                },
                error: function(result) {
                    //load_BlockUI2(false);
                    load_BlockUI2(false);
                    alert("서버와 통신 중 오류가 발생하였습니다.");
                },
            });
        },
        doFileDownload: function(formId, url, data, method) {
            if (oUtil.isNull(method)) {
                method = "post";
            }

            // url과 data를 입력받음
            if (url && data) {
                data = data + "&" + KpackageOBJ.data.makeGetData(formId);
                // data 는  string 또는 array/object 를 파라미터로 받는다.
                data = typeof data == "string" ? data : jQuery.param(data);
                // 파라미터를 form의  input으로 만든다.
                var inputs = "";
                var array = [];
                var token = $("meta[name='_csrf']").attr("content");
                jQuery.each(data.split("&"), function() {
                    var pair = this.split("=");
                    if (!oUtil.isNull(pair[0]) && !oUtil.isNull(pair[1])) {
                        if (array.indexOf(pair[0]) == -1) {
                            array.push(pair[0]);
                            if (!oUtil.isNull(pair[1]) && pair[1].substring(0, 1) == "'") {
                                inputs +=
                                    '<input type="hidden" name="' +
                                    pair[0] +
                                    '" value="' +
                                    pair[1].replace(/%2C/g, ",") +
                                    '" />';
                            } else {
                                inputs +=
                                    '<input type="hidden" name="' +
                                    pair[0] +
                                    "\" value='" +
                                    pair[1].replace(/%2C/g, ",") +
                                    "' />";
                            }
                        }
                    }
                });
                inputs += '<input type="hidden" name="_csrf" value="' + token + '">';
                // request를 보낸다.
                jQuery(
                    '<form id="' +
                    formId +
                    '" action="' +
                    url +
                    '" method="' +
                    (method || "post") +
                    '">' +
                    inputs +
                    "</form>"
                )
                    .appendTo("body")
                    .submit()
                    .remove();
            }
        },
    }, // ajax End
    date: {
        getCurrDay: function(pDelimiter) {
            if (pDelimiter == undefined || pDelimiter == null) {
                pDelimiter = "";
            }
            var today = new Date();
            var yyyy, mm, dd;

            yyyy = today.getFullYear();
            mm = today.getMonth() + 1;
            dd = today.getDate();
            mm = mm < 10 ? "0" + mm : mm;
            dd = dd < 10 ? "0" + dd : dd;

            return yyyy + pDelimiter + mm + pDelimiter + dd;
        },
        getCurrMonth: function(pDelimiter) {
            if (pDelimiter == undefined || pDelimiter == null) {
                pDelimiter = "";
            }
            var today = new Date();
            var yyyy, mm;

            yyyy = today.getFullYear();
            mm = today.getMonth() + 1;
            mm = mm < 10 ? "0" + mm : mm;

            return yyyy + pDelimiter + mm;
        },
        getCurrYear: function() {
            var today = new Date();
            var yyyy;

            yyyy = today.getFullYear();

            return yyyy;
        },
        addDate: function(pInterval, pAddVal, pYyyymmdd, pDelimiter) {
            var cDate;
            var yyyy, mm, dd;
            var cYear, cMonth, cDay;
            var rtnValue;

            if (pDelimiter != "") {
                pYyyymmdd = pYyyymmdd.replace(eval("/\\" + pDelimiter + "/g"), "");
            }
            yyyy = pYyyymmdd.substr(0, 4);
            mm = pYyyymmdd.substr(4, 2);
            dd = pYyyymmdd.substr(6, 2);
            if (pInterval == "yyyy") {
                yyyy = yyyy * 1 + pAddVal * 1;
            } else if (pInterval == "m") {
                mm = mm * 1 + pAddVal * 1;
            } else if (pInterval == "d") {
                dd = dd * 1 + pAddVal * 1;
            }
            cDate = new Date(yyyy, mm - 1, dd);
            cYear = cDate.getFullYear();
            cMonth = cDate.getMonth() + 1;
            cDay = cDate.getDate();
            cMonth = cMonth < 10 ? "0" + cMonth : cMonth;
            cDay = cDay < 10 ? "0" + cDay : cDay;
            if (pDelimiter != "") {
                rtnValue =
                    cYear.toString() +
                    pDelimiter.toString() +
                    cMonth.toString() +
                    pDelimiter.toString() +
                    cDay.toString();
            } else {
                rtnValue = cYear.toString() + cMonth.toString() + cDay.toString();
            }

            return rtnValue;
        },

        lastDay: function(pYyyymm) {
            var yyyy, mm, cDate, lastDay;

            yyyy = pYyyymm.substr(0, 4);
            mm = pYyyymm.substr(4, 2);
            lastDay = new Date(new Date(yyyy, mm, 1) - 1).getDate();

            return lastDay;
        },

        getDiffDay: function(pStartYyyymmdd, pEndYyyymmdd, pDelimiter) {
            var yyyyS, mmS, ddS, yyyyE, mmE, ddE;
            if (pDelimiter != "") {
                pStartYyyymmdd = pStartYyyymmdd.replace(
                    eval("/\\" + pDelimiter + "/g"),
                    ""
                );
                pEndYyyymmdd = pEndYyyymmdd.replace(
                    eval("/\\" + pDelimiter + "/g"),
                    ""
                );
            }
            yyyyS = pStartYyyymmdd.substr(0, 4);
            mmS = pStartYyyymmdd.substr(4, 2);
            ddS = pStartYyyymmdd.substr(6, 2);

            yyyyE = pEndYyyymmdd.substr(0, 4);
            mmE = pEndYyyymmdd.substr(4, 2);
            ddE = pEndYyyymmdd.substr(6, 2);

            var startDay = new Date(
                parseInt(yyyyS),
                parseInt(mmS) - 1,
                parseInt(ddS)
            );
            var endDay = new Date(parseInt(yyyyE), parseInt(mmE) - 1, parseInt(ddE));

            var diffTime = endDay.getTime() - startDay.getTime();
            return Math.floor(diffTime / (1000 * 60 * 60 * 24));
        },
        getDiffMonth: function(pStartYyyymmdd, pEndYyyymmdd, pDelimiter) {
            var yyyyS, mmS, ddS, yyyyE, mmE, ddE;
            if (pDelimiter != "") {
                pStartYyyymmdd = pStartYyyymmdd.replace(
                    eval("/\\" + pDelimiter + "/g"),
                    ""
                );
                pEndYyyymmdd = pEndYyyymmdd.replace(
                    eval("/\\" + pDelimiter + "/g"),
                    ""
                );
            }
            yyyyS = pStartYyyymmdd.substr(0, 4);
            mmS = pStartYyyymmdd.substr(4, 2);
            ddS = pStartYyyymmdd.substr(6, 2);

            yyyyE = pEndYyyymmdd.substr(0, 4);
            mmE = pEndYyyymmdd.substr(4, 2);
            ddE = pEndYyyymmdd.substr(6, 2);
            var startDay = new Date(
                parseInt(yyyyS),
                parseInt(mmS) - 1,
                parseInt(ddS)
            );
            var endDay = new Date(parseInt(yyyyE), parseInt(mmE) - 1, parseInt(ddE));
            var diffTime = endDay.getTime() - startDay.getTime();
            return diffTime / (1000 * 60 * 60 * 24 * 30);
        },
        f_sys_between_ymd: function(c_sta_ymd, c_end_ymd, c_gubun, c_sta_yn) {
            var v_sta_ymd, v_end_ymd;
            var v_yy, v_mm, v_dd;
            var v_yy_t, v_mm_t, v_mm_mod, v_dd_t, v_dd_y_mod, v_mdd_m_mod;
            var v_yy_pos, v_mm_pos, v_dd_pos;
            var day_value = 24 * 60 * 60 * 1000;
            var v_ret = c_gubun;
            if (c_sta_ymd == "" || c_end_ymd == "") {
                return "";
            }
            v_sta_ymd = this.makeDateFormat(c_sta_ymd);
            v_end_ymd = this.makeDateFormat(c_end_ymd);
            if (v_sta_ymd == "") return "";
            if (v_end_ymd == "") return "";
            if (c_sta_yn.toUpperCase() == "Y") {
                v_sta_ymd = new Date(
                    v_sta_ymd.getYear(),
                    v_sta_ymd.getMonth(),
                    v_sta_ymd.getDate() - 1
                );
            }
            v_yy_t = parseInt(this.months_between(c_end_ymd, c_sta_ymd) / 12);
            v_mm_t = parseInt(this.months_between(c_end_ymd, c_sta_ymd));
            v_mm_mod = parseInt(this.months_between(c_end_ymd, c_sta_ymd)) % 12;
            v_dd_t = parseInt((v_end_ymd - v_sta_ymd) / day_value);
            v_dd_y_mod = parseInt(
                (v_end_ymd - this.add_months(c_sta_ymd, v_yy_t * 12)) / day_value
            );
            v_dd_m_mod = parseInt(
                (v_end_ymd - this.add_months(c_sta_ymd, v_yy_t * 12 + v_mm_mod)) /
                day_value
            );
            v_yy_pos = c_gubun.indexOf("yy".toLowerCase(), 0);
            v_mm_pos = c_gubun.indexOf("mm".toLowerCase(), 0);
            v_dd_pos = c_gubun.indexOf("dd".toLowerCase(), 0);
            if (v_yy_pos > -1 && v_mm_pos > -1 && v_dd_pos > -1) {
                v_yy = v_yy_t;
                v_mm = v_mm_mod;
                v_dd = v_dd_m_mod;
            } else if (v_yy_pos > -1 && v_mm_pos > -1 && v_dd_pos == -1) {
                v_yy = v_yy_t;
                v_mm = v_mm_mod;
            } else if (v_yy_pos > -1 && v_mm_pos == -1 && v_dd_pos > 0) {
                v_yy = v_yy_t;
                v_dd = v_dd_y_mod;
            } else if (v_yy_pos > -1 && v_mm_pos == -1 && v_dd_pos == -1) {
                v_yy = v_yy_t;
            } else if (v_yy_pos == -1 && v_mm_pos > -1 && v_dd_pos > -1) {
                v_mm = v_mm_t;
                v_dd = v_dd_m_mod;
            } else if (v_yy_pos == -1 && v_mm_pos == -1 && v_dd_pos > -1) {
                v_dd = v_dd_t;
            } else if (v_yy_pos == -1 && v_mm_pos > -1 && v_dd_pos == -1) {
                v_mm = v_mm_t;
            }
            if (v_mm < 10) v_mm = v_mm;
            v_ret = v_ret.replace("yy", v_yy);
            v_ret = v_ret.replace("mm", v_mm);
            v_ret = v_ret.replace("dd", v_dd);
            return v_ret;
        },
        makeDateToString: function(pdate, pDelimiter) {
            if (pDelimiter == undefined || pDelimiter == null) {
                pDelimiter = "";
            }

            yyyy = pdate.getFullYear();
            mm = pdate.getMonth() + 1;
            dd = pdate.getDate();
            mm = mm < 10 ? "0" + mm : mm;
            dd = dd < 10 ? "0" + dd : dd;

            return yyyy + pDelimiter + mm + pDelimiter + dd;
        },
        makeDateFormat: function(pdate, type) {
            if (oUtil.isNull(pdate)) {
                return "";
            }
            if ("00000000" == pdate) {
                return "";
            }
            var yy, mm, dd, yymmdd;
            var ar;
            if (pdate.indexOf(".") > -1) {
                ar = pdate.split(".");
                yy = ar[0];
                mm = ar[1];
                dd = ar[2];

                if (mm < 10) mm = "0" + mm;
                if (dd < 10) dd = "0" + dd;
            } else if (pdate.indexOf("-") > -1) {
                ar = pdate.split("-");
                yy = ar[0];
                mm = ar[1];
                dd = ar[2];

                if (mm < 10) mm = "0" + mm;
                if (dd < 10) dd = "0" + dd;
            } else if (pdate.length == 8) {
                yy = pdate.substr(0, 4);
                mm = pdate.substr(4, 2);
                dd = pdate.substr(6, 2);
            }

            if (type == "DATE") {
                yymmdd = yy + "/" + mm + "/" + dd;

                yymmdd = new Date(yymmdd);

                if (isNaN(yymmdd)) {
                    return false;
                }

                return yymmdd;
            } else {
                return yy + "-" + mm + "-" + dd;
            }
        },
        add_months: function(pdate, diff_m) {
            var add_m;
            var lastDay;
            var pyear, pmonth, pday;
            pdate = this.makeDateFormat(pdate, "DATE");
            if (pdate == "") return "";

            pyear = pdate.getFullYear();
            pmonth = pdate.getMonth() + 1;
            pday = pdate.getDate();

            add_m = new Date(pyear, pmonth + diff_m, 1);

            lastDay = new Date(pyear, pmonth, 0).getDate();
            if (lastDay == pday) {
                pday = new Date(add_m.getFullYear(), add_m.getMonth(), 0).getDate();
            }

            add_m = new Date(add_m.getFullYear(), add_m.getMonth() - 1, pday);

            return add_m;
        },
        months_between: function(edate, sdate) {
            var syear, smonth, sday;
            var eyear, emonth, eday;
            var diff_month = 1;
            sdate = this.makeDateFormat(sdate);
            edate = this.makeDateFormat(edate);
            if (sdate == "") return "";
            if (edate == "") return "";
            syear = sdate.getYear();
            eyear = edate.getYear();
            smonth = sdate.getMonth() + 1;
            emonth = edate.getMonth() + 1;
            sday = sdate.getDate();
            eday = edate.getDate();
            while (sdate < edate) {
                sdate = new Date(syear, smonth - 1 + diff_month, 0);
                //alert(sdate);
                diff_month++;
            }

            if (sday > eday) diff_month--;
            diff_month = diff_month - 2;
            return diff_month;
        },
        checkDateBefore: function(pStartYyyymmdd, pEndYyyymmdd, pDelimiter) {
            var diffDay = this.getDiffDay(pStartYyyymmdd, pEndYyyymmdd, pDelimiter);
            if (diffDay >= 0) {
                return true;
            } else {
                return false;
            }
        },
    }, // Date End
	
	sidepanel : {
		open : function(modalId, url, pWidth){
			
			if ($("#"+ modalId).length > 0) {
				return;
			}
			$('#' + modalId).remove();
			
			var opener = document.activeElement;

			var modalHtml = `
			  <div class="modal fade default-example-modal-end-xl" id="${modalId}" tabindex="-1" role="dialog" aria-labelledby="${modalId}_label">
			    <div class="modal-dialog modal-dialog-end modal-xl" style="width: ${pWidth}; max-width: ${pWidth};">
			      <div class="modal-content">
			        <div class="modal-body p-3">
			          로딩 중...
			        </div>
			      </div>
			    </div>
			  </div>
			`;

			$('#backdropDiv_Area').append(modalHtml);

			var $modalElement = $('#' + modalId);
			var $modalBody = $modalElement.find('.modal-body');

			$modalBody.load(url, function(response, status, xhr) {
			  if (status === 'error') {
			    $modalBody.html(`
			      <div class="text-danger">
			        화면을 불러오는 중 오류가 발생했습니다.
			      </div>
			    `);
			  }

			  var modalObject = new bootstrap.Modal($modalElement[0]);
			  
			  
			  // 닫히기 직전에 포커스 제거
		      $modalElement.on('hide.bs.modal', function () {
		        if (document.activeElement) {
		          document.activeElement.blur();
		        }
		      });

			  // 모달이 완전히 닫힌 뒤 DOM 제거
			  $modalElement.on('hidden.bs.modal', function () {
			    modalObject.dispose();   // Bootstrap 인스턴스 정리
			    $modalElement.remove();  // DOM 제거
				
				if (opener && typeof opener.focus === 'function') {
					opener.focus();
				}
			  });

			  modalObject.show();
			});
			
		}
		
	},
    dialog : {
		open : function(panelId, panelTitle, url, pWidth, pHeight, closeOnBackdrop, postData){
			$('#' + panelId).remove();

			if ($.isNumeric(pWidth)) pWidth = pWidth + 'px';
			if ($.isNumeric(pHeight)) pHeight = pHeight + 'px';
			
			
			if (typeof closeOnBackdrop === 'undefined' || closeOnBackdrop === null) {
				closeOnBackdrop = true;
			}

			var html = `
			  <div id="${panelId}" class="custom-popup-overlay">
			    <div class="custom-popup-panel" style="width:${pWidth}; height:${pHeight};">
			      <div class="custom-popup-header draggable-header">
			        <h5 class="custom-popup-title" id="${panelId}_label">${panelTitle}</h5>
			        <button type="button" class="btn-close" aria-label="Close"></button>
			      </div>
			      <div class="custom-popup-body">로딩 중...</div>
			    </div>
			  </div>
			`;

			$('#backdropDiv_Area').append(html);

			var $panel = $('#' + panelId);
			var $popup = $panel.find('.custom-popup-panel');
			var $body = $panel.find('.custom-popup-body');
			var $header = $panel.find('.draggable-header');


			function loadCallback(response, status, xhr) {
				if (status === 'error') {
					$body.html(
						'<div class="text-danger">화면을 불러오는 중 오류가 발생했습니다.</div>'
					);
				}
			}
	
			/*
			 * postData가 전달된 경우에만 POST 요청
			 * 기존 호출 방식은 GET 요청으로 그대로 유지
			 */
			if (postData && typeof postData === 'object') {
				var requestData = $.extend({}, postData);
			
				if (requestData.data && typeof requestData.data === "object") {
					requestData.data = JSON.stringify(requestData.data);
				}
			
				console.log("POST 실제 전송 데이터 :", requestData);
			
				$body.load(url, requestData, loadCallback);
			} else {
				$body.load(url, loadCallback);
			}

			// 닫기
			function closePopup() {
				
				
		    // JSP에 별도 close 함수가 정의되어 있으면 해당 함수 실행
		    if (typeof window.onPopupClose === "function") {
		        window.onPopupClose();
		        return;
		    }
				
			  // AUIGrid 필터 팝업 닫기
    		  $('.aui-grid-filter-popup-layer').hide();	
				
			  $panel.remove();
			  $(document).off('keydown.' + panelId);
			  $(document).off('mousemove.' + panelId);
			  $(document).off('mouseup.' + panelId);
			}

			$panel.find('.btn-close').on('click', closePopup);

			$panel.on('click', function(e) {
			  if (closeOnBackdrop && $(e.target).is('.custom-popup-overlay')) {
			    closePopup();
			  }
			});

			$(document).on('keydown.' + panelId, function(e) {
			  if (e.key === 'Escape') {
			    closePopup();
			  }
			});

			// 드래그
			var isDragging = false;
			var startX = 0;
			var startY = 0;
			var startLeft = 0;
			var startTop = 0;

			$header.on('mousedown', function(e) {
			  if ($(e.target).closest('.btn-close').length) return;

			  isDragging = true;

			  // 가운데 정렬 해제 후 절대 위치로 전환
			  var rect = $popup[0].getBoundingClientRect();
			  $popup.addClass('dragging');
			  $popup.css({
			    left: rect.left + 'px',
			    top: rect.top + 'px',
			    margin: 0,
			    transform: 'none'
			  });

			  startX = e.clientX;
			  startY = e.clientY;
			  startLeft = rect.left;
			  startTop = rect.top;

			  $(document).on('mousemove.' + panelId, function(e) {
			    if (!isDragging) return;

			    var newLeft = startLeft + (e.clientX - startX);
			    var newTop = startTop + (e.clientY - startY);

			    var maxLeft = $(window).width() - $popup.outerWidth();
			    var maxTop = $(window).height() - $popup.outerHeight();

			    if (newLeft < 0) newLeft = 0;
			    if (newTop < 0) newTop = 0;
			    if (newLeft > maxLeft) newLeft = maxLeft;
			    if (newTop > maxTop) newTop = maxTop;

			    $popup.css({
			      left: newLeft + 'px',
			      top: newTop + 'px'
			    });
			  });

			  $(document).on('mouseup.' + panelId, function() {
			    isDragging = false;
			    $(document).off('mousemove.' + panelId);
			    $(document).off('mouseup.' + panelId);
			  });

			  e.preventDefault();
			});
		},
		
		openCommonPop : function(p_PopGubn,  p_Options = {}) {
			const popConfig = {
				COMCODE: {
					url: "/origin/commonPop/comCode",
					searchUrl: "/origin/commonPop/retrieveComCodeList",
			        title: "공통코드 조회",
			    },
			    DIVISION: {
					url: "/origin/commonPop/comDivision",
					searchUrl: "/origin/commonPop/retrieveComDivisionList",
			        title: "사업장 조회",
			    },
			    FTA: {
					url: "/origin/commonPop/comFtaCode",
					searchUrl: "/origin/commonPop/retrieveComFtaCodePopList",
			        title: "FTA정보 조회",
			    },
			    HSCODE: {
					url: "/origin/commonPop/comHsCode",
					searchUrl: "/origin/commonPop/retrieveComHsCodePopList",
			        title: "HS코드 조회",
			    },
			    ITEM: {
					url: "/origin/commonPop/comItem",
					searchUrl: "/origin/commonPop/retrieveComItemList",
			        title: "자재 조회",
			    },
				NATION: {
					url: "/origin/commonPop/comNation",
					searchUrl: "/origin/commonPop/retrieveComNationList",
			        title: "국가 조회",
			    },
			};
			
			const config = popConfig[p_PopGubn];
			
			if (!config) {
				KpackageOBJ.object.alert("등록되지 않은 공통팝업입니다.");
				return;
			}
			
 			const {
			    title = "",
			    callbackObject = "",
			    callbackFunctionName = "",
			    data = {},
			    rowIndex = null,
			    bAutoSearch = false
			} = p_Options;
			
			// Title은 전달값이 있으면 전달값 사용
			const popTitle = title || config.title;
			const callbackName =   callbackFunctionName || config.callbackFunctionName || "";
  			const callbackFunc = callbackObject && callbackName ? callbackObject + "." + callbackName : callbackName;
			
			
			// Callback 필수 체크
			if (!callbackFunc) {
			    KpackageOBJ.object.alert("Callback 정보가 없습니다.");
			    return;
			}
			
			//팝업 파라미터
			const postParam = {
		        rowIndex: rowIndex,
		        callback: callbackFunc,
		        data: data,
		        bAutoSearch: bAutoSearch
		    };
			
			//공통 팝업 오픈
		    const openPopup = function() {
		        KpackageOBJ.dialog.open("commonPop",  popTitle, config.url,  1000, 700,  true, postParam);
		    };
			
			
		    const executeCallback = function(selectedData) {
		
			    const path = callbackFunc.split(".");
			    let target = window;
			
			    // 마지막 함수명을 제외한 객체 경로 탐색
			    for (let i = 0; i < path.length - 1; i++) {
			
			        target = target[path[i]];
			
			        if (!target) {
			            KpackageOBJ.object.alert( "Callback 객체를 찾을 수 없습니다." );
			            return;
			        }
			    }
			
			    const functionName = path[path.length - 1];
			    const callback = target[functionName];
			
			    if (typeof callback !== "function") {
			        KpackageOBJ.object.alert("Callback 함수를 찾을 수 없습니다.");
			        return;
			    }
				selectedData["rowIndex"] = rowIndex;
			    callback.call(target, selectedData, rowIndex);
		    };			
		    
		    // 자동조회가 아니면 즉시 팝업 오픈
		    if (!bAutoSearch) {
		        openPopup();
		        return;
		    }


 			 KpackageOBJ.ajax.doSubmit(config.searchUrl, postParam['data'], function(res) {
				if(res.success){
					if(res.value.length === 1){
						executeCallback(res.value[0]);
					}else{
						openPopup();
					}
				}
			});
		},

		close: function(panelId) {
		  var $panel = $('#' + panelId);

		  if ($panel.length > 0) {
		    $panel.remove();
		    $(document).off('keydown.' + panelId);
		    $(document).off('mousemove.' + panelId);
		    $(document).off('mouseup.' + panelId);
		  }
		},

		open_old: function(
		    id,
		    title,
		    url_opts,
		    width,
		    height,
		    closeFunc,
		    modalFlag,
		    openFunc,
		    previewer
		) {
		    var resizeyn = false;
		    var closable = true;
		    var lyH = $(window).height();
		    var lyW = $(window).width();
		    var ly = $("#" + id).attr("alt");
		    var barW = $("." + ly).width();
		    var barH = $("." + ly).height();
		    this.createPopupDiv(id);
		    if (width == null || width == "") {
		        width = 400;
		    }
		    if (height == null || height == "") {
		        height = 500;
		    } else {
		        //if (height > (lyH - barH)) height = (lyH - barH) * 0.97;
		        //if (width > (lyW - barW)) width = (lyW - barW) * 0.97
		    }
		    if (oUtil.isNull(modalFlag)) {
		        modalFlag = true;
		    }
		    var params = "";
		    var url = "";

		    var dialogZindex = $(".ui-dialog")
		        .eq($(".ui-dialog").length - 1)
		        .css("z-index");
		    var overlayZindex = $(".ui-widget-overlay")
		        .eq($(".ui-widget-overlay").length - 1)
		        .css("z-index");

		    if (!oUtil.isNull(previewer)) {
		        $("#" + id + "").html(previewer);
		    } else {
		        if (typeof url_opts == "string") {
		            url = url_opts;
		        } else {
		            url = url_opts.href;
		            params = makeStringParameter(url_opts.queryParams, true);
		        }
		        var token = $("meta[name='_csrf']").attr("content");
		        var header = $("meta[name='_csrf_header']").attr("content");

		        var promise = $.ajax({
		            url: url,
		            data: params,
		            type: "post",
		            beforeSend: function(xhr) {
		                if (
		                    token != "" &&
		                    header != "" &&
		                    token != undefined &&
		                    header != undefined
		                ) {
		                    xhr.setRequestHeader(header, token);
		                }
		            },
		        });
		        promise.done(function(content) {
		            $("#" + id + "").append(content);
		        });
		    }

		    $("#" + id).dialog({
		        title: title,
		        width: width + 10,
		        height: height + 40,
		        resizable: resizeyn,
		        closable: closable,
		        modal: modalFlag,
		        draggable: false,
		        closeOnEscape: false,
		        open: function(event, ui) {
		            if ($(".ui-dialog").length - 1 == 0) {
		                dialogZindex = 1060;
		                overlayZindex = 1000;
		            } else {
		                dialogZindex = dialogZindex + 3;
		                overlayZindex = overlayZindex + 3;
		            }
		            $(".ui-dialog")
		                .eq($(".ui-dialog").length - 1)
		                .css("z-index", dialogZindex);
		            $(".ui-widget-overlay")
		                .eq($(".ui-widget-overlay").length - 1)
		                .css("z-index", overlayZindex);

		            if ($(window).height() < height + 40) {
		                $(".ui-widget-overlay")
		                    .eq($(".ui-widget-overlay").length - 1)
		                    .css("height", height + 50); //회색배경을 팝업사이즈에 맞춘다.
		            }

		            if (!oUtil.isNull(openFunc)) {
		                var evalFnc = eval(openFunc + "()");
		                evalFnc;
		            }
		            /*$(".ui-dialog[aria-describedby='" + id + "'] .ui-dialog-titlebar-close").prev().prepend("<i class='fa fa-edit'></i>")  타이틀 아이콘 추가 */
		            $(
		                ".ui-dialog[aria-describedby='" +
		                id +
		                "'] .ui-dialog-titlebar-close"
		            ).hide(); //기존 버튼 숨김
		            //$(".ui-dialog[aria-describedby='" + id + "'] .ui-dialog-titlebar").append('<button type="button" onclick="javascript:closeDialog(this);" class="btn_i_popclose">창닫기</button>');
		            $(
		                ".ui-dialog[aria-describedby='" + id + "'] .ui-dialog-titlebar"
		            ).append(
		                '<a href="javascript:void(0)" class="close" onClick="javascript:KpackageOBJ.dialog.close(\'' +
		                id +
		                '\');"><i class="fa fa-times"></i></a>'
		            );
		            // escape key maps to keycode '27'
		            $("#" + id).append(
		                '<script>$(document).keyup(function(e) {if (e.keyCode == 27) {KpackageOBJ.dialog.close("' +
		                id +
		                '");}});</script>'
		            );
		        },
		        close: function() {
		            if (!oUtil.isNull(closeFunc)) {
		                var evalFnc = eval(closeFunc + "()");
		                evalFnc;
		            }
		        },
		    });
		},
        close_old: function(id) {
            $(
                ".ui-dialog[aria-describedby='" + id + "'] .ui-dialog-titlebar-close"
            ).trigger("click");
            $(".ui-dialog[aria-describedby='" + id + "']").remove();
            $("#" + id + "").remove();
        },

        createPopupDiv: function(objId) {
            var div =
                '<div id="' +
                objId +
                '" name="' +
                objId +
                '" style="overflow: auto;"></div>';
            var tagCurrObj = "#" + objId;
            $(tagCurrObj).remove();
            $("body").append(div);
        },
        commonPopup: function(type, retunFuncName) {
            if (type == undefined) return;

            if ("USER" === type) {
                var params = "RETUN_FUNCTION_NAME=" + "openUserSearchDialog_return";
                KpackageOBJ.dialog.open(
                    "dialog_UserSearchPopup",
                    KpackageOBJ["prototype"][type],
                    "/common/viewUserSearch?" + params,
                    600,
                    400
                );
            } else if ("ITEM" === type) {
                //TODO : 추후 개발 예정
            }
        },
        setButton: function(dialog_Id, buttonObject) {
            if (dialog_Id == "" || dialog_Id == undefined || dialog_Id == null) {
                return;
            }
            if (
                buttonObject == "" ||
                buttonObject == undefined ||
                buttonObject == null
            ) {
                return;
            }

            var contentWidth = $("#" + dialog_Id)
                .children("#content")
                .css("width")
                .replace("px", "");
            //var oPreToolbar = "<div class=\"widget-body-toolbar\" style=\"position: fixed;width:"+(Number(contentWidth)+10)+"px;z-index: 1;margin-top: -3px;margin-left: -8px;height: 36px;padding: 2px 10px;\">"
            var oPreToolbar =
                '<div class="widget-body-toolbar" style="position: fixed;width:inherit;z-index: 1;margin-top: -3px;margin-left: -8px;height: 36px;padding: 2px 10px;">' +
                '<div class="btn-group" style="float: right;margin-top: 3px;">';
            var oButtonLoop = "";
            for (var i = 0;i < buttonObject.length;i++) {
                var text = buttonObject[i].text;
                var func = buttonObject[i].func;
                var icon = buttonObject[i].icon;
                var title = buttonObject[i].title;

                if ("none" == icon) {
                    icon = "";
                } else if ("delete" == icon) {
                    icon = "glyphicon glyphicon-remove";
                } else if ("insert" == icon) {
                    icon = "glyphicon glyphicon-plus";
                } else if ("edit" == icon) {
                    icon = "glyphicon glyphicon-edit";
                } else if ("excel" == icon) {
                    //icon = "fa fa fa-file-excel-o";
                    icon = "fa fa-file-excel-o";
                } else if ("save" == icon) {
                    //icon = "fa fa fa-file-excel-o";
                    icon = "glyphicon glyphicon-floppy-save";
                } else {
                    icon = icon;
                }
                oButtonLoop +=
                    "<button type='button'class='btn grid-add-btn btn-primary btn-border tuiGrid-toolbar-button' id='" +
                    dialog_Id +
                    text +
                    func +
                    "' title='" +
                    title +
                    "'><i class='" +
                    icon +
                    "'></i> <span>" +
                    text +
                    "</span></button>";
            }
            var oNextToolbar = "</div></div>";
            var oToolbar = oPreToolbar + oButtonLoop + oNextToolbar;

            $("#" + dialog_Id + " #content").prepend(oToolbar);
            $("#" + dialog_Id)
                .children("#content")
                .css(
                    "width",
                    $("#" + dialog_Id)
                        .children("#content")
                        .css("width")
                );
            $("#" + dialog_Id + " .widget-body").css("padding-top", "35px");
        },
    },

    util: {
        doc: document || window.document || document.all,
        isArray: function(o) {
            if (Object.prototype.toString.call(o) == "[object Array]") {
                return true;
            } else {
                return false;
            }
        },
        isBoolean: function(o) {
            return typeof o === "boolean";
        },
        isFunction: function(o) {
            return typeof o === "function";
        },
        isHTMLElement: function(o) {
            if (this.isObject(o) || this.isFunction(o)) {
                if (o.nodeName) {
                    return true;
                }
            }
            return false;
        },
        isNull: function(o) {
            return o === null || this.trim(o) === "" || typeof o === "undefined";
        },
        isNumber: function(o) {
            return typeof o === "number" && isFinite(o);
        },
        isObject: function(o) {
            return (o && (typeof o === "object" || L.isFunction(o))) || false;
        },
        isString: function(o) {
            return typeof o === "string";
        },
        isUndefined: function(o) {
            return typeof o === "undefined";
        },
        isValue: function(o) {
            var L = this;
            return L.isObject(o) || L.isString(o) || L.isNumber(o) || L.isBoolean(o);
        },
        ltrim: function(s) {
            if (!this.isString(s)) {
                return null;
            }
            return s.replace(/\s*((\S+\s*)*)/, "$1");
        },
        rtrim: function(s) {
            if (!this.isString(s)) {
                return null;
            }
            return s.replace(/((\s*\S+)*)\s*/, "$1");
        },
        trim: function(s) {
            if (!this.isString(s)) {
                return null;
            }
            return this.ltrim(this.rtrim(s));
        },
        isEmpty: function(o) {
            if (typeof o != "undefiend" && o.length > 0) {
                return false;
            } else {
                return true;
            }
        },
        /**
         * 입력 받은 str에서 Html Tag를 제거합니다.
         */
        removeTag: function(str) {
            return str.replace(/(<([^>]+)>)/gi, "");
        },
    },
    tree: {
        create: function(tree_ID) {
            var mytreebranch = $(tree_ID)
                .find("li:has(ul)")
                .addClass("parent_li")
                .attr("role", "treeitem")
                .find(" > span")
                .attr("title", "Collapse this branch");
            $(tree_ID + " > ul")
                .attr("role", "tree")
                .find("ul")
                .attr("role", "group"),
                mytreebranch.on("click", function(a) {
                    var b = $(this).parent("li.parent_li").find(" > ul > li");
                    b.is(":visible")
                        ? (b.hide("fast"),
                            $(this)
                                .attr("title", "Expand this branch")
                                .find(" > i")
                                .addClass("icon-plus-sign")
                                .removeClass("icon-minus-sign"))
                        : (b.show("fast"),
                            $(this)
                                .attr("title", "Collapse this branch")
                                .find(" > i")
                                .addClass("icon-minus-sign")
                                .removeClass("icon-plus-sign")),
                        a.stopPropagation();
                });
        },
    },

    tuiGrid: {
        prototype: {
            defaultPageSize: 50,
            defaultPageNumber: 1,
        },

        /**
         * @Desc 지정한 tuiGrid Object를 반환합니다.
         * @param  tui로 생성한 grid Id
         *
         * @since  2018.06.08
         * @author 망할고양이
         *
         */
        getGrid: function(tuiGrid_ID) {
            if (tuiGrid_ID == undefined || tuiGrid_ID == null) {
                return null;
            }
            return tui.Grid.getInstanceById(tuiGrid_ID);
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.create( grid_Id, url, column_model, headerType, clickEvnet, dblClickEvent, scrollX, p_ScrollY )
         *
         * Description   : tui Grid를 생성합니다.
         *                 gridId + "_paging"에 해당하는 ID를 가진 DIV가 있을경우 페이징을 생성합니다.
         *                 Paging을 사용하지 않을경우 최대 99999 row까지 조회합니다.
         *
         * Parameters    : grid_Id               - <String> 그리드로 생성할 div 객체의 Element ID
         *        url                   - <String> 조회시 요청할 URL
         *        column_model          - <String> 컬럼 구조 배열
         *        headerType            - <String>   <optional> Row Header에 대한 설정값 ( number, multi, single 소문자주의)
         *        p_onClick_Handler     - <Function> <optional> 클릭 이벤트시 동작할 Function
         *         p_onDblclick_Handler  - <Function> <optional> 더블 클릭 이벤트시 동작할 Function
         *          p_ScrollX             - <Boolean>  <optional> 가로 스크롤 default true
         *           p_ScrollY             - <Boolean>  <optional> 세로 스크롤 default true
         *
         * 사용예시*****
         * *** 예시 #1  **************************************************************************************************************
         *        var colInfoModel = [
         *                      { title: '컬럼1', name: 'COL_01', width : 100, align: "center", hidden:false },
         *                     { title: '컬럼2', name: 'COL_02', width : 100, align: "center", hidden:false },
         *                     { title: '컬럼3', name: 'COL_03', width : 100, align: "center", hidden:false }
         *                    ];
         *
         *         KpackageOBJ.tuiGrid.create("grid1", "/test/retrieveTestData", colInfoModel);  // <optional> argument는 작성하지않아도 됨
         * *** 예시 #2  **************************************************************************************************************
         *         KpackageOBJ.tuiGrid.create("grid1", "/test/retrieveTestData", colInfoModel, "check", onClick_Grid_01, onDblclick_Grid_01, true, false);
         *
         */
        create: function(
            p_TargetGridId,
            p_RetrieveUrl,
            p_ColinfoArray,
            p_headerType,
            p_onClick_Handler,
            p_onDblclick_Handler,
            p_ScrollX,
            p_ScrollY,
            colGroupArr
        ) {
            var arg = arguments;
            var uRf = false;
            if (
                arg[0] == undefined ||
                arg[0] == null ||
                arg[1] == undefined ||
                arg[1] == null ||
                arg[2] == undefined ||
                arg[2] == null
            ) {
                return false;
            }

            if ("number" == arg[3] || "rowNum" == arg[3] || "n" == arg[3]) {
                p_headerType = "rowNum";
                uRf = true;
            } else if (
                "checkbox" == arg[3] ||
                "check" == arg[3] ||
                "c" == arg[3] ||
                "multi" == arg[3]
            ) {
                p_headerType = "checkbox";
                uRf = true;
            } else if (
                "radio" == arg[3] ||
                "r" == arg[3] ||
                "c" == arg[3] ||
                "single" == arg[3]
            ) {
                p_headerType = "radio";
                uRf = true;
            }

            p_ScrollX = p_ScrollX || true;
            p_ScrollY = p_ScrollY || true;

            var returnGrid = null;
            var gridOptions = null;

            if (oUtil.isNull(colGroupArr)) {
                gridOptions = {
                    el: document.getElementById(p_TargetGridId),
                    header: {
                        height: KpackageOBJ.prototype.toastGridHeader_Height,
                    },
                    data: [],
                    scrollX: p_ScrollX,
                    scrollY: p_ScrollY,
                    columns: p_ColinfoArray,
                    rowHeight: KpackageOBJ.prototype.toastGridCell_Height,
                    minRowHeight: KpackageOBJ.prototype.toastGridCell_Height,
                    contextMenu: null,
                };
            } else {
                gridOptions = {
                    el: document.getElementById(p_TargetGridId),
                    header: {
                        complexColumns: colGroupArr,
                        height: KpackageOBJ.prototype.toastGridHeader_Height,
                    },
                    data: [],
                    scrollX: p_ScrollX,
                    scrollY: p_ScrollY,
                    columns: p_ColinfoArray,
                    rowHeight: KpackageOBJ.prototype.toastGridCell_Height,
                    minRowHeight: KpackageOBJ.prototype.toastGridCell_Height,
                    contextMenu: null,
                };
            }

            if (uRf) {
                gridOptions["rowHeaders"] = [p_headerType];
            }
            returnGrid = new tui.Grid(gridOptions);
            tui.Grid.applyTheme(
                "default",
                KpackageOBJ.prototype.toastGridCss_Setting
            );

            if (returnGrid.el.getAttribute("data-fixed-height") == null) {
                if (
                    ($(window).height() -
                        returnGrid.el.getAttribute("data-minus-height") ||
                        $(window).height() - KpackageOBJ.prototype.minusHeight) >
                    KpackageOBJ.prototype.minimumHeight
                ) {
                    returnGrid.setBodyHeight(
                        $(window).height() -
                        returnGrid.el.getAttribute("data-minus-height") ||
                        $(window).height() - KpackageOBJ.prototype.minusHeight
                    );
                } else {
                    returnGrid.setBodyHeight(KpackageOBJ.prototype.minimumHeight);
                }
            } else {
                returnGrid.setBodyHeight(
                    returnGrid.el.getAttribute("data-fixed-height")
                );
            }

            // Toast Default Grid Setting
            $("#" + p_TargetGridId).data(
                "page",
                KpackageOBJ.tuiGrid.prototype.defaultPageNumber
            );
            $("#" + p_TargetGridId).data("url", p_RetrieveUrl);
            $("#" + p_TargetGridId).data("object-id", p_TargetGridId);

            //Toast Grid Paging Use Check
            var pagingYn = $("#" + p_TargetGridId + "_paging").length > 0;

            if (pagingYn) {
                $("#" + p_TargetGridId + "_paging").paging({
                    current: 1,
                    max: 1,
                    onclick: KpackageOBJ.tuiGrid.movepage,
                });
                $("#" + p_TargetGridId).data(
                    "rows",
                    KpackageOBJ.tuiGrid.prototype.defaultPageSize
                );
                $("#" + p_TargetGridId).data("paging-yn", pagingYn);
            } else {
                $("#" + p_TargetGridId).data("paging-yn", pagingYn);
                $("#" + p_TargetGridId).data("rows", 99999);
            }

            if ("function" === typeof p_onClick_Handler) {
                returnGrid.on("click", function(ev) {
                    if (ev.rowKey != undefined && ev.columnName != undefined) {
                        p_onClick_Handler(ev.instance.el.id, ev.rowKey, ev.columnName);
                    }
                });
            }

            if ("function" === typeof p_onDblclick_Handler) {
                returnGrid.on("dblclick", function(ev) {
                    if (ev.rowKey != undefined && ev.columnName != undefined) {
                        p_onDblclick_Handler(ev.instance.el.id, ev.rowKey, ev.columnName);
                    }

                    //console.log(ev); // GridEvent object
                    //console.log(ev.nativeEvent); // browser's native event object
                });
            }

            return returnGrid;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.retrieve( grid_Id, url, params, startPageNum)
         *
         * Description   : tui Grid를 이용하여 조회를 수행합니다.
         *
         * Parameters    : grid_Id      - <String> 그리드로 생성할 div 객체의 Element ID
         *        url          - <String> 조회시 요청할 URL default 그리드 정보에 있는 URL
         *        params       - <jsonObject> 조회조건
         *        startPageNum - <Number> 시작 페이지 default 1
         */
        retrieve: function(
            p_TargetGridId,
            p_RetrieveUrl,
            params,
            p_TargetPage,
            p_UseProgress,
            p_ProgressLayerId
        ) {
            if (
                "" == p_TargetGridId ||
                null == p_TargetGridId ||
                undefined == p_TargetGridId
            ) {
                return false;
            }

            KpackageOBJ.tuiGrid.clear(p_TargetGridId);

            if (
                "" == params ||
                null == params ||
                undefined == params ||
                {} == params
            ) {
                params = {
                    DUMMY: "DUMMY",
                };
            }

            if (oUtil.isNull(p_UseProgress)) {
                useProgress = false;
            }

            if (oUtil.isNull(p_ProgressLayerId)) {
                p_ProgressLayerId = p_TargetGridId;
            }

            if (p_UseProgress) {
                KpackageOBJ.object.blockUILayer(p_TargetGridId, true);
            }

            if (oUtil.isNull(p_RetrieveUrl)) {
                p_RetrieveUrl = $("#" + p_TargetGridId).data("url");
            } else {
                $("#" + p_TargetGridId).data("url", p_RetrieveUrl);
            }
            params["rows"] = $("#" + p_TargetGridId).data("rows");

            if (oUtil.isNull(p_TargetPage)) {
                params["page"] = $("#" + p_TargetGridId).data("page");
            } else {
                params["page"] = p_TargetPage;
            }

            $("#" + p_TargetGridId).data("sp", JSON.stringify(params));

            if (
                "" == p_RetrieveUrl ||
                null == p_RetrieveUrl ||
                undefined == p_RetrieveUrl
            ) {
                return false;
            }
            if ($(".switchFilter").length > 0) {
                $(".switchFilter").hide();
                $("button[name='switchFilterBtn']")
                    .children(0)
                    .removeClass("fa-arrow-up");
                $("button[name='switchFilterBtn']")
                    .children(0)
                    .addClass("fa-arrow-down");
            }

            KpackageOBJ.ajax.doSubmit(
                p_RetrieveUrl,
                params,
                function(arg) {
                    // success Handler
                    KpackageOBJ.tuiGrid.getGrid(p_TargetGridId).resetData(arg.gridData);
                    if (p_UseProgress) {
                        KpackageOBJ.object.blockUILayer(p_TargetGridId, false);
                    }

                    if ($("#" + p_TargetGridId + "_page_info").length > 0) {
                        $("#" + p_TargetGridId + "_page_info").remove();
                    }

                    if ($("#" + p_TargetGridId).data("pagingYn")) {
                        $("#" + p_TargetGridId + "_paging").paging("destroy");
                        $("#" + p_TargetGridId + "_paging").paging({
                            current: arg.page,
                            max: arg.total,
                            onclick: KpackageOBJ.tuiGrid.movepage,
                        });
                        $("#" + p_TargetGridId + "_paging").append(
                            "<sapn id='" +
                            p_TargetGridId +
                            "_page_info' style='float:right;margin-right:5px;margin-top: -12px;position: absolute;right: 16px;'>" +
                            KpackageOBJ.formatter.commas(arg.page) +
                            " / " +
                            KpackageOBJ.formatter.commas(arg.total) +
                            " Page :: Total count:" +
                            KpackageOBJ.formatter.commas(arg.records) +
                            "</sapn>"
                        );
                        // mobis page 사용안함 $('#' + p_TargetGridId + "_paging").append("<sapn id='" + p_TargetGridId + "_page_info' style='float:right;margin-right:5px;margin-top: -12px;position: absolute;right: 16px;'>" + KpackageOBJ.formatter.commas(arg.page) + " / " + KpackageOBJ.formatter.commas(arg.total) + " Page :: Total count:" + KpackageOBJ.formatter.commas(arg.records) + "</sapn>");
                    } else {
                        $("#" + p_TargetGridId).append(
                            "<sapn id='" +
                            p_TargetGridId +
                            "_page_info' style='float:right;margin-right:5px;position: absolute;right: 16px;'>Total count : " +
                            KpackageOBJ.formatter.commas(arg.records) +
                            "</sapn>"
                        );
                    }
                },

                null,
                p_UseProgress
            );
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.retrieve( grid_Id, url, params, startPageNum, p_TargetHeaderWorks_Func)
         *
         * Description   : tui Grid를 이용하여 조회를 수행합니다.
         *
         * Parameters    : grid_Id      - <String> 그리드로 생성할 div 객체의 Element ID
         *        url          - <String> 조회시 요청할 URL default 그리드 정보에 있는 URL
         *        params       - <jsonObject> 조회조건
         *        startPageNum - <Number> 시작 페이지 default 1
         *                 p_TargetHeaderWorks_Func - <String> 그리드 조회시 같이 가져올 Header Data를 처리하는 Function Name
         */
        retrieveWithHeader: function(
            p_TargetGridId,
            p_RetrieveUrl,
            params,
            p_TargetPage,
            p_TargetHeaderWorks_Func
        ) {
            if (
                "" == p_TargetGridId ||
                null == p_TargetGridId ||
                undefined == p_TargetGridId
            ) {
                return false;
            }

            if (
                "" == params ||
                null == params ||
                undefined == params ||
                {} == params
            ) {
                params = {
                    DUMMY: "DUMMY",
                };
            }

            if (oUtil.isNull(p_RetrieveUrl)) {
                p_RetrieveUrl = $("#" + p_TargetGridId).data("url");
            } else {
                $("#" + p_TargetGridId).data("url", p_RetrieveUrl);
            }
            params["rows"] = $("#" + p_TargetGridId).data("rows");

            if (oUtil.isNull(p_TargetPage)) {
                params["page"] = $("#" + p_TargetGridId).data("page");
            } else {
                params["page"] = p_TargetPage;
            }

            $("#" + p_TargetGridId).data("sp", JSON.stringify(params));

            if (
                "" == p_RetrieveUrl ||
                null == p_RetrieveUrl ||
                undefined == p_RetrieveUrl
            ) {
                return false;
            }

            KpackageOBJ.ajax.doSubmit(p_RetrieveUrl, params, function(arg) {
                // success Handler
                KpackageOBJ.tuiGrid.getGrid(p_TargetGridId).resetData(arg.gridData);
                if ($("#" + p_TargetGridId + "_page_info").length > 0) {
                    $("#" + p_TargetGridId + "_page_info").remove();
                }
                /** Header 처리 로직 추가 **/
                //if(arg.headerData != null || arg.headerData != undefined ){
                if (p_TargetHeaderWorks_Func != undefined) {
                    eval(p_TargetHeaderWorks_Func + "(arg.headerData)");
                }

                if ($("#" + p_TargetGridId).data("pagingYn")) {
                    $("#" + p_TargetGridId + "_paging").paging("destroy");
                    $("#" + p_TargetGridId + "_paging").paging({
                        current: arg.page,
                        max: arg.total,
                        onclick: KpackageOBJ.tuiGrid.movepage,
                    });
                    $("#" + p_TargetGridId + "_paging").append(
                        "<sapn id='" +
                        p_TargetGridId +
                        "_page_info' style='float:right;margin-right:5px;margin-top: -12px;'>" +
                        arg.page +
                        " / " +
                        arg.total +
                        " Page :: Total count:" +
                        arg.records +
                        "</sapn>"
                    );
                } else {
                    $("#" + p_TargetGridId).append(
                        "<sapn id='" +
                        p_TargetGridId +
                        "_page_info' style='float:right;margin-right:5px;'>Total count : " +
                        arg.records +
                        "</sapn>"
                    );
                }
            });
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.retrieve( grid_Id, url, params, startPageNum, p_CallBackWorks_Func)
         *
         * Description   : tui Grid를 이용하여 조회를 수행합니다.
         *
         * Parameters    : grid_Id      - <String> 그리드로 생성할 div 객체의 Element ID
         *        url          - <String> 조회시 요청할 URL default 그리드 정보에 있는 URL
         *        params       - <jsonObject> 조회조건
         *        startPageNum - <Number> 시작 페이지 default 1
         *                 p_CallBackWorks_Func - <String> 그리드 조회시 같이 가져올 Header Data를 처리하는 Function Name
         */
        retrieveWithCallBack: function(
            p_TargetGridId,
            p_RetrieveUrl,
            params,
            p_TargetPage,
            p_CallBackWorks_Func
        ) {
            if (
                "" == p_TargetGridId ||
                null == p_TargetGridId ||
                undefined == p_TargetGridId
            ) {
                return false;
            }

            if (
                "" == params ||
                null == params ||
                undefined == params ||
                {} == params
            ) {
                params = {
                    DUMMY: "DUMMY",
                };
            }

            if (oUtil.isNull(p_RetrieveUrl)) {
                p_RetrieveUrl = $("#" + p_TargetGridId).data("url");
            } else {
                $("#" + p_TargetGridId).data("url", p_RetrieveUrl);
            }
            params["rows"] = $("#" + p_TargetGridId).data("rows");

            if (oUtil.isNull(p_TargetPage)) {
                params["page"] = $("#" + p_TargetGridId).data("page");
            } else {
                params["page"] = p_TargetPage;
            }

            $("#" + p_TargetGridId).data("sp", JSON.stringify(params));

            if (
                "" == p_RetrieveUrl ||
                null == p_RetrieveUrl ||
                undefined == p_RetrieveUrl
            ) {
                return false;
            }

            KpackageOBJ.ajax.doSubmit(p_RetrieveUrl, params, function(arg) {
                // success Handler
                KpackageOBJ.tuiGrid.getGrid(p_TargetGridId).resetData(arg.gridData);
                if ($("#" + p_TargetGridId + "_page_info").length > 0) {
                    $("#" + p_TargetGridId + "_page_info").remove();
                }
                /** Callback Works 처리 로직 추가 **/
                if (p_CallBackWorks_Func != null || p_CallBackWorks_Func != undefined) {
                    eval(p_CallBackWorks_Func + "()");
                }

                if ($("#" + p_TargetGridId).data("pagingYn")) {
                    $("#" + p_TargetGridId + "_paging").paging("destroy");
                    $("#" + p_TargetGridId + "_paging").paging({
                        current: arg.page,
                        max: arg.total,
                        onclick: KpackageOBJ.tuiGrid.movepage,
                    });
                    $("#" + p_TargetGridId + "_paging").append(
                        "<sapn id='" +
                        p_TargetGridId +
                        "_page_info' style='float:right;margin-right:5px;margin-top: -12px;'>" +
                        arg.page +
                        " / " +
                        arg.total +
                        " Page :: Total count:" +
                        arg.records +
                        "</sapn>"
                    );
                } else {
                    $("#" + p_TargetGridId).append(
                        "<sapn id='" +
                        p_TargetGridId +
                        "_page_info' style='float:right;margin-right:5px;'>Total count : " +
                        arg.records +
                        "</sapn>"
                    );
                }
            });
        },
        /**
         * Paging 에서 사용하는 함수
         *
         */
        movepage: function() {
            var arg = arguments;
            var c = $(arg[2].origin).prev().data();
            if (c.sp != undefined) {
                var sp = JSON.parse(c.sp);
                KpackageOBJ.tuiGrid.retrieve(c.objectId, c.url, sp, arg[1]);
            }
            try {
                event.preventDefault();
                event.stopPropagation();
            } catch (e) {
                return false;
            }
        },

        /**
         * 마지막에 검색한 검색 파라메터를 Object 형태로 리턴합니다.
         */
        getRetrieveParams: function() {
            var arg = arguments;
            var returnJsonObject;
            try {
                returnJsonObject = JSON.parse($("#" + arg[0]).data("sp"));
            } catch (e) {
                returnJsonObject = {
                    ERROR: e,
                };
            }
            return returnJsonObject;
        },

        dateFormatter: function() {
            var arg = arguments;
            //return KpackageOBJ.date.makeDateFormat(arg[0].value? arg[0].value : arg[0]);
            return KpackageOBJ.date.makeDateFormat(
                arg[0]["row"][arg[0]["column"]["name"]]
                    ? arg[0]["row"][arg[0]["column"]["name"]]
                    : arg[0].value
            );
        },

        commas: function() {
            var arg = arguments;

            return KpackageOBJ.formatter.commas(arg[0].value);
        },
        hscode10: function() {
            var arg = arguments;

            return KpackageOBJ.formatter.hscode(arg[0].value);
        },
        hscode6: function() {
            var arg = arguments;

            return KpackageOBJ.formatter.hscode(arg[0].value);
        },
        /*hscode10 / hscode6 / hscode10  모두 같은 코드로 변경됨 */
        hscode: function() {
            var arg = arguments;

            return KpackageOBJ.formatter.hscode(arg[0].value);
        },

        percent: function() {
            var arg = arguments;

            return arg[0].value + "%";
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.setUrl( grid_Id, url )
         *
         * parameter : grid_Id - <String> Grid ID
         *             url - <String> 검색시 사용 될 URL 주소
         *
         */
        setUrl: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            $("#" + arg[0]).data("url", arg[1]);
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.setUrl( grid_Id, pageSize )
         *
         * parameter : grid_Id - <String> Grid ID
         *             pageSize - <Number> 페이징될 사이즈
         *
         */
        setPagingSize: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            $("#" + arg[0]).data("rows", arg[1]);
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getSelectedRowKey( grid_Id )
         *
         * 현재 선택되어진 row의 KeyValue를 리턴합니다.
         * 0 부터 시작합니다.
         *
         * 선택된 Cell이나 row가 없을경우 Null 리턴
         *
         */
        getSelectedRowKey: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getFocusedCell();

            return rJson.rowKey;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getSelectedCellValue( grid_Id )
         * 현재 선택되어진 Cell의 Value를 리턴합니다.
         *
         * 선택된 Cell이나 row가 없을경우 Null 리턴
         *
         */
        getSelectedCellValue: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getFocusedCell();

            return rJson.value;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getSelectedRowlValue( grid_Id )
         * 현재 선택되어진 Cell의 Value를 리턴합니다.
         *
         * 선택된 Cell이나 row가 없을경우 Null 리턴
         *
         * return JsonType
         */
        getSelectedRowlValue: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getFocusedCell();

            return KpackageOBJ.tuiGrid.getGrid(arg[0]).getRow(arg[1], arg[2]);
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getSelectedCellName( grid_Id )
         * 현재 선택되어진 Cell의 Name을 리턴합니다.
         *
         * 선택된 Cell이나 row가 없을경우 Null 리턴
         *
         */
        getSelectedCellName: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getFocusedCell();

            return rJson.columnName;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getRowValues( grid_Id, rowKeyValue, isJsonType )
         *
         * parameter : grid_Id - <String> Grid ID
         *          rowKeyValue - <int> Target Row Index
         *          (opt) isJsonType - [boolean] default false, true시 String형태로 리턴
         *
         * 지정한 인덱스에 해당하는 Row 값을 리턴합니다.
         *
         * 선택된 Cell이나 row가 없을경우 Null 리턴
         *
         */
        getRowValues: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getRow(arg[1], arg[2]);

            return rJson;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getCheckedRows( grid_Id )
         *
         * parameter : grid_Id - <String> Grid ID
         *
         * 체크된 Row 값을 모두 리턴합니다.
         *
         * return Array[JsonType]
         *
         */
        getCheckedRows: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getCheckedRows();

            return rJson;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getCheckedRowKeys( grid_Id )
         *
         * parameter : grid_Id - <String> Grid ID
         *
         * 체크된 Row의 rowKeyValue 값을 모두 리턴합니다.
         *
         * return Array<int>
         *
         */
        getCheckedRowKeys: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getCheckedRowKeys();

            return rJson;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getCellModel( grid_Id )
         *
         * parameter : grid_Id - <String> Grid ID
         *
         * Grid에 설정된 현제 Column Model 정보를 리턴합니다.
         *
         * return Array[JsonType]
         *
         */
        getCellModel: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getColumns();

            return rJson;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getCellModel( grid_Id )
         *
         * parameter : grid_Id - <String> Grid ID
         *             column_name - <String> Target Column Name
         *
         * Grid에 설정된 현제 Column Model 정보중 해당이름을 가지는 Column Model의 Index를 반환합니다.
         *
         * return int
         *
         */
        getCellModelIndex: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var r = KpackageOBJ.tuiGrid.getGrid(arg[0]).getIndexOfColumn(arg[1]);

            return r;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getColValues( grid_Id, column_name, isJsonType )
         *
         * parameter : grid_Id - <String> Grid ID
         *          column_name - <String> Target Column Name
         *          (opt) isJsonType - [boolean] default false, true시 String형태로 리턴
         *
         * 지정한 컬럼에 대한 모든 값을 리턴합니다.
         *
         * return Array
         */
        getColValues: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid
                .getGrid(arg[0])
                .getColumnValues(arg[1], arg[2]);

            return rJson;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getModifiedRows( grid_Id )
         *
         * parameter : grid_Id - <String> Grid ID
         *
         * 추가,수정,삭제된 모든 Row를 리턴합니다.
         *
         * return Json - {createdRows: Array(n), updatedRows: Array(n), deletedRows: Array(n)}
         *
         */
        getModifiedRows: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getModifiedRows();

            return rJson;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getRowCount( grid_Id )
         *
         * parameter : grid_Id - <String> Grid ID
         *
         * Total Row Count 리턴합니다.
         *
         * return int
         *
         */
        getRowCount: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var r = KpackageOBJ.tuiGrid.getGrid(arg[0]).getRowCount();

            return r;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getRowsData( grid_Id )
         *
         * parameter : grid_Id - <String> Grid ID
         *
         * Returns a list of all rows.
         *
         * return Array - A list of all rows
         *
         */
        getRowsData: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.finishEditing(arg[0]);
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).getData();

            return rJson;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.finishEditing( grid_Id )
         * Toast Grid의 편집모드를 종료한다.
         * 편집모드가 열려있을 경우에는 변경된 값이 그리드에 적용되어 있지 않음
         * parameter : grid_Id - <String> Grid ID
         *
         * Returns void.
         *
         */
        finishEditing: function() {
            var arg = arguments;
            KpackageOBJ.tuiGrid.getGrid(arg[0]).finishEditing();
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.getCellValue( grid_Id, rowKey, columnName )
         * 현재 저장되어있는 셀의 값을 리턴
         * parameter : grid_Id - <String> Grid ID
         *             rowKey - <Number> rowKey Value
         *             columnName - <String> Column Name
         *
         * Returns the value of the cell identified by the rowKey and columnName.
         *
         * return The value of the cell
         *
         */
        getCellValue: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            if (oUtil.isNull(arg[2])) {
                return null;
            }
            var r = KpackageOBJ.tuiGrid.getGrid(arg[0]).getValue(arg[1], arg[2]);

            return r;
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.getOriginalCellValue( grid_Id, rowKey, columnName )
         * 최초 조회시(수정전) 데이터값을 리턴
         * parameter : grid_Id - <String> Grid ID
         *             rowKey - <Number> rowKey Value
         *             columnName - <String> Column Name
         *
         * Returns the original value of the cell identified by the rowKey and columnName.
         *
         * return The original value of the cell
         *
         */
        getOriginalCellValue: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            if (oUtil.isNull(arg[2])) {
                return null;
            }
            var r = KpackageOBJ.tuiGrid
                .getGrid(arg[0])
                .getValue(arg[1], arg[2], true);

            return r;
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.hideCol( grid_Id, target_colName  )
         *
         * parameter : grid_Id - <String> Grid ID
         *             target_colName - <String> hide column name
         *
         */
        hideCol: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).hideColumn(arg[1]);
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.showCol( grid_Id, target_colName  )
         *
         * parameter : grid_Id - <String> Grid ID
         *             target_colName - <String> show column name
         *
         */
        showCol: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var rJson = KpackageOBJ.tuiGrid.getGrid(arg[0]).showColumn(arg[1]);
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.isModify( grid_Id )
         * Description   : Returns true if there are at least one row modified.
         * Parameters    : grid_Id - <String> Grid ID
         *
         * Returns: boolean - True if there are at least one row modified.
         *
         */
        isModified: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var r_default_true = KpackageOBJ.tuiGrid.getGrid(arg[0]).isModified();

            return r_default_true;
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.removeRow( grid_Id, rowKey )
         * Description   : Removes the row identified by the specified rowKey.
         * Parameters    : grid_Id - <String> Grid ID
         *                 rowKey  - <Numner> Row Key
         *
         */
        removeRow: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).removeRow(arg[1], {
                removeOriginalData: true,
                keepRowSpanData: true,
            });
        },

        removeCheckedRows: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                arg[1] = true;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).removeCheckedRows(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.resetData( grid_Id, data )
         * Description   : Removes the row identified by the specified rowKey.
         * Parameters    : grid_Id - <String> Grid ID
         *                 data  - <Array> A list of new rows
         *
         */
        resetData: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                KpackageOBJ.tuiGrid.getGrid(arg[0]).resetData([]);
            } else {
                KpackageOBJ.tuiGrid.getGrid(arg[0]).resetData(arg[1]);
            }
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.restore( grid_Id )
         * Description   : Restores the data to the original data. (Original data is set by setData )
         * Parameters    : grid_Id - <String> Grid ID
         *
         */
        restore: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).restore();
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.selection( grid_Id, range )
         * Description   : Select cells or rows by range
         * Parameters    : grid_Id - <String> Grid ID
         *                 range   - <jsonObject> Selection range  :  start - <Array> Index info of start selection (ex: [rowIndex, columnIndex])
         *                                                            end   - <Array> Index info of start selection (ex: [rowIndex, columnIndex])
         *
         * ex : KpackageOBJ.tuiGrid.selection( grid_Id, {start:[2,0],end:[3,3]} );
         *
         */
        selection: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).selection(arg[1]);
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.setBodyHeight(( grid_Id, value )
         * Description   : Sets the height of body-area.
         * Parameters    : grid_Id - <String> Grid ID
         *                 value   - <Number> The number of pixel
         *
         * ex : KpackageOBJ.tuiGrid.setBodyHeight( grid_Id, 500 );
         *
         */
        setBodyHeight: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).setBodyHeight(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.setColumns( grid_Id, colModel )
         * Description   : Sets the list of column model.
         * Parameters    : grid_Id - <String> Grid ID
         *                 colModel   - <Array> A new list of column model
         *
         */
        setColumns: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).setColumns(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.setData( grid_Id, data, callbackHandler )
         * Description   : Replace all rows with the specified list. This will change the original data.
         * Parameters    : grid_Id - <String> Grid ID
         *        data : <Array> A list of new rows
         *                 callbackHandler   - <Function> The function that will be called when done.
         *
         */
        setData: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).resetData(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.setValue( grid_Id, rowKey, columnName, columnValue )
         * Description   : Sets the value of the cell identified by the specified rowKey and columnName.
         * Parameters    : grid_Id     - <String> Grid ID
         *        rowKey      - <String> The unique key of the row
         *        columnName  - <String> The name of the column
         *        columnValue - <String> The value to be set
         *
         */
        setValue: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            if (oUtil.isNull(arg[2])) {
                return null;
            }
            if (oUtil.isNull(arg[3])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).setValue(arg[1], arg[2], arg[3]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.setWidth( grid_Id, width )
         * Description   : Set the width of the dimension.
         * Parameters    : grid_Id - <String> Grid ID
         *        width : <Number> The width of the dimension
         *
         */
        setWidth: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).setWidth(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.sort( grid_Id, columnName, ascendingopt )
         * Description   : Sorts all rows by the specified column.
         * Parameters    : grid_Id      - <String> Grid ID
         *        columnName   - <String> The width of the dimension
         *                 ascendingopt - <booolean> <optional> Whether the sort order is ascending.If not specified, use the negative value of the current order.
         *
         */
        sort: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                KpackageOBJ.tuiGrid.getGrid(arg[0]).sort(arg[1], true);
            } else {
                KpackageOBJ.tuiGrid.getGrid(arg[0]).sort(arg[1], arg[2]);
            }
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.unSort( grid_Id )
         * Description   : Unsorts all rows. (Sorts by rowKey).
         * Parameters    : grid_Id      - <String> Grid ID
         *
         */
        unSort: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).unSort();
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.clear( grid_Id )
         * Description   : Removes all rows.
         * Parameters    : grid_Id      - <String> Grid ID
         *
         */
        clear: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).clear();
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.copyToClipboard( grid_Id )
         * Description   : Copy to clipboard
         * Parameters    : grid_Id      - <String> Grid ID
         *
         */
        copyToClipboard: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).copyToClipboard();
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.destroy( grid_Id )
         * Description   : Destroys the instance.
         * Parameters    : grid_Id      - <String> Grid ID
         *
         */
        destroy: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).destroy();
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.uncheck( grid_Id, rowKey )
         * Description   : Checks the row identified by the specified rowKey.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowKey  - <String> The unique key of the row
         *
         */
        check: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).check(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.uncheckAll( grid_Id)
         * Description   : Checks all rows.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowKey  - <String> The unique key of the row
         *
         */
        checkAll: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).checkAll();
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.uncheck( grid_Id, rowKey )
         * Description   : Set the width of the dimension.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowKey  - <String> The unique key of the row
         *
         */
        uncheck: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            if (oUtil.isNull(arg[1])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).uncheck(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.uncheckAll( grid_Id)
         * Description   : Set the width of the dimension.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowKey  - <String> The unique key of the row
         */
        uncheckAll: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).uncheckAll();
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.appendRow(grid_Id, rowcount, addIndex)
         * Description   : Set the width of the dimension.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowcount  - <Integer> The data for the new row
         *        addIndex - <Integer> <optional>
         */
        appendRow: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var appendTempRow = [];
            for (var i = 0;i < arg[1];i++) {
                appendTempRow.push({});
            }
            if (arg[2] != undefined && arg[1] != null) {
                KpackageOBJ.tuiGrid.getGrid(arg[0]).appendRow(appendTempRow, {
                    at: arg[2],
                });
            } else {
                KpackageOBJ.tuiGrid.getGrid(arg[0]).appendRow(appendTempRow);
            }
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.insertRow(grid_Id, rowData, addIndex)
         * Description   : 값이 들어 있는 ROW를 추가한다.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowData  - <Json> The data for the new row
         *        addIndex - <Integer> <optional>
         */
        insertRow: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            var appendTempRow = arg[1];
            if (arg[2] != undefined && arg[1] != null) {
                KpackageOBJ.tuiGrid.getGrid(arg[0]).appendRow(appendTempRow, {
                    at: arg[2],
                    extendPrevRowSpan: true,
                });
            } else {
                KpackageOBJ.tuiGrid.getGrid(arg[0]).appendRow(appendTempRow);
            }
        },

        getRowIndex: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            } // grid Id
            if (oUtil.isNull(arg[1])) {
                return null;
            } // rowKey
            return KpackageOBJ.tuiGrid.getGrid(arg[0]).getIndexOfRow(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.disableCheck(grid_Id, rowKey)
         * Description   : Disables the row identified by the spcified rowKey to not be abled to check.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowKey  - <String> The unique key of the row
         *
         */
        disableCheck: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).disableCheck(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.disableCheck(grid_Id, rowKey)
         * Description   : Disables the row identified by the rowkey.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowKey  - <String> The unique key of the row
         *
         */
        disableCheck: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).disableCheck(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.enableCheck(grid_Id, rowKey)
         * Description   : Disables the row identified by the spcified rowKey to not be abled to check.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowKey  - <String> The unique key of the row
         *
         */
        enableCheck: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).enableCheck(arg[1]);
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.enableRow(grid_Id, rowKey)
         * Description   : Disables the row identified by the rowkey.
         * Parameters    : grid_Id - <String> Grid ID
         *        rowKey  - <String> The unique key of the row
         *
         */
        enableRow: function() {
            var arg = arguments;
            if (oUtil.isNull(arg[0])) {
                return null;
            }
            KpackageOBJ.tuiGrid.getGrid(arg[0]).enableRow(arg[1]);
        },
        setButton: function(gridId, buttonObject) {
            if (gridId == "" || gridId == undefined || gridId == null) {
                return;
            }
            if (
                buttonObject == "" ||
                buttonObject == undefined ||
                buttonObject == null
            ) {
                return;
            }

            //<a class="btn btn-default DTTT_button_xls" id="ToolTables_datatable_tabletools_2"><span>Excel</span></a>
            var iconValue =
                "<div id='button_" +
                gridId +
                "' class='tui-grid-head-area' style='float:right;'><div class='tuiGrid-toobar-group btn-group'>";
            if (oUtil.isArray(buttonObject)) {
                if (buttonObject.length < 1) {
                    return;
                }
                for (var i = 0;i < buttonObject.length;i++) {
                    var text = buttonObject[i].text;
                    var func = buttonObject[i].func;
                    var icon = buttonObject[i].icon;
                    var title = buttonObject[i].title;

                    if ("none" == icon) {
                        icon = "";
                    } else if ("delete" == icon) {
                        icon = "glyphicon glyphicon-remove";
                    } else if ("insert" == icon) {
                        icon = "glyphicon glyphicon-plus";
                    } else if ("edit" == icon) {
                        icon = "glyphicon glyphicon-edit";
                    } else if ("excel" == icon) {
                        //icon = "fa fa fa-file-excel-o";
                        icon = "fa fa-file-excel-o";
                    } else if ("save" == icon) {
                        icon = "glyphicon glyphicon-floppy-save";
                    } else {
                        icon = icon;
                    }
                    iconValue +=
                        "<a class='btn grid-add-btn btn-primary btn-border tuiGrid-toolbar-button' id='" +
                        gridId +
                        text +
                        func +
                        "' href='javascript:" +
                        func +
                        '("' +
                        gridId +
                        "\")' title='" +
                        title +
                        "'><i class='" +
                        icon +
                        "'></i> <span>" +
                        text +
                        "</span></a>";
                }
                iconValue = iconValue + "</div></div>";
                $("#" + gridId)
                    .parent()
                    .prepend(iconValue);

                if ($("#caption_" + gridId).length > 0) {
                    $("#button_" + gridId).css({
                        "margin-top": "5px",
                        "margin-right": "5px",
                        "background-color": "initial",
                    });
                }
            }
        },

        /**
         * Function Name : KpackageOBJ.tuiGrid.setCaption(grid_Id, caption_text)
         * Description   : Disables the row identified by the rowkey.
         * Parameters    : grid_Id - <String> Grid ID
         *        caption_text  - <String> Caption Text contents
         *
         */
        setCaption: function() {
            var arg = arguments;
            var captionOBJ =
                '<div id="caption_' +
                arg[0] +
                '" class="tui-caption"><span><i class="fa fa-align-justify txt-color-darken"></i> </span><h2>' +
                arg[1] +
                "</h2></div>";
            $("#" + arg[0])
                .parent()
                .prepend(captionOBJ);

            if ($("#button_" + arg[0]).length > 0) {
                $("#button_" + arg[0]).css({
                    "margin-top": "5px",
                    "margin-right": "5px",
                    "background-color": "initial",
                });
            }
        },
        /**
         * ##############   2019.05.09 Function Add Patch ####################
         * Tab 안의 Toast Grid를 생성할 경우 display None일때
         * 사이즈가 불량한 Toast Grid를 생성할경우 이를 Refresh하는 Fucntion
         * ###################################################################
         */
        reSizingGrid: function() {
            var arg = arguments;

            try {
                var tgt;
                if (
                    KpackageOBJ.prototype.regexp_notPaging.test(
                        $("#" + arg[0]).attr("id")
                    )
                ) {
                    tgt = KpackageOBJ.tuiGrid.getGrid($("#" + arg[0]).attr("id"));
                    if (tgt != null && $("#" + arg[0]).data("fixedHeight") == undefined) {
                        tgt.setBodyHeight(
                            $(window).height() - $("#" + arg[0]).data("minusHeight") ||
                            $(window).height() - KpackageOBJ.prototype.minusHeight
                        );
                    } else if (
                        tgt != null &&
                        $("#" + arg[0]).data("fixedHeight") != undefined
                    ) {
                        tgt.setBodyHeight($("#" + arg[0]).data("fixedHeight"));
                    }
                }
                tgt.refreshLayout();
            } catch (e) {}
        },
        /**
         * Function Name : KpackageOBJ.tuiGrid.validation(grid_Id)
         * Description   : Grid data validation check.
         * Parameters    : grid_Id - <String> Grid ID
         *
         */
        validation: function() {
            var arg = arguments;

            var errArr = KpackageOBJ.tuiGrid.getGrid(arg[0]).validate();
            var colArr = KpackageOBJ.tuiGrid.getGrid(arg[0]).getColumns();
            var errMsg = "";

            if (errArr.length > 0) {
                if (errArr[0].errors[0].errorCode == "REQUIRED") {
                    errMsg = "필수입력";
                } else {
                    errMsg = errArr[0].errors[0].errorCode;
                }

                for (var i = 0;i < colArr.length;i++) {
                    if (colArr[i].name == errArr[0].errors[0].columnName) {
                        errMsg =
                            KpackageOBJ.tuiGrid
                                .getGrid(arg[0])
                                .getIndexOfRow(errArr[0].rowKey) +
                            1 +
                            "행 " +
                            colArr[i].title +
                            "은(는) " +
                            errMsg +
                            " 항목입니다.";

                        return errMsg;
                    }
                }
            }

            return errMsg;
        },
        /**
         * since : 2022.06.21
         * Function Name : KpackageOBJ.tuiGrid.exportCsv(grid_Id)
         * Description   : Export data in CSV format ( Toast v4.19 Later )
         * Parameters    : grid_Id - <String> Grid ID
         *
         */
        exportCsv: function() {
            var arg = arguments;
            KpackageOBJ.tuiGrid.getGrid(arg[0]).export("csv");
        },

        exportXlsx: function() {
            var arg = arguments;
            KpackageOBJ.tuiGrid.getGrid(arg[0]).export("xlsx");
        },
    },
    /************************************************ */
    /************************************************ */
    /************************************************ */
    /************************************************ */
    /************************************************ */
    /************************************************ */
    /************************************************ */
    /************************************************ */

    "auiGrid": {
		"gridProps": {
			// select UI 에 출력 시킬 옵션값들 (기본값 : [10, 20, 30, 40, 50])
			pageRowSelectValues : [50, 100, 150, 200, 250],
            // 편집 가능 여부 (기본값 : false)
            editable: false,
            // 셀 병합 실행
            enableCellMerge: true,
            // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
            enterKeyColumnBase: true,
            // 셀 선택모드 (기본값: singleCell)
            selectionMode: "multipleCells",
            // 컨텍스트 메뉴 사용 여부 (기본값 : false)
            useContextMenu: false,
            // 필터 사용 여부 (기본값 : false)
            enableFilter: false,
            // 그룹핑 패널 사용
            useGroupingPanel: false,
            // 상태 칼럼 사용
            showStateColumn: true,
            // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
            displayTreeOpen: true,
            noDataMessage: "출력할 데이터가 없습니다.",
            groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
            headerHeight: 39,
            rowHeight: 39
        },
        "create": function(p_AuiGridId, p_ColumnLayout, p_GridProps, p_GridType) {
            //기존에 해당 그리드가 생성된적이 있다면 삭제 
            KpackageOBJ.auiGrid.remove(p_AuiGridId);

            // 기본 레이아웃 생성
            var defaultGridProps = KpackageOBJ.auiGrid.gridProps;

            // 사용자 정의 레이아웃으로 객체 병합
            var final_GridProps = Object.assign({}, defaultGridProps, p_GridProps);


            // 그리드 타입 설정  Rownumber, checkBox, Radio Style
            if (p_GridType == null || String(p_GridType).trim() === "") {
                final_GridProps["showRowCheckColumn"] = false;
                final_GridProps["rowCheckToRadio"] = false;
                final_GridProps["showRowNumColumn"] = false;

            } else if (String(p_GridType).trim() === "number") {

                final_GridProps["showRowCheckColumn"] = false;
                final_GridProps["rowCheckToRadio"] = false;

                final_GridProps["showRowNumColumn"] = true;
                final_GridProps["rowNumColumnWidth"] = 55;
                final_GridProps["rowNumHeaderText"] = "#";

            } else if (String(p_GridType).trim() === "check") {
                final_GridProps["showRowNumColumn"] = false;
                final_GridProps["rowCheckToRadio"] = false;
                final_GridProps["showRowCheckColumn"] = true;

            } else if (String(p_GridType).trim() === "radio") {
                final_GridProps["showRowNumColumn"] = false;
                final_GridProps["showRowCheckColumn"] = true;
                final_GridProps["rowCheckToRadio"] = true;
            }
            //그리드 생성 및 객체 리턴
            return AUIGrid.create("#" + p_AuiGridId, p_ColumnLayout, final_GridProps);


        },  
        
                
        /**
		 * 엑스트라 행 체크박스가 설정된 경우행 고유 값(rowIdField 값)을 이용해 특정 행에 체크를 설정합니다.
		 *
  	     * 파라메터 설명
		 * - p_rowIds : (Array) 행 고유 값(rowIdField 값)들을 요소로 갖는 배열
		 * 
		 */ 
		"addCheckedRowsByIds" : function(p_TargetGridId, p_rowIds ) {
	   		AUIGrid.addCheckedRowsByIds(p_TargetGridId, p_rowIds );
		},
        
        /**
		 *엑스트라 행 체크박스가 설정된 경우 특정 행의 dataField 의 값과 일치하는 행에 체크를 표시합니다.
		 *
  	     * 파라메터 설명
		 * - p_dataField : (String) 행 아이템에서 체크하고자 하는 필드명
		 * - p_values : (Array or String) 행 아이템에서 체크하고자 하는 필드의 값(value), 복수의 값을 체크하고자 한다면 배열로 설정(예: ["Anna", "Steve"])
		 * 
		 */ 
		"addCheckedRowsByValue" : function(p_TargetGridId, p_dataField, p_values) {
	   		AUIGrid.addCheckedRowsByValue(p_TargetGridId, p_dataField, p_values);
		},
		
        /**
		 *엑스트라 행 체크박스가 설정된 경우 특정 행의 dataField 의 값과 일치하는 행에 체크를 표시합니다.
		 *
  	     * 파라메터 설명
		 * - p_cItem (Object or Array) : 삽입하고자 하는 열 객체(columnm Object), 복수의 열을 삽입하고자 하는 경우 Object 를 배열로 묶으십시오.
		 * - p_columnIndex (Number or String) : 삽입될 열의 인덱스, columnIndex 에 다음 문자를 설정한 경우
		 *               => "first" : 맨처음, "last" : 맨끝, "selectionLeft" : 선택 열 왼쪽에, "selectionRight" : 선택 열 오른쪽에 추가 열이 삽입됩니다.
		 * 
		 */ 
		"addColumn" : function(p_TargetGridId, p_cItem , p_columnIndex = "last" ) {
	   		AUIGrid.addColumn(p_TargetGridId, p_cItem , p_columnIndex );
		},        
        
        /**
		 * 그리드 행(row) 아이템을 추가, 삽입합니다.
		 *
  	     * 파라메터 설명
		 * - p_items (Object or Array) : 삽입하고자 하는 행 아이템, 복수의 행을 삽입하고자 하는 경우 Object 를 배열로 묶으십시오.
		 * - p_rowIndex (Number or String) : 삽입될 행의 인덱스, rowIndex 에 다음 문자를 설정한 경우
		 *            => "first" : 첫 행, "last" : 최하단, "selectionUp" : 선택행 위, "selectionDown" : 선택행 아래에 추가행이 삽입됩니다.
         * 			  => 기본값 last 	
         */
        "addRow": function(p_TargetGridId, p_items, p_rowIndex = "last") {
            AUIGrid.addRow(p_TargetGridId, p_items, p_rowIndex);
        },

	    /**
		 * 그리드에서 특정 열(column)의 자식으로 열을 추가, 삽입합니다.
		 *
  	     * 파라메터 설명
		 * - cItem (Object or Array) : 삽입하고자 하는 열 객체(columnm Object), 복수의 열을 삽입하고자 하는 경우 Object 를 배열로 묶으십시오.
		 * - p_parentDataField (String) : 부모 dataField 명, 해당 dataField 의 자식으로 칼럼이 추가됩니다.
		 * - p_columnIndex (Number or String) : 삽입될 열의 인덱스, columnIndex 에 다음 문자를 설정한 경우. "first" : 맨처음, "last" : 맨끝에 추가 열이 삽입됩니다.
		 * 
         */
        "addTreeColumn": function(p_TargetGridId, p_cItem, p_parentDataField, p_columnIndex = "last") {
            AUIGrid.addTreeColumn(p_TargetGridId, p_cItem, p_parentDataField, p_columnIndex);
        },

	    /**
		 * 트리 그리드 행(row) 아이템을 추가, 삽입합니다.
		 *
  	     * 파라메터 설명
		 * - p_items (Object or Array) : 삽입하고자 하는 행 아이템, 복수의 행을 삽입하고자 하는 경우 Object 를 배열로 묶으십시오.
		 * - p_parentRowId (String) : 추가될 행의 부모 행 고유 값(rowIdField 값).
		 * - p_rowPosition (String) : 삽입될 행의 위치 값, 유효값은 다음과 같습니다
		 *                          => "first" : 첫 행, "last" : 최하단, "selectionUp" : 선택행 위, "selectionDown" : 선택행 아래에 추가행이 삽입됩니다.
		 * 
         */
        "addTreeRow": function(p_TargetGridId, p_items, p_parentRowId, p_rowPosition = "last") {
            AUIGrid.addTreeRow(p_TargetGridId, p_items, p_parentRowId, p_rowPosition);
        },
        
	    /**
		 * 트리 그리드 행(row) 아이템을 특정 행 위치(rowIndex)에 추가, 삽입합니다.
		 *
  	     * 파라메터 설명
		 * - p_items (Object or Array) : 삽입하고자 하는 행 아이템, 복수의 행을 삽입하고자 하는 경우 Object 를 배열로 묶으십시오.
		 * - p_rowIndex (Number) : 추가될 행이 위치할 행 인덱스(rowIndex)
		 * 
         */
        "addTreeRowByIndex": function(p_TargetGridId, p_items, p_rowIndex ) {
            AUIGrid.addTreeRowByIndex(p_TargetGridId, p_items, p_rowIndex);
        },        
        
	    /**
		 * 스트라 행 체크박스가 설정된 경우 행 고유 값(rowIdField 값)을 이용해 특정 행에 체크 해제를 설정합니다.
		 *
  	     * 파라메터 설명
		 * - p_rowIds : (Array) 행 고유 값(rowIdField 값)들을 요소로 갖는 배열
		 * 
         */
        "addUncheckedRowsByIds": function(p_TargetGridId, p_rowIds) {
            AUIGrid.addUncheckedRowsByIds(p_TargetGridId, p_rowIds);
        },        
       
	    /**
		 * 엑스트라 행 체크박스가 설정된 경우 특정 행의 dataField 의 값과 일치하는 행에 체크 해제를 설정합니다.
		 *
  	     * 파라메터 설명
		 * - p_dataField : (String) 행 아이템에서 체크 해제 하고자 하는 필드명
		 * - p_values : (Array or String) 행 아이템에서 체크 해제 하고자 하는 필드의 값(value), 복수의 값을 체크하고자 한다면 배열로 설정(예: ["Anna", "Steve"])
		 * 
         */
        "addUncheckedRowsByValue": function(p_TargetGridId, p_dataField, p_values ) {
            AUIGrid.addUncheckedRowsByValue(p_TargetGridId, p_dataField, p_values);
        },                        
        
	    /**
		 * 기존 그리드 데이터의 하단(뒤쪽)에 추가로 데이터를 붙입니다.
		 *
  	     * 파라메터 설명
		 * - p_additionalData (Array) : 추가시키고자 하는 데이터
		 * 
         */
        "appendData": function(p_TargetGridId, p_additionalData) {
            AUIGrid.appendData(p_TargetGridId, p_additionalData);
        },             
        
        
	    /**
		 * 그리드 이벤트를 핸들링하기 위해 이벤트를 바인딩하는 메소드입니다.
		 *
  	     * 파라메터 설명
		 * - p_type : (String or Array) 바인딩하고자 하는 이벤트 유형
		 * - p_function : (Function) 이벤트 핸들러 함수
		 * 
         */
        "bind": function(p_TargetGridId, p_type, p_function ) {
            AUIGrid.bind(p_TargetGridId, p_type, p_function);
        },                        
        
	    /**
		 * 그리드의 칼럼 레이아웃(columnLayout) 을 변경합니다.
		 *
  	     * 파라메터 설명
		 * - p_columnLayout : (Array-Object) 변경하고자 하는 새로운 칼럼 레이아웃
		 * 
         */
        "changeColumnLayout ": function(p_TargetGridId, p_columnLayout) {
            AUIGrid.changeColumnLayout (p_TargetGridId, p_columnLayout);
        },           
        
		/**
		 * 엑스트라 칼럼인 행 드래그&드랍 손잡이(showDragKnobColumn), 행 번호(showRowNumColumn), 행 상태(showStateColumn), 행 체크박스(showRowCheckColumn)의 순서를 변경합니다.
		 * 
  	     * 파라메터 설명
		 * - p_orders (Array) : 엑스트라 칼럼 속성명을 순서로 지정한 배열
		 * 
         */
        "changeExtraColumnOrders ": function(p_TargetGridId, p_orders) {
            AUIGrid.changeExtraColumnOrders (p_TargetGridId, p_orders);
        },      
        
		/**
		 * 엑스트라 칼럼인 행 드래그&드랍 손잡이(showDragKnobColumn), 행 번호(showRowNumColumn), 행 상태(showStateColumn), 행 체크박스(showRowCheckColumn)의 너비(width)를 변경합니다.
		 * 
  	     * 파라메터 설명
		 * - p_name (String) : 엑스트라 칼럼 너비 속성 이름
		 * - p_width (Number) : 변경 시킬 너비
		 * 
         */
        "changeExtraColumnWidth ": function(p_TargetGridId, p_name, p_width) {
            AUIGrid.changeExtraColumnWidth (p_TargetGridId, p_name, p_width);
        },      
        
		/**
		 * 그리드의 푸터 레이아웃(footerLayout) 을 변경합니다.
		 * 
  	     * 파라메터 설명
		 * - p_footerLayout : (Array-Object) 변경하고자 하는 새로운 푸터 레이아웃
		 * 
         */
        "changeFooterLayout ": function(p_TargetGridId, p_footerLayout) {
            AUIGrid.changeFooterLayout (p_TargetGridId, p_footerLayout);
        },           
               
		/**
		 * 필터링이 설정되어 있다면 해당 칼럼의 필터링을 해제합니다.
		 * 
  	     * 파라메터 설명
		 * - p_dataField (String) : 칼럼이 출력하고 있는 데이터의 필드명
		 * 
         */
        "clearFilter ": function(p_TargetGridId, p_dataField) {
            AUIGrid.clearFilter (p_TargetGridId, p_dataField);
        },                   
        
		/**
		 * 모든 필터링을 해제합니다.
		 * 
         */
        "clearFilterAll ": function(p_TargetGridId) {
            AUIGrid.clearFilterAll (p_TargetGridId);
        },
        
		/**
		 * 그리드 데이터를 모두 초기화하여 빈 그리드로 만듭니다.
		 * Auigrid 데이터 조회
		 * 
		 */ 
        "clearGridData" : function(p_TargetGridId) {
	   		AUIGrid.clearGridData(p_TargetGridId);
		},                   
         
		/**
		 * 선택되어진 모든 아이템들을 초기화합니다.
		 * 
         */
        "clearSelection ": function(p_TargetGridId) {
            AUIGrid.clearSelection (p_TargetGridId);
        },            
        
		/**
		 * 정렬(Sorting)이 설정되어 있다면 모든 정렬을 초기화 합니다.
		 * 
         */
        "clearSortingAll ": function(p_TargetGridId) {
            AUIGrid.clearSortingAll (p_TargetGridId);
        },                      
        
		/**
		 * 실행 취소(Undo), 다시 실행(Redo) 커맨드 스택을 초기화 합니다.
		 * 
         */
        "clearUndoRedoStack ": function(p_TargetGridId) {
            AUIGrid.clearUndoRedoStack (p_TargetGridId);
        },                      
                
        
		/**
		 * 그리드 필터를 설정한 경우, 필터 레이어(필터 메뉴)가 오픈되어 있을 때 닫도록 지시합니다.
		 * 
         */
        "closeFilterLayer ": function(p_TargetGridId) {
            AUIGrid.closeFilterLayer (p_TargetGridId);
        },                      
                        
		/**
		 * 계층 구조 데이터 표현(트리 데이터)인 경우 모든 노드들을 닫고 최상위 Branch 만 표시합니다.
         */
        "collapseAll ": function(p_TargetGridId) {
            AUIGrid.collapseAll (p_TargetGridId);
        },              
        
                     
		/**
		 * 작성된 그리드를 완전히 제거합니다.
         */
        "destroy": function(p_TargetGridId) {
            AUIGrid.destroy(p_TargetGridId);
        },

		/**
		 * 계층 구조 데이터 표현인 경우 모든 노드들을 열어 전체 펼치기를 실행합니다.
         */
        "expandAll": function(p_TargetGridId) {
            AUIGrid.expandAll(p_TargetGridId);
        },


		/**
		 * 계층형 그리드(트리 그리드)인 경우 행 고유 값(rowIdField 값)에 맞는 아이템이 브랜치(branch)일 때 열기/닫기를 실행합니다.
		 * 
  	     * 파라메터 설명
		 * - p_rowIds (Array 또는 String) : 행 고유 값(rowIdField 값) (복수인 경우 Array 로 지정)
		 * - p_open (Boolean) : 열기 할지 닫기 할지 여부(true 인 경우 열기 실행)
		 * - p_recursive (Boolean) : 해당 아이템의 자손까지 모두 열지 여부
		 * 
         */
        "expandItemByRowId ": function(p_TargetGridId, p_rowIds, p_open, p_recursive) {
            AUIGrid.expandItemByRowId (p_TargetGridId, p_rowIds, p_open, p_recursive);
        },      
        
              
		/**
		 * 그리드에 출력된 현재 데이터를 다운로드 가능한 CSV 형태로 내보내기 합니다.
		 * 
  	     * 파라메터 설명
		 * - p_exportProps (Object) : 내보내기 할 때 파일명 등을 지정할 수 있는 파라메터입니다.
		 *     						=>  afterRequestCallback (Function) : 내보내기 후 호출될 콜백함수를 지정합니다.
		 *     						=>	alwaysQuotes (Boolean) : 쌍따옴표를 모든 값에 붙일지 여부를 지정합니다. 값에 컴마가 있는지 확인하여 붙이는 경우(이 속성 false 설정한 경우) 퍼포먼스가 낮을 수 있습니다.
		 *     						=>	beforeRequestCallback (Function) : 내보내기 전 호출될 콜백함수를 지정합니다.
		 *     						=>	fileName (String) : 내보내기 할 때 파일명을 지정하면 해당 파일명을 서버 사이드에서 파라메터로 받을 수 있습니다.
		 *     						=>	localControl(Boolean) : 다운로딩 처리가 아닌 데이터를 Blob 으로 반환할지 여부를 지정합니다.(기본값 : false)
		 *     						=>	localControlFunc(Function) : localControl 를 true 설정한 경우 그리드가 CSV 서식 작성 완료 후 Blob 으로 반환하는 함수입니다.
		 *     						=>	localAsText (Boolean) : localControl 를 true 설정한 경우 localControlFunc 의 파라메터를 Blob 대신 String 으로 대체할지 여부를 지정합니다.(기본값 : false)
		 *     						=>	progressBar (Boolean) : 내보내기 진행 상황을 퍼센티지로 보여줄지 여부를 나타냅니다.(기본값 : false)
		 * 
         */
        "exportToCsv ": function(p_TargetGridId, p_exportProps ) {
            AUIGrid.exportToCsv (p_TargetGridId, p_exportProps );
        },                   
        
		/**
		 * 그리드에 출력된 현재 데이터를 다운로드 가능한 JSON 형태로 내보내기 합니다.
		 * 
  	     * 파라메터 설명
		 * p_exportProps (Object) : 내보내기 할 때 파일명 등을 지정할 수 있는 파라메터입니다.
		 *     						=>  afterRequestCallback (Function) : 내보내기 후 호출될 콜백함수를 지정합니다.
		 *     						=>	beforeRequestCallback (Function) : 내보내기 전 호출될 콜백함수를 지정합니다.
		 *     						=>	fileName (String) : 내보내기 할 때 파일명을 지정하면 해당 파일명을 서버 사이드에서 파라메터로 받을 수 있습니다.
		 *     						=>	keyValueMode (Boolean) : 내보내기 할 때 Row 데이터를 칼럼 인덱스에 맞는 배열로 할 지 key-value 로 짝을 갖는 Object 요소 배열로 할지 여부를 나타냅니다.
		 *     						=>	localControl(Boolean) : 다운로딩 처리가 아닌 데이터를 Blob 으로 반환할지 여부를 지정합니다.(기본값 : false)
		 *     						=>	localControlFunc(Function) : localControl 를 true 설정한 경우 그리드가 CSV 서식 작성 완료 후 Blob 으로 반환하는 함수입니다.
		 *     						=>	localAsText (Boolean) : localControl 를 true 설정한 경우 localControlFunc 의 파라메터를 Blob 대신 String 으로 대체할지 여부를 지정합니다.(기본값 : false)
		 * 
         */
        "exportToJson ": function(p_TargetGridId, p_exportProps ) {
            AUIGrid.exportToJson (p_TargetGridId, p_exportProps );
        },                         
        
        
		/**
		 * 그리드에 출력된 현재 데이터를 자바스크립트 Array-Object 로 내보내기 합니다.
		 * 
  	     * 파라메터 설명
		 * - p_keyValueMode (Boolean) : 내보내기 할 때 Row 데이터를 칼럼 인덱스에 맞는 배열로 할 지 key-value 로 짝을 갖는 Object 요소 배열로 할지 여부를 나타냅니다.
		 * 
		 * Return : (Array) 그리드의 Array-Object 데이터
         */
        "exportToObject ": function(p_TargetGridId, p_keyValueMode ) {
            return AUIGrid.exportToObject (p_TargetGridId, p_keyValueMode );
        },          


		/**
		 * 그리드에 출력된 현재 데이터를 다운로드 가능한 PDF 로 내보내기 합니다.
		 * 
  	     * 파라메터 설명
		 * - p_exportProps (Object) : PDF로 내보내기 할 때 파일명, 상단, 하단 추가 텍스트를 지정할 수 있는 파라메터입니다.
		 *  			 => afterRequestCallback (Function) : 내보내기 후 호출될 콜백함수를 지정합니다.
		 *  			 => beforeRequestCallback (Function) : 내보내기 전 호출될 콜백함수를 지정합니다.
		 *  			 => fontPath (String) : PDF 파일 작성 시 사용할 글꼴(Font) URL 경로입니다.(필수)
		 *  			 => compress (Boolean) : PDF 파일 작성 시 압축을 할 지 여부를 지정합니다.(기본값: false)
		 *  			 => fileName (String) : PDF로 내보내기 할 때 파일명을 지정하면 해당 파일명을 서버 사이드에서 파라메터로 받을 수 있습니다.
		 *  			 => isRowStyleFront(Boolean) : 행에 적용된 스타일이 열에 적용된 스타일 보다 상위에 적용될지 여부를 지정합니다.(기본값 : true)
		 *  			 => localControl(Boolean) : 다운로딩 처리가 아닌 데이터를 Blob 으로 반환할지 여부를 지정합니다.(기본값 : false)
		 *  			 => localControlFunc(Function) : localControl 를 true 설정한 경우 그리드가 PDF 서식 작성 완료 후 Blob 으로 반환하는 함수입니다.
		 *  			 => headers (Array) : 그리드 상단에 표시할 추가 행들을 지정합니다. 제목이나 부제목과 같은 내용이 될 수 있습니다.
		 *  			 => footers (Array) : 그리드 하단에 표시할 추가 행들을 지정합니다.
		 *  			 => text (String) : PDF에 표시할 텍스트입니다.
		 *  			 => height (Number) : PDF에서 행의 높이를 지정합니다.(px 단위, 실제 PDF는 pt 입니다. 그리드가 px 를 pt 로 변환하므로 px 단위로 지정하십시오.)
		 *  			 => style (Object) : 행의 스타일을 지정합니다. (유효값 : fontSize, textAlign, underline, background, color)
		 * 
         */
        "exportToPdf ": function(p_TargetGridId, p_exportProps ) {
            AUIGrid.exportToPdf (p_TargetGridId, p_exportProps );
        },                         
        
		/**
		 * 그리드에 출력된 현재 데이터를 다운로드 가능한 TXT 형태로 내보내기 합니다.
		 * 
  	     * 파라메터 설명
		 * - p_exportProps (Object) : PDF로 내보내기 할 때 파일명, 상단, 하단 추가 텍스트를 지정할 수 있는 파라메터입니다.
		 *  			 => afterRequestCallback (Function) : 내보내기 후 호출될 콜백함수를 지정합니다.
		 *  			 => beforeRequestCallback (Function) : 내보내기 전 호출될 콜백함수를 지정합니다.
		 *  			 => fileName (String) : 내보내기 할 때 파일명을 지정하면 해당 파일명을 서버 사이드에서 파라메터로 받을 수 있습니다.
		 *  			 => localControl(Boolean) : 다운로딩 처리가 아닌 데이터를 Blob 으로 반환할지 여부를 지정합니다.(기본값 : false)
		 *  			 => localControlFunc(Function) : localControl 를 true 설정한 경우 그리드가 TXT 서식 작성 완료 후 Blob 으로 반환하는 함수입니다.
		 *  			 => localAsText (Boolean) : localControl 를 true 설정한 경우 localControlFunc 의 파라메터를 Blob 대신 String 으로 대체할지 여부를 지정합니다.(기본값 : false)
		 *  			 => progressBar (Boolean) : 내보내기 진행 상황을 퍼센티지로 보여줄지 여부를 나타냅니다.(기본값 : false)
		 * 
         */
        "exportToTxt ": function(p_TargetGridId, p_exportProps ) {
            AUIGrid.exportToTxt (p_TargetGridId, p_exportProps );
        },           

		/**
		 * 그리드에 출력된 현재 데이터를 다운로드 가능한 엑셀(xlsx) 로 내보내기 합니다.
		 * 
  	     * 파라메터 설명
		 * - p_exportProps (Object) : PDF로 내보내기 할 때 파일명, 상단, 하단 추가 텍스트를 지정할 수 있는 파라메터입니다.
		 *  			 => API 문서 참고.. 너무 많음
		 * 
         */
        "exportToXlsx ": function(p_TargetGridId, p_exportProps ) {
            AUIGrid.exportToXlsx (p_TargetGridId, p_exportProps );
        },     

		/**
		 * 다수의 그리드에 출력된 현재 데이터를 1개의 엑셀(xlsx) 파일에 각각의 엑셀 시트(Sheets)로 내보내기 합니다.
		 * 
  	     * 파라메터 설명
		 * -p_subGridIds (Array) : 시트(Sheets)에 각각 같이 내보내기 할 서브 그리드들의 pid 배열
		 * -p_exportProps (Array) : 각각 그리드들의 내보내기 속성 정의 배열
		 *  			 => exceptColumnFields (Array) : 엑셀로 저장 할 때 포함 시키지 않을 칼럼들의 dataField 를 지정합니다.
		 *  			 => exportWithStyle (Boolean) : 엑셀로 내보내기 할 때 스타일 정보(폰트 및 컬러 등)을 함께 내보내기 할지 여부를 나타냅니다.
		 *  			 => isRowStyleFront(Boolean) : 행에 적용된 스타일이 열에 적용된 스타일 보다 상위에 적용될지 여부를 지정합니다.(기본값 : true)
		 *  			 => sheetName (String) : 엑셀로 내보내기 할 때 엑셀의 시트명을 지정합니다. (기본값 : Sheet 1)
		 *  			 => fixedColumnCount (Number) : 엑셀로 내보내기 할 때 엑셀 상의 틀고정 열(column)을 임의로 지정합니다.
		 *  			 => fixedRowCount (Number) : 엑셀로 내보내기 할 때 엑셀 상의 틀고정 행(row)을 임의로 지정합니다.
		 *  			 => headers (Array) : 그리드 상단에 표시할 추가 행들을 지정합니다. 제목이나 부제목과 같은 내용이 될 수 있습니다.
		 *  			 => footers (Array) : 그리드 하단에 표시할 추가 행들을 지정합니다.
         */
        "exportToXlsxMulti ": function(p_TargetGridId, p_subGridIds, p_exportProps ) {
            AUIGrid.exportToXlsxMulti (p_TargetGridId, p_subGridIds, p_exportProps );
        },     


		/**
		 * 그리드에 출력된 현재 데이터를 다운로드 가능한 XML 형태로 내보내기 합니다.
		 * 
  	     * 파라메터 설명
		 * - p_exportProps (Array) : 각각 그리드들의 내보내기 속성 정의 배열
		 *  			 => afterRequestCallback (Function) : 내보내기 후 호출될 콜백함수를 지정합니다.
		 *  			 => beforeRequestCallback (Function) : 내보내기 전 호출될 콜백함수를 지정합니다.
		 *  			 => fileName (String) : 내보내기 할 때 파일명을 지정하면 해당 파일명을 서버 사이드에서 파라메터로 받을 수 있습니다.
		 *  			 => localControl(Boolean) : 다운로딩 처리가 아닌 데이터를 Blob 으로 반환할지 여부를 지정합니다.(기본값 : false)
		 *  			 => localControlFunc(Function) : localControl 를 true 설정한 경우 그리드가 XML 서식 작성 완료 후 Blob 으로 반환하는 함수입니다.
		 *  			 => localAsText (Boolean) : localControl 를 true 설정한 경우 localControlFunc 의 파라메터를 Blob 대신 String 으로 대체할지 여부를 지정합니다.(기본값 : false)
         */
        "exportToXml ": function(p_TargetGridId, p_exportProps ) {
            AUIGrid.exportToXml (p_TargetGridId, p_exportProps );
        },     


		/**
		 * 편집모드(editable=true)인 경우 해당 input 의 값을 강제적으로 편집 완료 또는 취소 상태로 만듭니다.
		 * 
  	     * 파라메터 설명
		 * - p_value (Object) : 설정하고자 하는 값
		 * - p_cancel (Boolean) : 이 값이 true 라면 에디팅 취소(cancel) 가 적용됩니다.
		 * 
         */
        "forceEditingComplete ": function(p_TargetGridId, p_value, p_cancel ) {
            AUIGrid.forceEditingComplete (p_TargetGridId, p_value, p_cancel );
        },         

		/**
		 * 그리드에서 추가된 열(column) 의 dataField 들의 묶음(배열)을 반환합니다.
		 * 
		 * Return : (Array) 추가된 열의 dataField 들
         */
        "getAddedColumnFields ": function(p_TargetGridId) {
            return AUIGrid.getAddedColumnFields (p_TargetGridId);
        },         

		/**
		 * 그리드에서 추가된 아이템들의 묶음(배열)을 반환합니다.
		 * 
		 * Return : (Array) 추가된 행 아이템들
         */
        "getAddedRowItems ": function(p_TargetGridId) {
            return AUIGrid.getAddedRowItems (p_TargetGridId);
        },         

		/**
		 * 트리 그리드(계층형 그리드)에서 행 고유 값(rowIdField 값)에 해당되는 모든 조상(ascendants) 행 아이템을 찾아 배열로 반환합니다.
		 * 
  	     * 파라메터 설명
		 * - p_rowId : (String) 행 고유 값(rowIdField 값)
		 * 
		 * Return : (Array) 주어진 행 고유 값(rowIdField 값)에 따른 모든 조상 행 아이템들
         */
        "getAscendantsByRowId ": function(p_TargetGridId, p_rowId ) {
            return AUIGrid.getAscendantsByRowId (p_TargetGridId, p_rowId );
        },         

		/**
		 * 그리드의 특정 셀의 포매팅된 값을 반환합니다.
		 * 
  	     * 파라메터 설명
		 * - p_rowIndex (Number) : 얻고자하는 행 인덱스
		 * - p_col : dataField or columnIndex(String or Number) - 얻고자 하는 칼럼의 dataField 또는 칼럼 인덱스
		 * 
		 * Return : 선택 셀 포매팅된 값
		 */
        "getCellFormatValue ": function(p_TargetGridId, p_rowIndex, p_col ) {
            return AUIGrid.getCellFormatValue (p_TargetGridId, p_rowIndex, p_col );
        },    

        /**
         * 그리드의 특정 셀의 값을 반환합니다.
         * 파라메터 설명
         *   - p_rowIndex (Number) : 얻고자하는 행 인덱스
         *   - p_col : dataField or columnIndex(String or Number) 얻고자 하는 칼럼의 dataField 또는 칼럼 인덱스
         * 
         * Return : 선택 셀 값
         */
        "getCellValue": function(p_TargetGridId, p_rowIndex, p_col) {
            return AUIGrid.getCellValue(p_TargetGridId, p_rowIndex, p_col);
        },
        
        /**
         * 엑스트라 행 체크박스가 설정된 경우 체크박스로 체크된 모든 행의 아이템과 행인덱스를 갖는 배열을 반환 합니다.
         * 
         * Return : (Array) 체크된 행 아이템 및 행 인덱스 배열
         */
        "getCheckedRowItems": function(p_TargetGridId) {
            return AUIGrid.getCheckedRowItems(p_TargetGridId);
        },

        /**
         * 엑스트라 행 체크박스가 설정된 경우 체크박스로 체크된 모든 행의 아이템을 반환합니다.
		 * 
         * Return : (Array) 체크된 행 아이템 배열
         */
        "getCheckedRowItemsAll": function(p_TargetGridId) {
            return AUIGrid.getCheckedRowItemsAll(p_TargetGridId);
        },
        
		/**
         * 현재 그리드에서 출력하고 있는 전체 열(columns)의 개수를 반환합니다.
		 * 
         * Return : (Number) 전체 열(columns) 수
         */
        "getColumnCount": function(p_TargetGridId) {
            return AUIGrid.getColumnCount(p_TargetGridId);
        },

		/**
         * 그리드의 칼럼이 출력하는 모든 값들을 반환하되 중복된 값을 제거하고 반환합니다.         
		 * 파라메터 설명
         *   - p_dataField : (String) 칼럼의 dataField 명
         *   - p_total : (Boolean) 그리드의 원래 데이터를 대상으로 할지 여부. 즉, 필터링이 된 경우 필터링 된 상태의 값만 원한다면 false 지정
         *
         * Return : (Array) 해당 칼럼이 출력하고 있는 모든 값들(중복된 값이 제거된 고유 값들만 반환)
         */
        "getColumnDistinctValues": function(p_TargetGridId, p_dataField, p_total) {
            return AUIGrid.getColumnDistinctValues(p_TargetGridId, p_dataField, p_total);
        },

		/**
         * 이터 필드에 맞는 현재 그리드의 칼럼인덱스를 반환합니다.
		 * 파라메터 설명
         *   - p_dataField : (String) 데이터 필드명
         *
         * Return : (Number) 칼럼인덱스
         */
        "getColumnIndexByDataField": function(p_TargetGridId, p_dataField) {
            return AUIGrid.getColumnIndexByDataField(p_TargetGridId, p_dataField);
        },

		/**
         * 그리드에 출력된 칼럼 정보를 갖는 1차원 배열을 반환합니다.
		 * Return : (Array) 현재 그리드 칼럼 레이아웃
         */
        "getColumnInfoList": function(p_TargetGridId) {
            return AUIGrid.getColumnInfoList(p_TargetGridId);
        },

		/**
         * 데이터 필드(dataField)에 맞는 칼럼 레이아웃의 칼럼 객체를 반환합니다.
		 * 파라메터 설명
         *   - p_dataField : (String) 컬럼이 출력하고 있는 데이터필드명
         *
         * return : (Object) 칼럼 레이아웃의 칼럼 객체
         */
        "getColumnItemByDataField": function(p_TargetGridId, p_dataField) {
            return AUIGrid.getColumnItemByDataField(p_TargetGridId, p_dataField);
        },

		/**
         * 열 인덱스(columnIndex)에 맞는 칼럼 레이아웃의 칼럼 객체를 반환합니다.
		 * 파라메터 설명
         *   -p_columnIndex : (Number) 컬럼이 출력되고 있는 인덱스
         *
         *Return : (Object) 칼럼 레이아웃의 칼럼 객체
         */
        "getColumnItemByIndex": function(p_TargetGridId, p_columnIndex) {
            return AUIGrid.getColumnItemByIndex(p_TargetGridId, p_columnIndex);
        },

		/**
         * 그리드에 출력된 현재 칼럼 레이아웃을 반환합니다.
         *
         * Return : (Array) 현재 그리드 칼럼 레이아웃
         */
        "getColumnLayout": function(p_TargetGridId) {
            return AUIGrid.getColumnLayout(p_TargetGridId);
        },

		/**
         * 그리드의 칼럼이 출력하는 모든 값들을 반환합니다.
		 * 파라메터 설명
         *   - p_dataField : (String) 칼럼의 dataField 명
		 *   - p_total : (Boolean) 그리드의 원래 데이터를 대상으로 할지 여부. 예로 필터링이 된 경우 필터링 무시하고 전체 데이터 대상 원한다면 true 지정
         *
         * Return : (Array) 해당 칼럼이 출력하고 있는 모든 값들
         */
        "getColumnValues": function(p_TargetGridId, p_dataField, p_total  = ture) {
            return AUIGrid.getColumnValues(p_TargetGridId, p_dataField, p_total);
        },

		/**
         * 데이터 필드에 맞는 칼럼의 현재 너비(width)를 반환합니다.
		 * 파라메터 설명
         *   - p_dataField : (String) 데이터 필드명
         *
         * Return : (Number) 칼럼의 현재 너비(width)
         */
        "getColumnWidthByDataField": function(p_TargetGridId, p_dataField) {
            return AUIGrid.getColumnWidthByDataField(p_TargetGridId, p_dataField);
        },

		/**
         * 칼럼들의 모든 현재 너비(width)를 배열로 반환합니다.
		 * 
         * Return : (Array) 칼럼의 모든 너비(width) 배열
         */
        "getColumnWidthList": function(p_TargetGridId) {
            return AUIGrid.getColumnWidthList(p_TargetGridId);
        },

		/**
         * 페이징 모드(usePaging=true)인 경우 현재 페이지에 출력되는 데이터만 반환합니다.
		 * 
         * Return : (Array) 칼럼의 모든 너비(width) 배열
         */
        "getCurrentPageData": function(p_TargetGridId) {
            return AUIGrid.getCurrentPageData(p_TargetGridId);
        },

		/**
         * 현재 그리드의 칼럼인덱스에 출력 중인 데이터필드(dataField)를 반환합니다.
		 * 파라메터 설명
         *   - p_columnIndex : (Number) 칼럼 인덱스
         *
         * RReturn : (String) 데이터 필드명
         */
        "getDataFieldByColumnIndex": function(p_TargetGridId, p_columnIndex) {
            return AUIGrid.getDataFieldByColumnIndex(p_TargetGridId, p_columnIndex);
        },

		/**
         * 계층형 그리드(트리 그리드)인 경우 행 고유 값(rowIdField 값)에 맞는 행 아이템의 depth를 반환합니다.
		 * 파라메터 설명
         *   - p_rowId (String) : 행 고유 값(rowIdField 값)
         *
         * Return : (Number) 계층구조에서 depth
         */
        "getDepthByRowId": function(p_TargetGridId, p_rowId) {
            return AUIGrid.getDepthByRowId(p_TargetGridId, p_rowId);
        },

		/**
         * 트리 그리드(계층형 그리드)에서 행 고유 값(rowIdField 값)에 해당되는 모든 자손(descendants) 행 아이템을 찾아 배열로 반환합니다.
		 * 파라메터 설명
         *   - p_rowId (String) : 행 고유 값(rowIdField 값)
         *
         * Return : (Array) 주어진 행 고유 값(rowIdField 값)에 따른 모든 자손 행 아이템들
         */
        "getDescendantsByRowId": function(p_TargetGridId, p_rowId) {
            return AUIGrid.getDescendantsByRowId(p_TargetGridId, p_rowId);
        },

		/**
         * 그리드에서 수정된 아이템들의 묶음(배열)을 반환합니다.
	     * Return : (Array) 수정된 행 아이템들
         */
        "getEditedRowColumnItems": function(p_TargetGridId) {
            return AUIGrid.getEditedRowColumnItems(p_TargetGridId);
        },


		/**
         * 그리드에서 수정된 아이템들의 묶음(배열)을 반환합니다.
	     * Return : (Array) 수정된 행 아이템들
         */
        "getEditedRowItems": function(p_TargetGridId) {
            return AUIGrid.getEditedRowItems(p_TargetGridId);
        },

		/**
         * 필터링 된 경우 현재 어떤 필드와 값으로 필터링 되었는지에 대한 정보를 반환합니다.
	     * Return : (Object) 필터링 필드와 현재 필터링 된 값들에 대한 정보
         */
        "getFilterCache": function(p_TargetGridId) {
            return AUIGrid.getFilterCache(p_TargetGridId);
        },

		/**
         * 인라인 필터 행을 표시하여 필터링을 한 경우 해당 인라인 필터의 현재 텍스트들(input 의 값들)을 반환합니다.
	     * Return : (Array) 인라인 필터로 필터링 된 칼럼들에 대한 텍스트값들
         */
        "getFilterInlineTexts": function(p_TargetGridId) {
            return AUIGrid.getFilterInlineTexts(p_TargetGridId);
        },

		/**
         * 지정한 칼럼에 대하여 최적의 칼럼 사이즈를 반환합니다.
		 * 파라메터 설명
         *   - p_dataField : (String) : 칼럼 데이터 필드명
         *
	     * Return : (Number) 해당 칼럼의 사이즈
         */
        "getFitColumnSizeByDataField": function(p_TargetGridId, p_dataField) {
            return AUIGrid.getFitColumnSizeByDataField(p_TargetGridId, p_dataField);
        },

		/**
         * 현재 출력된 헤더 텍스트를 모함하여 모든 셀들의 길이를 조사하여 최적의 칼럼 사이즈를 배열 형태로 반환합니다.
		 * 파라메터 설명
         *   - p_fitToGrid (Boolean) : 모든 칼럼 사이즈들의 총합이 그리드 전체 크기보다 작은 경우 그리드 크기에 맞출지 여부를 지정합니다. (기본값: false)
         *
	     * Return : (Array) 모든 칼럼들의 크기를 담은 배열
         */
        "getFitColumnSizeList": function(p_TargetGridId, p_fitToGrid = false) {
            return AUIGrid.getFitColumnSizeList(p_TargetGridId, p_fitToGrid);
        },

		/**
         * 현재 그리드에 출력된 푸터 데이터를 반환합니다.
		 * 파라메터 설명
         *   - p_index : 출력된 값의 칼럼 인덱스 값 ("#base" 로 행 번호 칼럼에 출력된 푸터 값은 index 가 -1입니다.)
         *   - p_value : 푸터의 값이 포매팅 전의 순수 값 (labelFunction 으로 사용자가 임의 지정한 경우 value 는 text 와 같습니다.)
         *   - p_text : 실제로 푸터의 셀에 출력된 포매팅 된 값
         *
	     * Return : (Array) 출력된 푸터 데이터
         */
        "getFooterData": function(p_TargetGridId, p_index, p_value, p_text) {
            return AUIGrid.getFooterData(p_TargetGridId, p_index, p_value, p_text);
        },

		/**
         * 푸터를 설정한 경우 푸터의 특정 필드의 포매팅된 값을 반환합니다.
		 * 파라메터 설명
         *   - p_dataField : (String) 푸터의 출력 위치 dataField
         *
	     * Return : (String) 해당 열의 푸터 포매팅된 값
         */
        "getFooterFormatValueByDataField": function(p_TargetGridId, p_dataField) {
            return AUIGrid.getFooterFormatValueByDataField(p_TargetGridId, p_dataField);
        },


		/**
         * 사용자가 설정한 푸터 객체(푸터 레이아웃) 을 반환합니다.
	     * Return : (Array) 사용자가 설정한 푸터 객체(푸터 레이아웃)
         */
        "getFooterLayout": function(p_TargetGridId) {
            return AUIGrid.getFooterLayout(p_TargetGridId);
        },

		/**
         * 푸터를 설정한 경우 푸터의 특정 필드 값을 반환합니다.
		 * 파라메터 설명
         *   - p_dataField : (String) 푸터의 출력 위치 dataField
         *
	     * Return : (Number or String) 해당 열의 푸터 값
         */
        "getFooterValueByDataField": function(p_TargetGridId, p_dataField) {
            return AUIGrid.getFooterValueByDataField(p_TargetGridId, p_dataField);
        },
        
        
        /**
         * 그리드에 출력된 현재 데이터를 반환합니다.
		 * 
         * Return : (Array) 상태 정보가 포함된 현재 그리드 행 아이템들
         */
        "getGridData": function(p_TargetGridId) {
            return  AUIGrid.getGridData(p_TargetGridId);
        },

        /**
         * 리드에 출력된 현재 데이터를 추가(added), 삭제(removed), 수정(edited)된 상태와 함께 반환합니다.
		 * 파라메터 설명
         *   - p_stateField (String) : 상태 정보가 추가될 필드명
         *   - p_option (Object) : stateField 의 값으로 사용 될 상태 값들 재정의
		 * 
         * Return : (Array) 상태 정보가 포함된 현재 그리드 행 아이템들
         */
        "getGridDataWithState": function(p_TargetGridId, p_stateField = "state", p_option = { added: "a", removed: "r", edited: "e" } ) {
            return  AUIGrid.getGridDataWithState(p_TargetGridId, p_stateField, p_option);
        },        

        /**
         * 현재 그리드에서 숨겨진 칼럼(hidden Columns)이 있는 경우 숨겨진 칼럼들의 모든 dataField 를 반환합니다.
	     * Return : (Array) 숨겨진 칼럼(hidden Columns)들의 dataField 를 담은 배열
         */
        "getHiddenColumnDataFields": function(p_TargetGridId) {
            return  AUIGrid.getHiddenColumnDataFields(p_TargetGridId);
        },

        /**
         * 현재 그리드에서 숨겨진 칼럼(hidden Columns)이 있는 경우 숨겨진 칼럼들의 칼럼 인덱스(columnIndex) 를 반환합니다..
	     * Return : (Array) 숨겨진 칼럼(hidden Columns)들의 칼럼 인덱스를 담은 배열
         */
        "getHiddenColumnIndexes": function(p_TargetGridId) {
            return  AUIGrid.getHiddenColumnIndexes(p_TargetGridId);
        },

        /**
         * 자바스크립트 네이티브 마우스 이벤트(Native MouseEvent)를 통해 그리드의 인덱스 정보를 반환합니다.
		 * 파라메터 설명
         *   - p_mouseEvent : (MouseEvent) 마우스 이벤트
		 * 
         * Return : (Object) { startRowIndex, startColumnIndex, endRowIndex, endColumnIndex } 의 key 를 갖는 그리드 인덱스 정보 Object
         */
        "getGridDataWithState": function(p_TargetGridId, p_mouseEvent ) {
            return  AUIGrid.getGridDataWithState(p_TargetGridId, p_mouseEvent);
        },  

        /**
         * 특정 셀(rowId 에 맞는 행, dataField 에 맞는 열 부합하는 셀)이 수정된 경우 최초의 그리드 셀 값을 반환합니다.
		 * 파라메터 설명
         *   - p_rowId : (String) 행 아이템의 rowId 값
         *   - p_dataField : (String) 열의 dataField
		 * 
         * Return : (String or Object) 변경 전 원래 셀의 값
         */
        "getInitCellValue": function(p_TargetGridId, p_rowId, p_dataField ) {
            return  AUIGrid.getInitCellValue(p_TargetGridId, p_rowId, p_dataField);
        },  

        /**
         * 그리드 행이 수정된 경우 최초의 그리드 행 아이템을 반환합니다. 즉, 수정되기 전 원래의 값을 갖는 행 아이템을 반환합니다.
		 * 파라메터 설명
         *   - p_rowId : (String) 행 아이템의 rowId 값
		 * 
         * Return : (Object or Array) 수정 전의 행 아이템(들), 만약 해당 행이 수정되지 않았다면 null 반환
         */
        "getInitValueItem": function(p_TargetGridId, p_rowId ) {
            return  AUIGrid.getInitValueItem(p_TargetGridId, p_rowId);
        },

        /**
         * 행 고유 값(rowIdField 값)에 맞는 행 아이템을 반환합니다.
		 * 파라메터 설명
         *   - p_rowId : (String) 행 아이템의 rowId 값
		 * 
         * Return : (Object) 행아이템 객체
         */
        "getItemByRowId": function(p_TargetGridId, p_rowId ) {
            return  AUIGrid.getItemByRowId(p_TargetGridId, p_rowId);
        },
        
		/**
         * 행 인덱스에 맞는 행 아이템을 반환합니다.
		 * 파라메터 설명
         *   - p_rowIndex (Number) : 행인덱스
		 * 
         * Return : (Object) 행아이템 객체
         */
        "getItemByRowIndex": function(p_TargetGridId, p_rowIndex ) {
            return  AUIGrid.getItemByRowIndex(p_TargetGridId, p_rowIndex);
        },

		/**
         * 가로 병합된 셀에 대하여 해당 병합의 마지막 칼럼 인덱스를 반환합니다.
		 * 파라메터 설명
         *   - p_rowIndex : (Number) 가로 병합된 셀의 행 인덱스
         *   - p_columnIndex : (Number) 가로 병합된 셀의 열 인덱스
		 * 
         * Return : (Number) 셀이 가로 병합된 셀인 경우 병합 마지막 인덱스 반환
         */
        "getItemByRowIndex": function(p_TargetGridId, p_rowIndex, p_columnIndex ) {
            return  AUIGrid.getItemByRowIndex(p_TargetGridId, p_rowIndex, p_columnIndex);
        },

		/**
         * 세로 병합된 셀에 대하여 해당 병합의 마지막 행 인덱스를 반환합니다.
		 * 파라메터 설명
         *   - p_rowIndex : (Number) 가로 병합된 셀의 행 인덱스
         *   - p_columnIndex : (Number) 가로 병합된 셀의 열 인덱스
		 * 
         * Return : (Number) 셀이 세로 병합된 셀인 경우 병합 마지막 행 인덱스 반환
         */
        "getMergeEndRowIndex": function(p_TargetGridId, p_rowIndex, p_columnIndex ) {
            return  AUIGrid.getMergeEndRowIndex(p_TargetGridId, p_rowIndex, p_columnIndex);
        },


		/**
         * 주어진 셀이 세로 병합된 경우 해당 셀의 세로 병합의 대상이 된 모든 행 아이템을 반환합니다.
		 * 파라메터 설명
         *   - p_rowIndex : (Number) 가로 병합된 셀의 행 인덱스
         *   - p_columnIndex : (Number) 가로 병합된 셀의 열 인덱스
		 * 
         * Return : (Array) 해당 셀로 세로 병합된 모든 행 아이템들
         */
        "getMergeItems": function(p_TargetGridId, p_rowIndex, p_columnIndex ) {
            return  AUIGrid.getMergeItems(p_TargetGridId, p_rowIndex, p_columnIndex);
        },
        
        
		/**
         * 가로 병합된 셀에 대하여 해당 병합의 시작 칼럼 인덱스를 반환합니다.
		 * 파라메터 설명
         *   - p_rowIndex : (Number) 가로 병합된 셀의 행 인덱스
         *   - p_columnIndex : (Number) 가로 병합된 셀의 열 인덱스
		 * 
         * Return : (Number) 셀이 가로 병합된 셀인 경우 병합 시작 인덱스 반환
         */
        "getMergeStartColumnIndex": function(p_TargetGridId, p_rowIndex, p_columnIndex ) {
            return  AUIGrid.getMergeStartColumnIndex(p_TargetGridId, p_rowIndex, p_columnIndex);
        },

		/**
         * 세로 병합된 셀에 대하여 해당 병합의 시작 행 인덱스를 반환합니다.
		 * 파라메터 설명
         *   - p_rowIndex : (Number) 가로 병합된 셀의 행 인덱스
         *   - p_columnIndex : (Number) 가로 병합된 셀의 열 인덱스
		 * 
         * Return : (Number) 셀이 세로 병합된 셀인 경우 병합 시작 인덱스 반환
         */
        "getMergeStartRowIndex": function(p_TargetGridId, p_rowIndex, p_columnIndex ) {
            return  AUIGrid.getMergeStartRowIndex(p_TargetGridId, p_rowIndex, p_columnIndex);
        },

		/**
         * [deprecated Ver 3.0.4] 수정되기 전의 셀 값을 반환합니다.
		 * 
         * Return : [deprecated Ver 3.0.4] 수정되기 전의 셀 값을 반환합니다.
         */
        "getOrgCellValue": function(p_TargetGridId) {
            return  AUIGrid.getOrgCellValue(p_TargetGridId);
        },

		/**
         * 그리드의 데이터를 반환합니다.
		 * - 이 메소드는 필터링, 정렬 등으로 현재 그리드에 보여지는 데이터가 아닌 전체 데이터를 반환합니다.
		 * 
         * Return : (Array) 현재 그리드 행 아이템들
         */
        "getOrgGridData": function(p_TargetGridId) {
            return  AUIGrid.getOrgGridData(p_TargetGridId);
        },

		/**
         * [deprecated Ver 3.0.4] 수정되기 전 원래의 값을 갖는 행 아이템을 반환합니다.
		 * 
         * Return : [deprecated Ver 3.0.4] 수정되기 전 원래의 값을 갖는 행 아이템을 반환합니다.
         */
        "getOrgValueItem": function(p_TargetGridId) {
            return  AUIGrid.getOrgValueItem(p_TargetGridId);
        },

		/**
         * 헤더를 계층형(그룹형)으로 설정한 경우 자기 자신의 부모에 해당되는 그룹 칼럼을 반환합니다.
		 * 파라메터 설명
         *   - p_dataField (String) : 칼럼의 데이터 필드명
		 * 
         *  Return : (Object) 그룹 칼럼 아이템
         */
        "getParentColumnByDataField": function(p_TargetGridId, p_dataField) {
            return  AUIGrid.getParentColumnByDataField(p_TargetGridId, p_dataField);
        },

		/**
         * 계층형 그리드(트리 그리드)인 경우 행 고유 값(rowIdField 값)에 맞는 행 아이템의 부모 행 아이템을 찾아 반환합니다.
		 * 파라메터 설명
         *   - p_rowId (String) : 행 고유 값(rowIdField 값)
		 * 
         *  Return : (Object) 부모 행 아이템
         */
        "getParentItemByRowId": function(p_TargetGridId, p_rowId) {
            return  AUIGrid.getParentItemByRowId(p_TargetGridId, p_rowId);
        },

		/**
         * 그리드 속성의 값을 반환합니다.
		 * 파라메터 설명
         *   - p_name (String) : 속성명
		 * 
         *  Return : (Object) 속성값
         */
        "getProp": function(p_TargetGridId, p_name) {
            return  AUIGrid.getProp(p_TargetGridId, p_name);
        },


		/**
		 * 그리드에서 삭제된 열(column)의 dataField 목록을 반환합니다.
		 *
		 * 삭제된 열이란 최초 컬럼 레이아웃에서 정의한 컬럼을 삭제한 경우를 의미합니다.
		 * 사용자가 추가한 후 삭제한 컬럼은 포함되지 않습니다.
		 *
		 * Return : (Array) 삭제된 열의 dataField 목록
		 */
		"getRemovedColumnFields": function(p_TargetGridId) {
		    return AUIGrid.getRemovedColumnFields(p_TargetGridId);
		},
		
		/**
		 * 그리드에서 삭제된 행 아이템들을 반환합니다.
		 *
		 * 기본적으로 최초 데이터에서 삭제된 행만 반환합니다.
		 * addRow() 등으로 추가한 후 다시 삭제한 행은 포함되지 않습니다.
		 *
		 * 파라미터 설명
		 *  - p_includeAdded (Boolean, Optional) : true인 경우 추가 후 삭제한 행도 포함합니다.
		 *
		 * Return : (Array) 삭제된 행 아이템 목록
		 */
		"getRemovedItems": function(p_TargetGridId, includeAdded) {
		    return includeAdded === undefined
		        ? AUIGrid.getRemovedItems(p_TargetGridId)
		        : AUIGrid.getRemovedItems(p_TargetGridId, p_includeAdded);
		},
		
		/**
		 * 그리드에서 사용자가 추가한 후 다시 삭제한 행 아이템들을 반환합니다.
		 *
		 * 최초 데이터가 아닌 addRow(), insertRow() 등으로 추가한 후
		 * 다시 삭제한 행만 반환합니다.
		 *
		 * Return : (Array) 추가 후 삭제된 행 아이템 목록
		 */
		"getRemovedNewItems": function(p_TargetGridId) {
		    return AUIGrid.getRemovedNewItems(p_TargetGridId);
		},
		
		/**
		 * 현재 그리드에 출력되고 있는 전체 행 개수를 반환합니다.
		 *
		 * 트리 그리드인 경우 접혀있는 브랜치(branch) 행도 포함하여 반환합니다.
		 *
		 * Return : (Number) 전체 행 개수
		 */
		"getRowCount": function(p_TargetGridId) {
		    return AUIGrid.getRowCount(p_TargetGridId);
		},


		/**
		 * 특정 컬럼의 값과 일치하는 값이 있는 모든 행의 인덱스를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 찾고자 하는 컬럼의 dataField명
		 *  - p_Values (String or Array) : dataField에서 찾고자 하는 값
		 *
		 * Return : (Array) 주어진 값과 일치하는 모든 행 아이템의 rowIndex
		 */
		"getRowIndexesByValue": function(p_TargetGridId, p_DataField, p_Values) {
		    return AUIGrid.getRowIndexesByValue(p_TargetGridId, p_DataField, p_Values);
		},
		
		/**
		 * 수직 스크롤이 생성된 경우 현재 그리드에 출력되고 있는 행의 최상단 인덱스를 반환합니다.
		 *
		 * 수직 스크롤이 생성되지 않은 경우 0을 반환합니다.
		 *
		 * Return : (Number) 최상단 행 인덱스
		 */
		"getRowPosition": function(p_TargetGridId) {
		    return AUIGrid.getRowPosition(p_TargetGridId);
		},
		
		/**
		 * 특정 컬럼의 값과 일치하는 값이 있는 모든 행 아이템을 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 찾고자 하는 컬럼의 dataField명
		 *  - p_Values (String or Array) : dataField에서 찾고자 하는 값
		 *
		 * Return : (Array) 주어진 값과 일치하는 모든 행 아이템
		 */
		"getRowsByValue": function(p_TargetGridId, p_DataField, p_Values) {
		    return AUIGrid.getRowsByValue(p_TargetGridId, p_DataField, p_Values);
		},
		
		/**
		 * 그리드에 설정된 scaleFactor 값을 반환합니다.
		 *
		 * Return : (Number) scale 값
		 */
		"getScaleFactor": function(p_TargetGridId) {
		    return AUIGrid.getScaleFactor(p_TargetGridId);
		},

		/**
		 * 현재 선택된 셀들이 블록 형태인 경우 선택한 셀들의 시작 컬럼 인덱스와
		 * 종료 컬럼 인덱스를 반환합니다.
		 *
		 * Return : (Array) 선택한 셀들의 시작 컬럼 인덱스와 종료 컬럼 인덱스 배열
		 */
		"getSelectedColIndexes": function(p_TargetGridId) {
		    return AUIGrid.getSelectedColIndexes(p_TargetGridId);
		},
		
		/**
		 * 현재 선택된 아이템의 rowIndex와 columnIndex를 반환합니다.
		 *
		 * 선택 모드가 "none"인 경우에도 현재 선택된 아이템의
		 * rowIndex와 columnIndex를 반환합니다.
		 *
		 * 다수의 셀 또는 행을 선택한 경우 첫 번째로 선택된 셀 또는 행의
		 * rowIndex와 columnIndex를 반환합니다.
		 *
		 * Return : (Array) rowIndex와 columnIndex를 갖는 배열
		 */
		"getSelectedIndex": function(p_TargetGridId) {
		    return AUIGrid.getSelectedIndex(p_TargetGridId);
		},

		/**
		 * 현재 선택된 모든 셀(또는 행) 아이템을 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_PerformanceMode (Boolean, Optional) : 성능 위주로 선택 셀(또는 행) 아이템을 반환할지 여부 (기본값 : false)
		 *
		 * Return : (Array) 선택된 아이템들을 요소로 갖는 배열
		 * 		반환값은 배열로 개별 배열 요소는 다음과 같은 요소를 갖는 Object 입니다.
		 * 		rowIndex : 행의 인덱스
		 * 		columnIndex : 칼럼의 인덱스
		 * 		dataField : 선택 칼럼이 출력하고 있는 그리드 데이터의 필드명
		 * 		headerText : 선택 칼럼의 헤더 텍스트
		 * 		editable : 선택 칼럼의 수정 가능 여부
		 * 		value : 선택 셀의 현재 그리드 값
		 * 		item : 선택 행 아이템들을 갖는 Object
		 */
		"getSelectedItems": function(p_TargetGridId, p_PerformanceMode) {
		    return p_PerformanceMode === undefined
		        ? AUIGrid.getSelectedItems(p_TargetGridId)
		        : AUIGrid.getSelectedItems(p_TargetGridId, p_PerformanceMode);
		},
		
		/**
		 * 셀 병합 상태에서 다중 선택으로 인해 변경된 기준 셀의
		 * rowIndex와 columnIndex를 반환합니다.
		 *
		 * Return : (Array) rowIndex와 columnIndex를 갖는 배열
		 */
		"getSelectedPrimeIndexOnMerge": function(p_TargetGridId) {
		    return AUIGrid.getSelectedPrimeIndexOnMerge(p_TargetGridId);
		},


		/**
		 * 현재 선택된 셀들이 블럭 형태인 경우 선택한 셀들의 시작 행 인덱스와
		 * 종료 행 인덱스를 반환합니다.
		 *
		 * Return : (Array) 선택한 셀들의 시작 행 인덱스와 종료 행 인덱스 배열
		 */
		"getSelectedRowIndexes": function(p_TargetGridId) {
		    return AUIGrid.getSelectedRowIndexes(p_TargetGridId);
		},
		
		/**
		 * 현재 선택된 행(rows) 아이템을 반환합니다.
		 *
		 * Return : (Array) 선택된 행 아이템들을 요소로 갖는 배열
		 */
		"getSelectedRows": function(p_TargetGridId) {
		    return AUIGrid.getSelectedRows(p_TargetGridId);
		},
		
		/**
		 * 그리드 선택 셀의 값을 텍스트로 반환합니다.
		 *
		 * 다수의 셀이 선택된 경우 행은 캐리지 리턴(\r\n),
		 * 열은 탭(\t)으로 구분된 텍스트를 반환합니다.
		 *
		 * Return : (String) 선택 셀 값 텍스트
		 */
		"getSelectedText": function(p_TargetGridId) {
		    return AUIGrid.getSelectedText(p_TargetGridId);
		},
		
		/**
		 * 현재 설정된 정렬 문자열 비교기(Intl.Collator) 객체를 반환합니다.
		 *
		 * Return : (Intl.Collator | null) 문자열 비교기 객체
		 */
		"getSortCollator": function(p_TargetGridId) {
		    return AUIGrid.getSortCollator(p_TargetGridId);
		},
		
		/**
		 * 현재 그리드에 적용된 정렬 필드 정보를 반환합니다.
		 *
		 * Return : (Array) 정렬 필드 정보 배열
		 */
		"getSortingFields": function(p_TargetGridId) {
		    return AUIGrid.getSortingFields(p_TargetGridId);
		},


		/**
		 * 현재 그리드의 추가, 삭제, 변경된 상태 정보를 반환합니다.
		 *
		 * Return : (Object) 추가, 삭제, 변경된 상태 정보
		 */
		"getStateCache": function(p_TargetGridId) {
		    return AUIGrid.getStateCache(p_TargetGridId);
		},
		
		/**
		 * 현재 그리드에 출력된 값을 모두 문자열(String) 형태의
		 * 텍스트 데이터로 반환합니다.
		 *
		 * Return : (Array) 현재 그리드 텍스트 데이터
		 */
		"getTextDataProvider": function(p_TargetGridId) {
		    return AUIGrid.getTextDataProvider(p_TargetGridId);
		},
		
		/**
		 * 트리 그리드에서 필터링 규칙에 맞는 모든 행을
		 * 1차원 배열 형태로 반환합니다.
		 *
		 * Return : (Array) 필터링 상태의 행 아이템
		 */
		"getTreeFilteredFlatData": function(p_TargetGridId) {
		    return AUIGrid.getTreeFilteredFlatData(p_TargetGridId);
		},
		
		/**
		 * 트리 그리드의 전체 데이터를
		 * 1차원 배열 형태로 반환합니다.
		 *
		 * Return : (Array) 전체 행 아이템
		 */
		"getTreeFlatData": function(p_TargetGridId) {
		    return AUIGrid.getTreeFlatData(p_TargetGridId);
		},
		
		/**
		 * 트리 그리드의 계층 구조 데이터를 반환합니다.
		 *
		 * Return : (Array) 계층 구조 행 아이템
		 */
		"getTreeGridData": function(p_TargetGridId) {
		    return AUIGrid.getTreeGridData(p_TargetGridId);
		},
		
		/**
		 * 트리 그리드의 전체 계층 깊이(depth)를 반환합니다.
		 *
		 * Return : (Number) 전체 depth
		 */
		"getTreeTotalDepth": function(p_TargetGridId) {
		    return AUIGrid.getTreeTotalDepth(p_TargetGridId);
		},
		
		/**
		 * 지정한 dataField에 해당하는 컬럼을 숨깁니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String or Array) : 컬럼의 데이터 필드명
		 */
		"hideColumnByDataField": function(p_TargetGridId, p_DataField) {
		    AUIGrid.hideColumnByDataField(p_TargetGridId, p_DataField);
		},


		/**
		 * 지정한 컬럼 그룹에 속한 모든 하위 컬럼을 숨깁니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 컬럼의 데이터 필드명
		 */
		"hideColumnGroup": function(p_TargetGridId, p_DataField) {
		    AUIGrid.hideColumnGroup(p_TargetGridId, p_DataField);
		},
		
		/**
		 * 지정한 엑스트라 컬럼을 숨깁니다.
		 *
		 * 파라미터 설명
		 *  - p_PropName (String) : 숨길 엑스트라 컬럼 속성명
		 */
		"hideExtraColumn": function(p_TargetGridId, p_PropName) {
		    AUIGrid.hideExtraColumn(p_TargetGridId, p_PropName);
		},
		
		/**
		 * 현재 출력된 그리드에서 푸터를 숨깁니다.
		 */
		"hideFooterLater": function(p_TargetGridId) {
		    AUIGrid.hideFooterLater(p_TargetGridId);
		},
		
		/**
		 * 선택한 행을 들여쓰기하여 계층 구조로 만듭니다.
		 */
		"indentTreeDepth": function(p_TargetGridId) {
		    AUIGrid.indentTreeDepth(p_TargetGridId);
		},
		
		/**
		 * 행 인덱스(rowIndex)에 해당하는 행 고유 값(rowId)을 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 행 인덱스
		 *
		 * Return : (String) 행 고유 값(rowId)
		 */
		"indexToRowId": function(p_TargetGridId, p_RowIndex) {
		    return AUIGrid.indexToRowId(p_TargetGridId, p_RowIndex);
		},

		/**
		 * 행 고유 값(rowId)에 해당하는 행이 추가된 행인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *
		 * Return : (Boolean) 추가된 행 여부
		 */
		"isAddedById": function(p_TargetGridId, p_RowId) {
		    return AUIGrid.isAddedById(p_TargetGridId, p_RowId);
		},
		
		/**
		 * 행 인덱스(rowIndex)에 해당하는 행이 추가된 행인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 행 인덱스
		 *
		 * Return : (Boolean) 추가된 행 여부
		 */
		"isAddedByRowIndex": function(p_TargetGridId, p_RowIndex) {
		    return AUIGrid.isAddedByRowIndex(p_TargetGridId, p_RowIndex);
		},
		
		/**
		 * 현재 브라우저에서 PDF 내보내기 사용 가능 여부를 반환합니다.
		 *
		 * Return : (Boolean) PDF 내보내기 가능 여부
		 */
		"isAvailablePdf": function(p_TargetGridId) {
		    return AUIGrid.isAvailablePdf(p_TargetGridId);
		},
		
		/**
		 * 로컬 다운로드 사용 가능 여부를 반환합니다.
		 *
		 * Return : (Boolean) 로컬 다운로드 가능 여부
		 */
		"isAvailableLocalDownload": function(p_TargetGridId) {
		    return AUIGrid.isAvailableLocalDownload(p_TargetGridId);
		},
		
		/**
		 * 행 고유 값(rowId)에 해당하는 행의 체크 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *
		 * Return : (Boolean) 체크 여부
		 */
		"isCheckedRowById": function(p_TargetGridId, p_RowId) {
		    return AUIGrid.isCheckedRowById(p_TargetGridId, p_RowId);
		},

		/**
		 * 그리드가 생성되었는지 여부를 반환합니다.
		 *
		 * Return : (Boolean) 생성 여부
		 */
		"isCreated": function(p_TargetGridId) {
		    return AUIGrid.isCreated(p_TargetGridId);
		},
		
		/**
		 * 행 고유 값(rowId)에 해당하는 행이 수정된 행인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *
		 * Return : (Boolean) 수정된 행 여부
		 */
		"isEditedById": function(p_TargetGridId, p_RowId) {
		    return AUIGrid.isEditedById(p_TargetGridId, p_RowId);
		},
		
		/**
		 * 행 인덱스(rowIndex)에 해당하는 행이 수정된 행인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 행 인덱스
		 *
		 * Return : (Boolean) 수정된 행 여부
		 */
		"isEditedByRowIndex": function(p_TargetGridId, p_RowIndex) {
		    return AUIGrid.isEditedByRowIndex(p_TargetGridId, p_RowIndex);
		},
		
		/**
		 * 지정한 셀이 수정되었는지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *  - p_DataField (String) : 컬럼의 dataField
		 *
		 * Return : (Boolean) 수정된 셀 여부
		 */
		"isEditedCell": function(p_TargetGridId, p_RowId, p_DataField) {
		    return AUIGrid.isEditedCell(p_TargetGridId, p_RowId, p_DataField);
		},
		
		/**
		 * 지정한 셀이 수정되었는지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 행 인덱스
		 *  - p_ColumnIndex (Number) : 열 인덱스
		 *
		 * Return : (Boolean) 수정된 셀 여부
		 */
		"isEditedCellByIndex": function(p_TargetGridId, p_RowIndex, p_ColumnIndex) {
		    return AUIGrid.isEditedCellByIndex(p_TargetGridId, p_RowIndex, p_ColumnIndex);
		},


		/**
		 * 현재 그리드 데이터가 필터링되었는지 여부를 반환합니다.
		 *
		 * Return : (Boolean) 필터링 여부
		 */
		"isFilteredGrid": function(p_TargetGridId) {
		    return AUIGrid.isFilteredGrid(p_TargetGridId);
		},
		
		/**
		 * 지정한 행이 브랜치(branch)인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *
		 * Return : (Boolean) 브랜치 여부
		 */
		"isItemBranchByRowId": function(p_TargetGridId, p_RowId) {
		    return AUIGrid.isItemBranchByRowId(p_TargetGridId, p_RowId);
		},
		
		/**
		 * 지정한 행이 열린 상태인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *
		 * Return : (Boolean) 열린 상태 여부
		 */
		"isItemOpenByRowId": function(p_TargetGridId, p_RowId) {
		    return AUIGrid.isItemOpenByRowId(p_TargetGridId, p_RowId);
		},
		
		/**
		 * 지정한 행이 현재 그리드에 출력되고 있는지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *
		 * Return : (Boolean) 출력 여부
		 */
		"isItemVisibleByRowId": function(p_TargetGridId, p_RowId) {
		    return AUIGrid.isItemVisibleByRowId(p_TargetGridId, p_RowId);
		},
		
		/**
		 * treeLazyMode에서 하위(자식) 데이터가 이미 요청되었는지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 행 인덱스
		 *
		 * Return : (Boolean) 요청 여부
		 */
		"isLazyRequestedByIndex": function(p_TargetGridId, p_RowIndex) {
		    return AUIGrid.isLazyRequestedByIndex(p_TargetGridId, p_RowIndex);
		},

		/**
		 * 지정한 셀이 병합된 셀인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 셀의 행 인덱스
		 *  - p_ColumnIndex (Number) : 셀의 열 인덱스
		 *
		 * Return : (Boolean) 병합된 셀 여부
		 */
		"isMergedCell": function(p_TargetGridId, p_RowIndex, p_ColumnIndex) {
		    return AUIGrid.isMergedCell(p_TargetGridId, p_RowIndex, p_ColumnIndex);
		},
		
		/**
		 * 지정한 셀이 가로 병합된 셀인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 셀의 행 인덱스
		 *  - p_ColumnIndex (Number) : 셀의 열 인덱스
		 *
		 * Return : (Boolean) 가로 병합된 셀 여부
		 */
		"isMergedCellByColumn": function(p_TargetGridId, p_RowIndex, p_ColumnIndex) {
		    return AUIGrid.isMergedCellByColumn(p_TargetGridId, p_RowIndex, p_ColumnIndex);
		},
		
		/**
		 * 지정한 셀이 세로 병합된 셀인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 셀의 행 인덱스
		 *  - p_ColumnIndex (Number) : 셀의 열 인덱스
		 *
		 * Return : (Boolean) 세로 병합된 셀 여부
		 */
		"isMergedCellByRow": function(p_TargetGridId, p_RowIndex, p_ColumnIndex) {
		    return AUIGrid.isMergedCellByRow(p_TargetGridId, p_RowIndex, p_ColumnIndex);
		},
		
		/**
		 * 현재 필터 레이어가 열려있는지 여부를 반환합니다.
		 *
		 * Return : (Boolean) 필터 레이어 오픈 여부
		 */
		"isOpenFilterLayer": function(p_TargetGridId) {
		    return AUIGrid.isOpenFilterLayer(p_TargetGridId);
		},
		
		/**
		 * 행 고유 값(rowId)에 해당하는 행이 삭제된 행인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *
		 * Return : (Boolean) 삭제된 행 여부
		 */
		"isRemovedById": function(p_TargetGridId, p_RowId) {
		    return AUIGrid.isRemovedById(p_TargetGridId, p_RowId);
		},
		
		/**
		 * 행 인덱스(rowIndex)에 해당하는 행이 삭제된 행인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 행 인덱스
		 *
		 * Return : (Boolean) 삭제된 행 여부
		 */
		"isRemovedByRowIndex": function(p_TargetGridId, p_RowIndex) {
		    return AUIGrid.isRemovedByRowIndex(p_TargetGridId, p_RowIndex);
		},
		
		/**
		 * 현재 셀 선택이 역방향인지 여부를 반환합니다.
		 *
		 * Return : (Boolean) 역방향 선택 여부
		 */
		"isSelectionReversed": function(p_TargetGridId) {
		    return AUIGrid.isSelectionReversed(p_TargetGridId);
		},
		
		/**
		 * 현재 그리드 데이터가 정렬되었는지 여부를 반환합니다.
		 *
		 * Return : (Boolean) 정렬 여부
		 */
		"isSortedGrid": function(p_TargetGridId) {
		    return AUIGrid.isSortedGrid(p_TargetGridId);
		},
		
		/**
		 * 현재 그리드가 트리 그리드인지 여부를 반환합니다.
		 *
		 * Return : (Boolean) 트리 그리드 여부
		 */
		"isTreeGrid": function(p_TargetGridId) {
		    return AUIGrid.isTreeGrid(p_TargetGridId);
		},
		
		/**
		 * 지정한 값이 해당 컬럼에서 고유한 값인지 여부를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 데이터 필드명
		 *  - p_Value (Object) : 검사할 값
		 *
		 * Return : (Boolean) 고유 값 여부
		 */
		"isUniqueValue": function(p_TargetGridId, p_DataField, p_Value) {
		    return AUIGrid.isUniqueValue(p_TargetGridId, p_DataField, p_Value);
		},
		
		/**
		 * 지정한 페이지로 이동합니다.
		 *
		 * 파라미터 설명
		 *  - p_PageNum (Number) : 이동할 페이지 번호
		 *  - p_KeepVScrollPos (Boolean, Optional) : 수직 스크롤 위치 유지 여부
		 *  - p_KeepHScrollPos (Boolean, Optional) : 수평 스크롤 위치 유지 여부
		 */
		"movePageTo": function(p_TargetGridId, p_PageNum, p_KeepVScrollPos, p_KeepHScrollPos) {
		    AUIGrid.movePageTo(p_TargetGridId, p_PageNum, p_KeepVScrollPos, p_KeepHScrollPos);
		},
		
		/**
		 * 선택한 행을 아래로 한 단계 이동합니다.
		 */
		"moveRowsToDown": function(p_TargetGridId) {
		    AUIGrid.moveRowsToDown(p_TargetGridId);
		},
		
		/**
		 * 선택한 행을 위로 한 단계 이동합니다.
		 */
		"moveRowsToUp": function(p_TargetGridId) {
		    AUIGrid.moveRowsToUp(p_TargetGridId);
		},

		/**
		 * 지정한 단일 행을 원하는 행 인덱스로 이동합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *  - p_ToRowIndex (Object) : 이동시킬 위치의 행 인덱스
		 */
		"moveRowToIndex": function(p_TargetGridId, p_RowId, p_ToRowIndex) {
		    AUIGrid.moveRowToIndex(p_TargetGridId, p_RowId, p_ToRowIndex);
		},
		
		/**
		 * 현재 선택된 셀에 편집기와 하단 리스트를 강제로 오픈합니다.
		 */
		"openEditDownListLayer": function(p_TargetGridId) {
		    AUIGrid.openEditDownListLayer(p_TargetGridId);
		},
		
		/**
		 * 지정한 컬럼의 필터 레이어를 오픈합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 컬럼의 dataField명
		 */
		"openFilterLayer": function(p_TargetGridId, p_DataField) {
		    AUIGrid.openFilterLayer(p_TargetGridId, p_DataField);
		},
		
		/**
		 * 현재 선택된 셀에 편집기를 강제로 오픈합니다.
		 */
		"openInputer": function(p_TargetGridId) {
		    AUIGrid.openInputer(p_TargetGridId);
		},
		
		/**
		 * 선택한 행을 내어쓰기하여 계층 구조를 변경합니다.
		 */
		"outdentTreeDepth": function(p_TargetGridId) {
		    AUIGrid.outdentTreeDepth(p_TargetGridId);
		},
		
		/**
		 * 기존 그리드 데이터의 상단에 데이터를 추가합니다.
		 *
		 * 파라미터 설명
		 *  - p_AdditionalData (Array) : 추가할 데이터
		 */
		"prependData": function(p_TargetGridId, p_AdditionalData) {
		    AUIGrid.prependData(p_TargetGridId, p_AdditionalData);
		},
		
		/**
		 * 이전에 실행 취소한 작업을 다시 실행합니다.
		 */
		"redo": function(p_TargetGridId) {
		    AUIGrid.redo(p_TargetGridId);
		},
		
		/**
		 * 다시 실행 가능 여부를 반환합니다.
		 *
		 * Return : (Boolean) 다시 실행 가능 여부
		 */
		"redoable": function(p_TargetGridId) {
		    return AUIGrid.redoable(p_TargetGridId);
		},
		
		/**
		 * 변경된 그리드 속성을 실제 그리드에 적용합니다.
		 */
		"refresh": function(p_TargetGridId) {
		    AUIGrid.refresh(p_TargetGridId);
		},
		
		/**
		 * 지정한 행 데이터를 찾아 갱신합니다.
		 *
		 * 파라미터 설명
		 *  - p_Items (Array or Object) : 갱신할 행 데이터
		 *  - p_FlashStyle (String, Optional) : 갱신된 셀에 적용할 CSS 클래스명
		 *  - p_FlashTime (Number, Optional) : CSS 클래스가 적용되는 시간(ms)
		 */
		"refreshRows": function(p_TargetGridId, p_Items, p_FlashStyle, p_FlashTime) {
		    AUIGrid.refreshRows(
		        p_TargetGridId,
		        p_Items,
		        p_FlashStyle,
		        p_FlashTime
		    );
		},
		
		/**
		 * 그리드에 표시된 프리로더를 삭제합니다.
		 */
		"removeAjaxLoader": function(p_TargetGridId) {
		    AUIGrid.removeAjaxLoader(p_TargetGridId);
		},
		
		/**
		 * 체크박스에 체크된 행을 그리드에서 삭제합니다.
		 */
		"removeCheckedRows": function(p_TargetGridId) {
		    AUIGrid.removeCheckedRows(p_TargetGridId);
		},


		/**
		 * 그리드 열(column)을 삭제합니다.
		 *
		 * 파라미터 설명
		 *  - p_ColumnIndex (Number or String or Array) : 삭제할 열의 인덱스, "selectedIndex" 또는 열 인덱스 배열
		 */
		"removeColumn": function(p_TargetGridId, p_ColumnIndex) {
		    AUIGrid.removeColumn(p_TargetGridId, p_ColumnIndex);
		},
		
		/**
		 * 그리드에 출력된 안내 메시지를 제거합니다.
		 */
		"removeInfoMessage": function(p_TargetGridId) {
		    AUIGrid.removeInfoMessage(p_TargetGridId);
		},
		
		 /**
         * 그리드 행(row) 아이템을 삭제합니다.
         * 
         * 파라메터 설명
         * 	 - p_DeleteTargetRowIndex_Array (Number or String or Array) : 삭제할 행 인덱스, "selectedIndex" 또는 행 인덱스 배열
         */
        "removeRow": function(p_AuiGridId, p_DeleteTargetRowIndex_Array) {

            var rowIndexes = p_DeleteTargetRowIndex_Array;

            // 숫자 또는 숫자형 문자열 1건 처리
            if ((typeof rowIndexes === "number" && Number.isInteger(rowIndexes)) ||
                (typeof rowIndexes === "string" && rowIndexes.trim() !== "" && Number.isInteger(Number(rowIndexes)))) {
                rowIndexes = [Number(rowIndexes)];

            } else if (Array.isArray(rowIndexes)) {
                var converted = rowIndexes.map(function(item) {
                    if (
                        (typeof item === "number" && Number.isInteger(item)) ||
                        (typeof item === "string" && item.trim() !== "" && Number.isInteger(Number(item)))
                    ) {
                        return Number(item);
                    }
                    return null;
                });

                var isValidArray = converted.every(function(item) {
                    return item !== null;
                });

                if (!isValidArray) {
                    console.warn("removeRow: 배열 안에 숫자로 변환할 수 없는 값이 포함되어 있습니다.", rowIndexes);
                    return false;
                }

                rowIndexes = converted;
            } else {
                console.warn("removeRow: row index는 숫자, 숫자형 문자열, 또는 그 배열만 가능합니다.", rowIndexes);
                return false;
            }

            return AUIGrid.removeRow(p_AuiGridId, rowIndexes);

        },
		
		
		/**
		 * 행 고유 값(rowId)을 이용하여 그리드 행 아이템을 삭제합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String or Array) : 삭제할 행 고유 값 또는 행 고유 값 배열
		 */
		"removeRowByRowId": function(p_TargetGridId, p_RowId) {
		    AUIGrid.removeRowByRowId(p_TargetGridId, p_RowId);
		},
		
		/**
		 * 소프트 삭제 상태로 표시된 행을 그리드에서 완전히 제거합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIds (String or Array, Optional) : 제거할 행의 rowId 또는 rowId 배열
		 */
		"removeSoftRows": function(p_TargetGridId, p_RowIds) {
		    AUIGrid.removeSoftRows(p_TargetGridId, p_RowIds);
		},
		
		/**
		 * 특정 셀에 출력된 토스트 메시지를 제거합니다.
		 */
		"removeToastMessage": function(p_TargetGridId) {
		    AUIGrid.removeToastMessage(p_TargetGridId);
		},
		
		/**
		 * treeLazyMode에서 지정한 행의 하위 데이터 요청 상태를 초기화합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 행 인덱스
		 */
		"resetLazyStateByIndex": function(p_TargetGridId, p_RowIndex) {
		    AUIGrid.resetLazyStateByIndex(p_TargetGridId, p_RowIndex);
		},
		
		/**
		 * 추가 또는 삭제된 컬럼의 상태 정보 캐시를 초기화합니다.
		 *
		 * 파라미터 설명
		 *  - p_Option (String) : 초기화 옵션("c", "d", "a")
		 */
		"resetUpdatedColumns": function(p_TargetGridId, p_Option) {
		    AUIGrid.resetUpdatedColumns(p_TargetGridId, p_Option);
		},
		
		/**
		 * 지정한 행의 추가, 수정, 삭제 상태 정보 캐시를 초기화합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 초기화할 행의 rowId
		 *  - p_Option (String) : 초기화 옵션("c", "u", "e", "d", "a")
		 */
		"resetUpdatedItemById": function(p_TargetGridId, p_RowId, p_Option) {
		    AUIGrid.resetUpdatedItemById(p_TargetGridId, p_RowId, p_Option);
		},
		
		/**
		 * 전체 행의 추가, 수정, 삭제 상태 정보 캐시를 초기화합니다.
		 *
		 * 파라미터 설명
		 *  - p_Option (String) : 초기화 옵션("c", "u", "e", "d", "a")
		 */
		"resetUpdatedItems": function(p_TargetGridId, p_Option) {
		    AUIGrid.resetUpdatedItems(p_TargetGridId, p_Option);
		},
		
		/**
		 * 그리드의 크기를 변경합니다.
		 * 
		 * 파라메터 설명
		 * 		 p_Width (Number) : 변경시키고자 하는 가로 사이즈
		 * 		 p_Height (Number) : 변경시키고자 하는 세로 사이즈
		 * 만약 파라메터 없이 resize 메소드 호출 시 부모 Div의 크기를 다시 계산하여 그에 맞게 사이즈를 변경합니다.
		 * 부모(조상) Div 가 보이지 않는 상태(display : none)인 경우 부모 Div 의 크기를 알 수 없습니다. 이런 경우 그리드는 기본 크기로 변경 시킵니다.
		 * 따라서 파라메터 없이 resize 메소드 호출 시는 반드시 부모 Div 가 DOM 영역에서 보여졌을 때 호출해야 합니다.
		 */
		"resize" : function(p_AuiGridId, p_Width, p_Height) {
			if (p_AuiGridId != null && String(p_AuiGridId).trim() !== '') {
				var hasWidth = p_Width != null && String(p_Width).trim() !== '';
		        var hasHeight = p_Height != null && String(p_Height).trim() !== '';

		        if (hasWidth && hasHeight) {
		            AUIGrid.resize(p_AuiGridId, p_Width, p_Height);
		        } else if (hasWidth) {
		            AUIGrid.resize(p_AuiGridId, p_Width);
		        } else if (hasHeight) {
		            AUIGrid.resize(p_AuiGridId, undefined, p_Height);
		        } else {
		            AUIGrid.resize(p_AuiGridId);
		        }
			}
		},
		
		/**
		 * 지정한 셀의 수정 내용을 취소하고 최초 값으로 복구합니다.
		 *
		 * 파라미터 설명
		 *  - p_Cells (Array or String) : 복구할 셀 정보 배열 또는 "selectedIndex"
		 */
		"restoreEditedCells": function(p_TargetGridId, p_Cells) {
		    AUIGrid.restoreEditedCells(p_TargetGridId, p_Cells);
		},
		
		/**
		 * 그리드의 행을 수정한 해당 행 전체 셀 값을 수정 취소(복구) 합니다.
		 * 수정 취소(복구)는 최초 그리드에 삽입된 행의 셀 값들로 되돌립니다.
		 * 
		 * 파라메터 설명
		 * 	  p_DeleteTargetRowId : (Number or Array or String) : 복구할 행 인덱스, 행 인덱스 배열 또는 "selectedIndex"
		 *     -> 삭제하고자 하는 행 고유 값(rowIdField 값). 만약 복수를 삭제하고자 할 때 rowId 값을 배열로
		 */
		"restoreEditedRows": function(p_AuiGridId, p_RestoreTargetIndex_Array) {
			
			var rowIndexes = p_RestoreTargetIndex_Array;

            // 숫자 또는 숫자형 문자열 1건 처리
            if ((typeof rowIndexes === "number" && Number.isInteger(rowIndexes)) ||
                (typeof rowIndexes === "string" && rowIndexes.trim() !== "" && Number.isInteger(Number(rowIndexes)))) {
                rowIndexes = [Number(rowIndexes)];

            } else if (Array.isArray(rowIndexes)) {
                var converted = rowIndexes.map(function(item) {
                    if (
                        (typeof item === "number" && Number.isInteger(item)) ||
                        (typeof item === "string" && item.trim() !== "" && Number.isInteger(Number(item)))
                    ) {
                        return Number(item);
                    }
                    return null;
                });

                var isValidArray = converted.every(function(item) {
                    return item !== null;
                });

                if (!isValidArray) {
                    console.warn("removeRow: 배열 안에 숫자로 변환할 수 없는 값이 포함되어 있습니다.", rowIndexes);
                    return false;
                }

                rowIndexes = converted;
            } else {
                console.warn("removeRow: row index는 숫자, 숫자형 문자열, 또는 그 배열만 가능합니다.", rowIndexes);
                return false;
            }
			return AUIGrid.restoreEditedRows(p_AuiGridId, rowIndexes);
			
		},
		
		/**
		 * 소프트 삭제 상태의 행을 복구합니다.
		 *
		 * 파라미터 설명
		 *  - p_Option (Number or Array or String) : "selectedIndex", "all", 행 인덱스 또는 행 인덱스 배열
		 */
		"restoreSoftRows": function(p_TargetGridId, p_Option) {
		    AUIGrid.restoreSoftRows(p_TargetGridId, p_Option);
		},
		
		/**
		 * 행 고유 값(rowId)에 해당하는 행 인덱스를 반환합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowId (String) : 행 고유 값(rowId)
		 *
		 * Return : (Number) 행 인덱스
		 */
		"rowIdToIndex": function(p_TargetGridId, p_RowId) {
		    return AUIGrid.rowIdToIndex(p_TargetGridId, p_RowId);
		},

		/**
		 * 그리드의 특정 컬럼에서 문자열을 검색합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 검색할 컬럼의 dataField명
		 *  - p_Term (String) : 검색할 문자열
		 *  - p_Options (Object, Optional) : 검색 옵션
		 */
		"search": function(p_TargetGridId, p_DataField, p_Term, p_Options) {
		    AUIGrid.search(p_TargetGridId, p_DataField, p_Term, p_Options);
		},
		
		/**
		 * 그리드의 전체 컬럼을 대상으로 문자열을 검색합니다.
		 *
		 * 파라미터 설명
		 *  - p_Term (String) : 검색할 문자열
		 *  - p_Options (Object, Optional) : 검색 옵션
		 */
		"searchAll": function(p_TargetGridId, p_Term, p_Options) {
		    AUIGrid.searchAll(p_TargetGridId, p_Term, p_Options);
		},
		
		/**
		 * 행 고유 값(rowId)을 이용하여 특정 행 아이템을 선택합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIds (Array or String) : 선택할 행 고유 값 또는 행 고유 값 배열
		 */
		"selectRowsByRowId": function(p_TargetGridId, p_RowIds) {
		    AUIGrid.selectRowsByRowId(p_TargetGridId, p_RowIds);
		},
		
		/**
		 * 모든 행의 체크박스 상태를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Checked (Boolean) : true인 경우 전체 선택, false인 경우 전체 해제
		 */
		"setAllCheckedRows": function(p_TargetGridId, p_Checked) {
		    AUIGrid.setAllCheckedRows(p_TargetGridId, p_Checked);
		},
		
		/**
		 * 셀 병합 기능을 활성화하거나 비활성화합니다.
		 *
		 * 파라미터 설명
		 *  - p_Flag (Boolean) : true인 경우 활성화, false인 경우 비활성화
		 */
		"setCellMerge": function(p_TargetGridId, p_Flag) {
		    AUIGrid.setCellMerge(p_TargetGridId, p_Flag);
		},
		
		/**
		 * 지정한 셀의 값을 변경합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 변경할 행 인덱스
		 *  - p_DataFieldOrColumnIndex (String or Number) : 변경할 컬럼의 dataField 또는 컬럼 인덱스
		 *  - p_Value (Object) : 변경할 값
		 */
		"setCellValue": function(p_TargetGridId, p_RowIndex, p_DataFieldOrColumnIndex, p_Value) {
		    AUIGrid.setCellValue(
		        p_TargetGridId,
		        p_RowIndex,
		        p_DataFieldOrColumnIndex,
		        p_Value
		    );
		},
		
		/**
		 * 행 고유 값(rowId)을 이용하여 체크된 행을 설정합니다.
		 *
		 * 기존 체크 상태는 제거되고 전달한 행만 체크됩니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIds (Array) : 체크할 행 고유 값 배열
		 */
		"setCheckedRowsByIds": function(p_TargetGridId, p_RowIds) {
		    AUIGrid.setCheckedRowsByIds(p_TargetGridId, p_RowIds);
		},
		
		/**
		 * 특정 컬럼의 값과 일치하는 행을 체크합니다.
		 *
		 * 기존 체크 상태는 제거되고 전달한 값과 일치하는 행만 체크됩니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 체크 조건으로 사용할 컬럼의 dataField명
		 *  - p_Values (Array or String) : 체크할 값 또는 값 배열
		 */
		"setCheckedRowsByValue": function(p_TargetGridId, p_DataField, p_Values) {
		    AUIGrid.setCheckedRowsByValue(p_TargetGridId, p_DataField, p_Values);
		},
		
		/**
		 * 그룹 컬럼에 속한 자식 컬럼의 출력 순서를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataFields (Array) : 자식 컬럼의 출력 순서를 나타내는 dataField 배열
		 */
		"setColumnChildOrder": function(p_TargetGridId, p_DataFields) {
		    AUIGrid.setColumnChildOrder(p_TargetGridId, p_DataFields);
		},
		
		/**
		 * 그리드 컬럼의 출력 순서를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataFields (Array) : 컬럼의 출력 순서를 나타내는 dataField 배열
		 */
		"setColumnOrder": function(p_TargetGridId, p_DataFields) {
		    AUIGrid.setColumnOrder(p_TargetGridId, p_DataFields);
		},

		/**
		 * 지정한 컬럼 인덱스의 컬럼 속성을 변경합니다.
		 *
		 * 파라미터 설명
		 *  - p_ColumnIndex (Number) : 변경할 컬럼 인덱스
		 *  - p_PropObj (Object) : 변경할 컬럼 속성 정보
		 */
		"setColumnProp": function(p_TargetGridId, p_ColumnIndex, p_PropObj) {
		    AUIGrid.setColumnProp(p_TargetGridId, p_ColumnIndex, p_PropObj);
		},
		
		/**
		 * 지정한 dataField의 컬럼 속성을 변경합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 변경할 컬럼의 dataField
		 *  - p_PropObj (Object) : 변경할 컬럼 속성 정보
		 */
		"setColumnPropByDataField": function(p_TargetGridId, p_DataField, p_PropObj) {
		    AUIGrid.setColumnPropByDataField(p_TargetGridId, p_DataField, p_PropObj);
		},
		
		/**
		 * 컬럼의 가로 크기(width)를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_SizeList (Array) : 컬럼 너비 목록
		 */
		"setColumnSizeList": function(p_TargetGridId, p_SizeList) {
		    AUIGrid.setColumnSizeList(p_TargetGridId, p_SizeList);
		},
		
		/**
		 * CSV 문자열을 그리드 데이터로 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_CsvData (String) : CSV 데이터
		 *  - p_IsSimpleMode (Boolean, Optional) : 단순 CSV 여부
		 */
		"setCsvGridData": function(p_TargetGridId, p_CsvData, p_IsSimpleMode) {
		    AUIGrid.setCsvGridData(p_TargetGridId, p_CsvData, p_IsSimpleMode);
		},
		
		/**
		 * 편집 중인 셀의 Input 값을 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Value (Object) : 설정할 값
		 */
		"setEditingInputValue": function(p_TargetGridId, p_Value) {
		    AUIGrid.setEditingInputValue(p_TargetGridId, p_Value);
		},
		
		/**
		 * 지정한 컬럼에 필터를 설정하고 실행합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 컬럼의 dataField
		 *  - p_FilterFunction (Function) : 필터 함수
		 */
		"setFilter": function(p_TargetGridId, p_DataField, p_FilterFunction) {
		    AUIGrid.setFilter(p_TargetGridId, p_DataField, p_FilterFunction);
		},
		
		/**
		 * 지정한 값으로 컬럼 필터를 설정하고 실행합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 컬럼의 dataField
		 *  - p_Values (String or Array) : 필터링할 값 또는 값 배열
		 */
		"setFilterByValues": function(p_TargetGridId, p_DataField, p_Values) {
		    AUIGrid.setFilterByValues(p_TargetGridId, p_DataField, p_Values);
		},
		
		/**
		 * 필터 캐시 정보를 적용하여 필터를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Cache (Object) : 필터 캐시 정보
		 */
		"setFilterCache": function(p_TargetGridId, p_Cache) {
		    AUIGrid.setFilterCache(p_TargetGridId, p_Cache);
		},
		
		/**
		 * 인라인 필터의 텍스트를 설정하여 필터를 적용합니다.
		 *
		 * 파라미터 설명
		 *  - p_InlineTexts (Array) : 인라인 필터 텍스트 정보
		 */
		"setFilterInlineTexts": function(p_TargetGridId, p_InlineTexts) {
		    AUIGrid.setFilterInlineTexts(p_TargetGridId, p_InlineTexts);
		},


		/**
		 * 고정 컬럼(FixedColumn) 개수를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Count (Number) : 고정 컬럼 개수
		 */
		"setFixedColumnCount": function(p_TargetGridId, p_Count) {
		    AUIGrid.setFixedColumnCount(p_TargetGridId, p_Count);
		},
		
		/**
		 * 고정 행(FixedRow) 개수를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Count (Number) : 고정 행 개수
		 */
		"setFixedRowCount": function(p_TargetGridId, p_Count) {
		    AUIGrid.setFixedRowCount(p_TargetGridId, p_Count);
		},
		
		/**
		 * 그리드에 키보드 포커스를 설정합니다.
		 */
		"setFocus": function(p_TargetGridId) {
		    AUIGrid.setFocus(p_TargetGridId);
		},
		
		/**
		 * 그리드의 푸터 레이아웃을 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_FooterLayout (Array) : 푸터 레이아웃
		 */
		"setFooter": function(p_TargetGridId, p_FooterLayout) {
		    AUIGrid.setFooter(p_TargetGridId, p_FooterLayout);
		},
		
		/**
		 * 그리드 데이터를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Data (Array) : 그리드 데이터
		 */
		"setGridData": function(p_TargetGridId, p_Data) {
		    AUIGrid.setGridData(p_TargetGridId, p_Data);
		},
		
		/**
		 * 지정한 필드로 그룹핑을 수행합니다.
		 *
		 * 파라미터 설명
		 *  - p_GroupingFields (Array) : 그룹핑할 필드 목록
		 *  - p_GroupingSummary (Object, Optional) : 그룹핑 소계 정보
		 */
		"setGroupBy": function(p_TargetGridId, p_GroupingFields, p_GroupingSummary) {
		    AUIGrid.setGroupBy(p_TargetGridId, p_GroupingFields, p_GroupingSummary);
		},
		
		/**
		 * 지정한 컬럼의 HeaderRenderer 속성을 변경합니다.
		 *
		 * 파라미터 설명
		 *  - p_ColumnIndex (Number) : 컬럼 인덱스
		 *  - p_PropObj (Object) : HeaderRenderer 속성 정보
		 */
		"setHeaderRendererProp": function(p_TargetGridId, p_ColumnIndex, p_PropObj) {
		    AUIGrid.setHeaderRendererProp(p_TargetGridId, p_ColumnIndex, p_PropObj);
		},
		
		/**
		 * 지정한 dataField의 HeaderRenderer 속성을 변경합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 컬럼의 dataField
		 *  - p_PropObj (Object) : HeaderRenderer 속성 정보
		 */
		"setHeaderRendererPropByDataField": function(p_TargetGridId, p_DataField, p_PropObj) {
		    AUIGrid.setHeaderRendererPropByDataField(p_TargetGridId, p_DataField, p_PropObj);
		},
		
		/**
		 * 마우스 Hover 모드를 변경합니다.
		 *
		 * 파라미터 설명
		 *  - p_HoverMode (String) : Hover 모드("singleCell", "singleRow", "none")
		 */
		"setHoverMode": function(p_TargetGridId, p_HoverMode) {
		    AUIGrid.setHoverMode(p_TargetGridId, p_HoverMode);
		},
		
		/**
		 * 수평 스크롤을 지정한 컬럼 인덱스로 이동합니다.
		 *
		 * 파라미터 설명
		 *  - p_ColumnIndex (Number) : 컬럼 인덱스
		 */
		"setHScrollPosition": function(p_TargetGridId, p_ColumnIndex) {
		    AUIGrid.setHScrollPosition(p_TargetGridId, p_ColumnIndex);
		},
		
		/**
		 * 수평 스크롤을 지정한 픽셀 위치로 이동합니다.
		 *
		 * 파라미터 설명
		 *  - p_Pixel (Number) : 픽셀 위치
		 */
		"setHScrollPositionByPx": function(p_TargetGridId, p_Pixel) {
		    AUIGrid.setHScrollPositionByPx(p_TargetGridId, p_Pixel);
		},
		
		/**
		 * 그리드 안내 메시지를 설정합니다.
		 *
		 * @deprecated Ver 3.0.4
		 */
		"setInfoMessage": function(p_TargetGridId) {
		    AUIGrid.setInfoMessage(p_TargetGridId);
		},
		
		/**
		 * 페이지당 출력할 행 개수를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_PageRowCount (Number) : 페이지당 행 개수
		 */
		"setPageRowCount": function(p_TargetGridId, p_PageRowCount) {
		    AUIGrid.setPageRowCount(p_TargetGridId, p_PageRowCount);
		},

		
		/**
		 * 페이지당 출력할 행 개수를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_props (Object) : 복수인 경우 속성명과 속성값이 각각 key-value 를 이루는 object, 1개의 속성인 경우 속성명
		 *            => API 문서 참조
		 *  - p_value (Object) : 1개의 속성 값 변경을 위한 파라메터로 1개의 속성의 새로운 값에 해당됩니다.(복수인 경우 의미없음)
		 */
		"setProp": function(p_TargetGridId, p_props, p_value) {
		    AUIGrid.setProp(p_TargetGridId, p_props, p_value);
		},

		/**
		 * 지정한 컬럼의 renderer 속성을 변경합니다.
		 *
		 * 파라미터 설명
		 *  - p_ColumnIndex (Number) : 컬럼 인덱스
		 *  - p_PropObj (Object) : renderer 속성 정보
		 */
		"setRendererProp": function(p_TargetGridId, p_ColumnIndex, p_PropObj) {
		    AUIGrid.setRendererProp(p_TargetGridId, p_ColumnIndex, p_PropObj);
		},
		
		/**
		 * 지정한 행이 최상단에 오도록 스크롤을 이동합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowPosition (Number) : 행 인덱스
		 */
		"setRowPosition": function(p_TargetGridId, p_RowPosition) {
		    AUIGrid.setRowPosition(p_TargetGridId, p_RowPosition);
		},
		
		/**
		 * 그리드의 Scale 값을 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_ScaleFactor (Number) : Scale 값
		 */
		"setScaleFactor": function(p_TargetGridId, p_ScaleFactor) {
		    AUIGrid.setScaleFactor(p_TargetGridId, p_ScaleFactor);
		},
		
		/**
		 * 그리드 전체를 선택합니다.
		 */
		"setSelectionAll": function(p_TargetGridId) {
		    AUIGrid.setSelectionAll(p_TargetGridId);
		},
		
		/**
		 * 셀 선택 블록을 지정합니다.
		 *
		 * 파라미터 설명
		 *  - p_StartRowIndex (Number) : 시작 행 인덱스
		 *  - p_EndRowIndex (Number) : 종료 행 인덱스
		 *  - p_StartColumnIndex (Number) : 시작 열 인덱스
		 *  - p_EndColumnIndex (Number) : 종료 열 인덱스
		 */
		"setSelectionBlock": function(p_TargetGridId, p_StartRowIndex, p_EndRowIndex, p_StartColumnIndex, p_EndColumnIndex) {
		    AUIGrid.setSelectionBlock(p_TargetGridId, p_StartRowIndex, p_EndRowIndex, p_StartColumnIndex, p_EndColumnIndex);
		},
		
		/**
		 * 지정한 셀 또는 행을 선택합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 행 인덱스
		 *  - p_ColumnIndex (Number, Optional) : 열 인덱스
		 */
		"setSelectionByIndex": function(p_TargetGridId, p_RowIndex, p_ColumnIndex) {
		    AUIGrid.setSelectionByIndex(p_TargetGridId, p_RowIndex, p_ColumnIndex);
		},
		
		/**
		 * 지정한 컬럼 범위를 선택합니다.
		 *
		 * 파라미터 설명
		 *  - p_StartColIdx (Number) : 시작 컬럼 인덱스
		 *  - p_EndColIdx (Number) : 종료 컬럼 인덱스
		 */
		"setSelectionColumn": function(p_TargetGridId, p_StartColIdx, p_EndColIdx) {
		    AUIGrid.setSelectionColumn(p_TargetGridId, p_StartColIdx, p_EndColIdx);
		},
		
		/**
		 * 선택 모드를 변경합니다.
		 *
		 * 파라미터 설명
		 *  - p_SelectionMode (String) : 선택 모드
		 */
		"setSelectionMode": function(p_TargetGridId, p_SelectionMode) {
		    AUIGrid.setSelectionMode(p_TargetGridId, p_SelectionMode);
		},
		
		/**
		 * 정렬 비교 객체(Intl.Collator)를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Collator (Intl.Collator) : 정렬 비교 객체
		 */
		"setSortCollator": function(p_TargetGridId, p_Collator) {
		    AUIGrid.setSortCollator(p_TargetGridId, p_Collator);
		},
		
		/**
		 * 정렬을 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_SortingInfo (Array) : 정렬 정보
		 *  - p_OnlyLastDepthSorting (Boolean, Optional) : 마지막 Depth만 정렬 여부
		 */
		"setSorting": function(p_TargetGridId, p_SortingInfo, p_OnlyLastDepthSorting) {
		    AUIGrid.setSorting(p_TargetGridId, p_SortingInfo, p_OnlyLastDepthSorting);
		},
		
		/**
		 * XML 데이터를 설정합니다.
		 *
		 * 파라미터 설명
		 *  - p_XmlData (Object) : XML 데이터
		 *  - p_TagName (String, Optional) : 행 태그명
		 */
		"setXmlGridData": function(p_TargetGridId, p_XmlData, p_TagName) {
		    AUIGrid.setXmlGridData(p_TargetGridId, p_XmlData, p_TagName);
		},
		
		/**
		 * 그리드에 프리로더를 표시합니다.
		 */
		"showAjaxLoader": function(p_TargetGridId) {
		    AUIGrid.showAjaxLoader(p_TargetGridId);
		},
		
		/**
		 * 숨겨진 모든 컬럼을 표시합니다.
		 */
		"showAllColumns": function(p_TargetGridId) {
		    AUIGrid.showAllColumns(p_TargetGridId);
		},

		/**
		 * 지정한 dataField 컬럼을 표시합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String|Array) : 표시할 dataField
		 */
		"showColumnByDataField": function(p_TargetGridId, p_DataField) {
		    AUIGrid.showColumnByDataField(p_TargetGridId, p_DataField);
		},
		
		/**
		 * 지정한 컬럼 그룹을 표시합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : 그룹 dataField
		 */
		"showColumnGroup": function(p_TargetGridId, p_DataField) {
		    AUIGrid.showColumnGroup(p_TargetGridId, p_DataField);
		},
		
		/**
		 * 엑스트라 컬럼을 표시합니다.
		 *
		 * 파라미터 설명
		 *  - p_PropName (String) : 엑스트라 컬럼 속성명
		 */
		"showExtraColumn": function(p_TargetGridId, p_PropName) {
		    AUIGrid.showExtraColumn(p_TargetGridId, p_PropName);
		},
		
		/**
		 * Footer를 표시합니다.
		 */
		"showFooterLater": function(p_TargetGridId) {
		    AUIGrid.showFooterLater(p_TargetGridId);
		},
		
		/**
		 * 그리드에 안내 메시지를 표시합니다.
		 *
		 * 파라미터 설명
		 *  - p_MsgHTML (String) : 표시할 HTML 메시지
		 */
		"showInfoMessage": function(p_TargetGridId, p_MsgHTML) {
		    AUIGrid.showInfoMessage(p_TargetGridId, p_MsgHTML);
		},
		
		/**
		 * 지정한 Depth까지 트리 데이터를 펼칩니다.
		 *
		 * 파라미터 설명
		 *  - p_Depth (Number) : 표시할 Depth
		 */
		"showItemsOnDepth": function(p_TargetGridId, p_Depth) {
		    AUIGrid.showItemsOnDepth(p_TargetGridId, p_Depth);
		},
		
		/**
		 * 특정 셀에 Toast 메시지를 표시합니다.
		 *
		 * 파라미터 설명
		 *  - p_RowIndex (Number) : 행 인덱스
		 *  - p_ColumnIndex (Number) : 열 인덱스
		 *  - p_Message (String) : 메시지
		 */
		"showToastMessage": function(p_TargetGridId, p_RowIndex, p_ColumnIndex, p_Message) {
		    AUIGrid.showToastMessage(p_TargetGridId, p_RowIndex, p_ColumnIndex, p_Message);
		},
		
		/**
		 * 상태 정보를 포함하여 데이터를 동기화합니다.
		 *
		 * 파라미터 설명
		 *  - p_Data (Array) : 데이터
		 *  - p_Cache (Object) : 상태 캐시
		 */
		"syncGridData": function(p_TargetGridId, p_Data, p_Cache) {
		    AUIGrid.syncGridData(p_TargetGridId, p_Data, p_Cache);
		},
		
		/**
		 * 이벤트를 해제합니다.
		 *
		 * 파라미터 설명
		 *  - p_Type (String|Array) : 이벤트 타입
		 */
		"unbind": function(p_TargetGridId, p_Type) {
		    AUIGrid.unbind(p_TargetGridId, p_Type);
		},
		
		/**
		 * Undo를 실행합니다.
		 */
		"undo": function(p_TargetGridId) {
		    AUIGrid.undo(p_TargetGridId);
		},
		
		/**
		 * Undo 가능 여부를 반환합니다.
		 */
		"undoable": function(p_TargetGridId) {
		    return AUIGrid.undoable(p_TargetGridId);
		},
		
		/**
		 * 셀 내용을 갱신합니다.
		 */
		"update": function(p_TargetGridId) {
		    AUIGrid.update(p_TargetGridId);
		},
		
		/**
		 * 특정 컬럼 값을 전체 데이터에 일괄 적용합니다.
		 *
		 * 파라미터 설명
		 *  - p_DataField (String) : dataField
		 *  - p_Value (Object) : 변경 값
		 */
		"updateAllToValue": function(p_TargetGridId, p_DataField, p_Value) {
		    AUIGrid.updateAllToValue(p_TargetGridId, p_DataField, p_Value);
		},
		
		/**
		 * 모든 expFunction을 다시 계산합니다.
		 */
		"updateExpFuncAll": function(p_TargetGridId) {
		    AUIGrid.updateExpFuncAll(p_TargetGridId);
		},
		
		/**
		 * 그룹핑 및 Summary를 다시 계산합니다.
		 */
		"updateGrouping": function(p_TargetGridId) {
		    AUIGrid.updateGrouping(p_TargetGridId);
		},

		/**
		 * 그리드의 특정 행 아이템을 수정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Item (Object) : 수정할 행 아이템
		 *  - p_RowIndex (Number or String) : 수정할 행 인덱스 또는 "selectedIndex"
		 *  - p_IsMarkEdited (Boolean, Optional) : 수정 상태 표시 여부 (기본값 : true)
		 */
		"updateRow": function(p_TargetGridId, p_Item, p_RowIndex, p_IsMarkEdited) {
		    AUIGrid.updateRow(
		        p_TargetGridId,
		        p_Item,
		        p_RowIndex,
		        p_IsMarkEdited
		    );
		},
		
		/**
		 * 지정한 행 범위의 특정 필드 값을 일괄 변경합니다.
		 *
		 * 파라미터 설명
		 *  - p_StartRowIndex (Number) : 시작 행 인덱스
		 *  - p_EndRowIndex (Number) : 종료 행 인덱스
		 *  - p_DataFields (String or Array) : 변경할 dataField 또는 dataField 배열
		 *  - p_Values (Object or Array) : 변경할 값 또는 값 배열
		 */
		"updateRowBlockToValue": function(p_TargetGridId, p_StartRowIndex, p_EndRowIndex, p_DataFields, p_Values) {
		    AUIGrid.updateRowBlockToValue(
		        p_TargetGridId,
		        p_StartRowIndex,
		        p_EndRowIndex,
		        p_DataFields,
		        p_Values
		    );
		},
		
		/**
		 * 지정한 여러 행 아이템을 일괄 수정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Items (Array) : 수정할 행 아이템 배열
		 *  - p_RowIndexes (Array) : 수정할 행 인덱스 배열
		 *  - p_IsMarkEdited (Boolean, Optional) : 수정 상태 표시 여부 (기본값 : true)
		 */
		"updateRows": function(p_TargetGridId, p_Items, p_RowIndexes, p_IsMarkEdited) {
		    AUIGrid.updateRows(
		        p_TargetGridId,
		        p_Items,
		        p_RowIndexes,
		        p_IsMarkEdited
		    );
		},
		
		/**
		 * 행 고유 값(rowId)을 이용하여 하나 또는 여러 행을 수정합니다.
		 *
		 * 파라미터 설명
		 *  - p_Items (Array or Object) : 수정할 행 아이템 또는 행 아이템 배열
		 *  - p_IsMarkEdited (Boolean, Optional) : 수정 상태 표시 여부 (기본값 : true)
		 */
		"updateRowsById": function(p_TargetGridId, p_Items, p_IsMarkEdited) {
		    AUIGrid.updateRowsById(
		        p_TargetGridId,
		        p_Items,
		        p_IsMarkEdited
		    );
		},
		
		/**
		 * 수정되거나 추가된 행의 필수 입력값을 검사합니다.
		 *
		 * 파라미터 설명
		 *  - p_RequireFields (String or Array) : 필수 입력 dataField 또는 dataField 배열
		 *  - p_Message (String, Optional) : 유효성 검사 실패 시 표시할 메시지
		 *
		 * Return : (Boolean) 유효성 검사 통과 여부
		 */
		"validateChangedGridData": function(p_TargetGridId, p_RequireFields, p_Message) {
		    return AUIGrid.validateChangedGridData(
		        p_TargetGridId,
		        p_RequireFields,
		        p_Message
		    );
		},
		
		/**
		 * 그리드 전체 데이터의 필수 입력값을 검사합니다.
		 *
		 * 파라미터 설명
		 *  - p_RequireFields (String or Array) : 필수 입력 dataField 또는 dataField 배열
		 *  - p_Message (String, Optional) : 유효성 검사 실패 시 표시할 메시지
		 *
		 * Return : (Boolean) 유효성 검사 통과 여부
		 */
		"validateGridData": function(p_TargetGridId, p_RequireFields, p_Message) {
		    return AUIGrid.validateGridData(
		        p_TargetGridId,
		        p_RequireFields,
		        p_Message
		    );
		},
		
		/**
		 * 사용자 정의 검사 함수를 이용하여 그리드 데이터의 유효성을 검사합니다.
		 *
		 * 파라미터 설명
		 *  - p_RequireFields (String or Array) : 검사할 dataField 또는 dataField 배열
		 *  - p_ValidFunc (Function) : 유효성 검사 함수
		 *  - p_Message (String, Optional) : 유효성 검사 실패 시 표시할 메시지
		 *  - p_OnlyByFunc (Boolean, Optional) : validFunc의 반환값만으로 검사할지 여부
		 *
		 * Return : (Boolean) 유효성 검사 통과 여부
		 */
		"validateGridDataByFunc": function(p_TargetGridId, p_RequireFields, p_ValidFunc, p_Message, p_OnlyByFunc) {
		    return AUIGrid.validateGridDataByFunc(
		        p_TargetGridId,
		        p_RequireFields,
		        p_ValidFunc,
		        p_Message,
		        p_OnlyByFunc
		    );
		},
		
		/**================================================================================================================== 
		 *  
		 * 여기서 부터는 CUSTOM FUCNTION 
		 * ================================================================================================================== 
		 * **/

  		/**
         * 리드에 출력된 현재 데이터를 다운로드 가능한 요청 형태로 다운로드 한다.	
         * xlsx, csv, txt, xml, json
         * Return : 요청한 형태의  파일 
         */
        "exportTo": function(p_AuiGridId, p_ExportType) {
            switch (p_ExportType) {
                case "xlsx":
                    AUIGrid.exportToXlsx(p_AuiGridId, {
                        exportWithStyle: false
                    });
                    break;
                case "csv":
                    AUIGrid.exportToCsv(p_AuiGridId);
                    break;
                case "txt":
                    AUIGrid.exportToTxt(p_AuiGridId);
                    break;
                case "xml":
                    AUIGrid.exportToXml(p_AuiGridId);
                    break;
                case "json":
                    AUIGrid.exportToJson(p_AuiGridId);
                    break;
            }
        },
        
		"remove": function(p_AuiGridId) {
            AUIGrid.destroy("#" + p_AuiGridId);
        },
		
        /**
		 * 그리드에 데이터를 로드 합니다.
		 * Auigrid 데이터 조회
		 */
		"retrieve": function (p_TargetGridId, p_RetrieveUrl, p_Params) {

		    if (!p_TargetGridId || typeof p_TargetGridId !== "string") {
		        console.warn("[retrieve] p_TargetGridId 값이 올바르지 않습니다.", p_TargetGridId);
		        return;
		    }

		    if (!p_RetrieveUrl || typeof p_RetrieveUrl !== "string") {
		        console.warn("[retrieve] p_RetrieveUrl 값이 올바르지 않습니다.", p_RetrieveUrl);
		        return;
		    }

		    if (typeof AUIGrid === "undefined" || typeof AUIGrid.setGridData !== "function") {
		        console.error("[retrieve] AUIGrid를 사용할 수 없습니다.");
		        return;
		    }

		    if (p_Params == null || typeof p_Params !== "object" || $.isEmptyObject(p_Params)) {
		        p_Params = { dummy: "dummy" };
		    }

		    KpackageOBJ.ajax.doSubmit(p_RetrieveUrl, p_Params, function (result) {
		        var gridData = [];

		        if (result && Array.isArray(result.value)) {
		            gridData = result.value;
		        } else {
		            console.warn("[retrieve] result.value가 배열이 아닙니다.", result);
		        }

		        AUIGrid.setGridData(p_TargetGridId, gridData);
		    });
			
		},
		

        /**
         * 그리드에서 수정된 데이터만 선별해서 가져온다.
         * 
         * Return : (Array) 상태 정보가 포함된 현재 그리드 행 아이템들
         */
        "getGridCudData": function(p_AuiGridId) {
       		return  AUIGrid.getGridDataWithState(p_AuiGridId, "state", { added: "a", removed: "r", edited: "e" }).filter(item => item.state != null);
        },
        
        "getRowCountWithoutSoftRemove": function(p_TargetGridId) {
		   const gridData = AUIGrid.getGridDataWithState(p_TargetGridId, "state", { added: "a", removed: "r", edited: "e" }).filter(item => item.state != 'r');
		   
		   return gridData.length;
		},
        

		/**
         * 선택 모드(selectionMode)가 "none" 이 아닌 경우 현재 선택된 모든 셀(또는 행) 아이템을 반환합니다.
         * 
         * Return : (Array) 상태 정보가 포함된 현재 그리드 행 아이템들
         */
        "getSelectRowData": function(p_AuiGridId) {
			var rowArray = AUIGrid.getSelectedItems(p_AuiGridId);
			
            return rowArray[0]["item"];
        },


		/**
		 * 선택 모드(selectionMode)가 "none" 이 아닌 경우 현재 선택된 row Index 반환합니다.
		 * 
		 * Return : 숫자 행번호 (0부터시작)
		 */
		"getSelectRowIndex": function(p_AuiGridId) {
			var rowArray = AUIGrid.getSelectedItems(p_AuiGridId);
						
			return rowArray[0]["rowIndex"];
		},

		/**
		 * 선택 모드(selectionMode)가 "none" 이 아닌 경우 현재 선택된 column의 index 반환합니다.
		 * 
		 * Return : 숫자 열번호 (0부터시작)
		 */
		"getSelectColIndex": function(p_AuiGridId) {
			var rowArray = AUIGrid.getSelectedItems(p_AuiGridId);
						
			return rowArray[0]["columnIndex"];
		},

    }

};

$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || "");
        } else {
            o[this.name] = this.value || "";
        }
    });
    return o;
};

function load_BlockUI(t) {
    if (t) {
        var target = $("body");

        if ($("#messageDIV").length > 0) {
            if ($("div[class='messageDIV']").length == 0) {
                target = $("#messageDIV");
            } else {
                target = $("div[class='messageDIV']").eq(
                    $("div[class='messageDIV']").length - 1
                );
            }
        }

        var $DisableDiv =
            "<div id='disableDiv' class='disableDiv' style='display:none'></div>";
        var $LoadingDiv =
            "<div id='viewLoading' class='viewLoading'><img src='/resources/images2/loding_img/round_loading3.gif'></div> ";

        target.append($DisableDiv);
        target.append($LoadingDiv);

        var yp = target.scrollTop();
        var xp = target.scrollLeft();
        var ws = target.innerWidth();
        var hs = target.innerHeight();
        target.find("#disableDiv").css({
            width: "100%",
            height: hs,
        });
        target.find("#viewLoading").css("top", yp + hs / 2 - 100);
        target.find("#viewLoading").css("left", xp + ws / 2 - 100);
        target.find("#disableDiv").show();
        target.find("#viewLoading").show();
    } else {
        $("#disableDiv").hide().remove();
        $("#viewLoading").hide().remove();
    }
}

function load_BlockUI2(t) {
    if (t == undefined) {
        t = true;
    }
    if (t) {
        var target = $("body");

        if ($("#messageDIV").length > 0) {
            if ($("div[class='messageDIV']").length == 0) {
                target = $("#messageDIV");
            } else {
                target = $("div[class='messageDIV']").eq(
                    $("div[class='messageDIV']").length - 1
                );
            }
        }
        var $DisableDiv =
            "<div id='disableDiv' class='disableDiv' style='display:none'></div>";
        /*var $LoadingDiv = "<div id='viewLoading' class='loading_spinner'></div> ";*/
        var $LoadingDiv =
            "<div id='viewLoading' class='loader_box'><div class='loader3'>" +
            /* Loading Image Area  Start */
            "<div class='spinner'>" +
            "<div class='piece a'></div><div class='piece b'></div><div class='piece c'></div><div class='piece d'> </div><div class='piece e'></div><div class='piece f'></div><div class='piece g'></div><div class='piece h'></div><div class='piece i'></div><div class='piece j'></div><div class='piece k'></div><div class='piece l'></div><div class='piece m'></div><div class='piece n'></div><div class='piece o'></div><div class='piece p'></div>" +
            "</div>" +
            /* Loading Image Area  End*/
            "</div></div> ";

        target.append($DisableDiv);
        target.append($LoadingDiv);

        var yp = target.scrollTop();
        var xp = target.scrollLeft();
        var ws = target.innerWidth();
        var hs = target.innerHeight();
        target.find("#disableDiv").css({
            width: "100%",
            height: hs,
        });
        target.find("#viewLoading").css("top", yp + hs / 2 - 40);
        target.find("#viewLoading").css("left", xp + ws / 2 - 70);

        target.find("#viewLoading").css("position", "absolute");
        target.find("#viewLoading").css("z-index", "999");

        target.find("#disableDiv").show();
        target.find("#viewLoading").show();
    } else {
        $("#disableDiv").hide().remove();
        $("#viewLoading").hide().remove();
    }
}

function load_BlockUI3(targetId, t) {
    if (targetId == undefined) {
        load_BlockUI2();
        return;
    }

    if (t == undefined) {
        t = true;
    }

    if (t) {
        var target = $("#" + targetId);
        var $DisableDiv =
            "<div id='disableDiv' class='disableDiv' style='display:none'></div>";
        var $LoadingDiv =
            "<div id='viewLoading' class='loader_box'><div class='loader3'>" +
            /* Loading Image Area  Start */
            "<div class='spinner'>" +
            "<div class='piece a'></div><div class='piece b'></div><div class='piece c'></div><div class='piece d'> </div><div class='piece e'></div><div class='piece f'></div><div class='piece g'></div><div class='piece h'></div><div class='piece i'></div><div class='piece j'></div><div class='piece k'></div><div class='piece l'></div><div class='piece m'></div><div class='piece n'></div><div class='piece o'></div><div class='piece p'></div>" +
            "</div>" +
            /* Loading Image Area  End*/
            "</div></div> ";

        var yp = target.scrollTop();
        var xp = target.scrollLeft();
        var ws = target.innerWidth();
        var hs = $("#" + targetId).height() - 5;

        target.append($DisableDiv);
        target.append($LoadingDiv);
        target.find("#disableDiv").css({ width: "100%", height: hs });
        target.find("#viewLoading").css("top", yp + hs / 2 - 40);
        target.find("#viewLoading").css("left", xp + ws / 2 - 70);

        target.find("#viewLoading").css("position", "absolute");
        target.find("#viewLoading").css("z-index", "999");

        target.find("#disableDiv").show();
        target.find("#viewLoading").show();
    } else {
        $("#" + targetId + " #disableDiv")
            .hide()
            .remove();
        $("#" + targetId + " #viewLoading")
            .hide()
            .remove();
    }
}
$("body.menu-on-top .dspp_panel div.dspp_step").hover(function() {
    if ("dashBoard" !== $(this).prop("id")) {
        $(this).css("background-position", "-251px -55px");
        $(this).children("div").eq(0).addClass("subOn");
    }
});
$("body.menu-on-top .dspp_panel div.dspp_step").mouseleave(function() {
    if ("dashBoard" !== $(this).prop("id")) {
        $(this).children("div").eq(0).removeClass("subOn");

        if ($(this).hasClass("active") !== true) {
            $(this).css("background-position", "-251px -109px");
        }
    }
});
$("body.menu-on-top .dspp_panel div.dspp_step").click(function() {
    $("body.menu-on-top .dspp_panel div.dspp_step").each(function() {
        if ("dashBoard" !== $(this).prop("id")) {
            $(this).removeClass("active");
            $(this).css("background-position", "-251px -109px");
        }
    });
    if ("dashBoard" !== $(this).prop("id")) {
        $(this).css("background-position", "-251px -55px");
        $(this).addClass("active");
    }
});

/**************************** */
/** Navigation Create Start   */
/**************************** */
let nav;
const navElement = document.querySelector("#js-primary-nav");
if (navElement) {
    nav = new Navigation(navElement, {
        accordion: true,
        slideUpSpeed: 350,
        slideDownSpeed: 470,
        closedSign: '<i class="sa sa-chevron-down"></i>',
        openedSign: '<i class="sa sa-chevron-up"></i>',
        initClass: "js-nav-built",
        debug: false,
        instanceId: `nav-${Date.now()}`,
        maxDepth: 5,
        sanitize: true,
        animationTiming: "easeOutExpo",
        debounceTime: 0,
        onError: (error) => console.error("Navigation error:", error),
    });
}
/* Waves Effect : waves.js */
if (window.Waves) {
    Waves.attach(
        '.btn:not(.js-waves-off):not(.btn-switch):not(.btn-panel):not(.btn-system):not([data-action="playsound"]), .js-waves-on',
        ["waves-themed"]
    );
    Waves.init();
}

/** Navigation Create End */
var funcWorkFlag = 0; // tab 함수 중복 동작 제어용 변수
var debugState = true;
$(window).on("hashchange", function(e) {
    if (funcWorkFlag == 0) {
        console.log(1);
        funcWorkFlag = 1;
        checkURL(e);
    }
    funcWorkFlag = 0;
});

$("#js-nav-menu  a").on("click", function(e) {
    if (funcWorkFlag == 0) {
        funcWorkFlag = 1;
        console.log(window.document.URL);
        checkURL(e);
    }
    funcWorkFlag = 0;
});
function pageSetUp() {}

/*
 * CHECK TO SEE IF URL EXISTS
 */
function checkURL(e) {
    var url = location.href.split("#").splice(1).join("#");
    if (!url) {
        try {
            var documentUrl = window.document.URL;
            if (documentUrl) {
                if (
                    documentUrl.indexOf("#", 0) > 0 &&
                    documentUrl.indexOf("#", 0) < documentUrl.length + 1
                ) {
                    url = documentUrl.substring(documentUrl.indexOf("#", 0) + 1);
                }
            }
        } catch (err) {}
    }

    container = $("#contents");
    // Do this if url exists (for page refresh, etc...)
    if (url) {
        var menu_id, menu_title;

        $("#js-primary-nav a").each(function(elem) {
            if (this.href.indexOf(url) > -1) {
                menu_id = this.id;
                menu_title = this.title;
                return false;
            }
        });

        var pageLayerId = "cont_" + menu_id.replace("nav_", "");
        var tabButttonId = "tab_" + menu_id.replace("nav_", "");
        var clickMenuId = menu_id.replace("nav_", "");

        var workTabId = $("#mainPage_tab li.active").attr("id");
        if (workTabId && workTabId.indexOf(clickMenuId) > -1) {
            console.log("활성화 된 창 호출");
            return false;
        }

        $("main.app-body > div").each(function() {
            $("#" + this.id).hide();
        });

        if ($("#" + pageLayerId).length < 1) {
            /* Content Layer  생성 */
            $("main.app-body").append(
                '<div id="' + pageLayerId + '" class="app-content"></div>'
            );
            container = $("#" + pageLayerId);
            $("#" + pageLayerId).show();
            /* Tab Button 생성 */
            $("#mainPage_tab li").removeClass("active");
            var tabObj =
                '<li id="' +
                tabButttonId +
                '" name="header_tab" class="nav-item active" role="presentation">';
            tabObj =
                tabObj +
                '<a class="nav-link" href="javascript:tabChange(this, \'' +
                pageLayerId +
                '\')" style="float: left;">' +
                menu_title +
                " </a>";
            tabObj =
                tabObj +
                '<a class="nav-link" href="javascript:tabClose(\'' +
                pageLayerId +
                '\')" style="padding: 0px;padding-right: 2px;">x</a>';
            tabObj = tabObj + "</li>";
            $("#mainPage_tab").append(tabObj);
        } else {
            var tabBtnId = "tab_" + pageLayerId.replace("cont_", "");
            $("[name='header_tab']").removeClass("active");
            $("#" + tabBtnId).addClass("active");
            $("#" + pageLayerId).show();
            $("#" + pageLayerId)
                .css({ opacity: "0.0" })
                .delay(50)
                .animate({ opacity: "1.0" }, 300, function () {
			        $("#" + pageLayerId)
			            .find("[id*='oAuiGrid']")
			            .each(function () {
			                KpackageOBJ.auiGrid.resize("#" + this.id);
            });

    });

            return false;
        }

        // remove all active class
        $("nav li.active").removeClass("active");
        // match the url and add the active class
        $('nav li:has(a[href="' + url + '"])').addClass("active");
        var title = $('nav a[href="' + url + '"]').attr("title");

        // change page title from global var
        document.title = title || document.title;

        // debugState
        if (debugState) {
            console.log("Page title: %c " + document.title);
        }

        // parse url to jquery
        loadURL(url + location.search, container);
    } else {
        // grab the first URL from nav
        var $this = $('nav > ul > li:first-child > a[href!="#"]');

        //update hash
        window.location.hash = $this.attr("href");

        //clear dom reference
        $this = null;
    }
}
/*
 * LOAD AJAX PAGES
 */
function loadURL(url, container) {
    // debugState
    if (debugState) {
        console.log("Loading URL: %c" + url);
    }

    $.ajax({
        type: "GET",
        url: url,
        dataType: "html",
        cache: true, // (warning: setting it to false will cause a timestamp and will call the request twice)
        beforeSend: function() {
            // empty container and var to start garbage collection (frees memory)
            pagefunction = null;
            container.removeData().html("");

            // place cog
            container.html(
                '<h1 class="ajax-loading-animation"><i class="fa fa-cog fa-spin"></i> Loading...</h1>'
            );

            // Only draw breadcrumb if it is main content material
            if (container[0] == $("#content")[0]) {
                // clear everything else except these key DOM elements
                // we do this because sometime plugins will leave dynamic elements behind
                //$('body').find('> *').filter(':not(' + ignore_key_elms + ')').empty().remove();

                // draw breadcrumb
                //drawBreadCrumb();

                // scroll up
                $("html").animate(
                    {
                        scrollTop: 0,
                    },
                    "fast"
                );
            }
            // end if
        },
        success: function(data) {
            // dump data to container
            container
                .css({
                    opacity: "0.0",
                })
                .html(data)
                .delay(50)
                .animate(
                    {
                        opacity: "1.0",
                    },
                    300
                );

            // clear data var
            data = null;
            container = null;
        },
        error: function(xhr, status, thrownError, error) {
            container.html(
                '<h4 class="ajax-loading-error"><i class="fa fa-warning txt-color-orangeDark"></i> Error requesting <span class="txt-color-red">' +
                url +
                "</span>: " +
                xhr.status +
                ' <span style="text-transform: capitalize;">' +
                thrownError +
                "</span></h4>"
            );
        },
        async: true,
    });
}

/** Tab ctrl */
function tabChange(thisObj, contId) {
    var workTabId = $("#mainPage_tab li.active").attr("id");
    if (workTabId && workTabId.indexOf(contId.replace("cont_", "")) > -1) {
        console.log("활성화 된 창 호출");
        return false;
    }

    var tabBtnId = "tab_" + contId.replace("cont_", "");
    $("[name='header_tab']").removeClass("active");
    $("#" + tabBtnId).addClass("active");
    $("main.app-body > div").each(function() {
        $("#" + this.id).hide();
    });
    $("#" + contId).show();
    $("#" + contId)
        .css({ opacity: "0.0" })
        .delay(50)
        .animate({ opacity: "1.0" }, 300,  function () {
                // 현재 탭 안에 있는 AUIGrid만 resize
                $("#" + contId)
                    .find("[id*='oAuiGrid']")
                    .each(function () {
                        KpackageOBJ.auiGrid.resize("#" + this.id);
                    });
            });
}

function tabClose(contId) {
    var tabCount = $("#mainPage_tab li").length;
    if (tabCount < 2) {
        return false;
    }
    var tabBtnId = "tab_" + contId.replace("cont_", "");
    $("#" + tabBtnId).remove();
    $("#" + contId).remove();
}

function toggleSearchMore(p_Object, p_SearchMoreID){
	
	
	var $btn = $(p_Object);
	
	var $searchMore = $('#'+ p_SearchMoreID);
	
	
	if ($searchMore.length === 0) {
		console.warn("<"+p_SearchMoreID+"> 고급검색조건이 구성되지 않아 작동을 중지합니다.");
	    return; // 객체 없으면 중단
	}
	
	if ($searchMore.is(':visible')) {
	    $searchMore.slideUp(300);   // 보이는 상태면 닫기
		$btn.text("More");
	} else {
	    $searchMore.slideDown(300); // 숨김 상태면 열기
		$btn.text("Close");
	}
	
}


/**
 * 랜덤으로 실수형태의 값을 리턴
 * 
 */
function randFloat(min, max, fixed) {
	
	if (min > max) {
	    throw new Error("min은 max보다 클 수 없습니다.");
	}

	if (fixed == null || String(fixed).trim() === "") {
	    min = Math.ceil(min);
	    max = Math.floor(max);
	    return Math.floor(Math.random() * (max - min + 1)) + min;
	}

	return Number((Math.random() * (max - min) + min).toFixed(fixed));
}


