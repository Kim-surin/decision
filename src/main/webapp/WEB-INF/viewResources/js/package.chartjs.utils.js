/**
 * ChartUtil
 * ------------------------------------------------------------------
 * Chart.js 공통 유틸 모듈
 *
 * [기능]
 * - 차트 생성 / 삭제 / 재생성 / update
 * - bar, line, pie, doughnut, horizontalBar, stackedBar, radar, polarArea 생성
 * - mixed chart / floating bar 생성
 * - labels / datasets / data 조작
 * - appendDataset / appendData / removeData / clearData
 * - AJAX 응답 데이터를 Chart.js 형식으로 변환하는 adapter 제공
 * - 클릭/더블클릭/hover 이벤트 바인딩 지원
 * - 랜덤 데이터 helper 내장
 *
 * [필수]
 * - Chart.js
 * - jQuery($.extend)
 */
var ChartUtil = new function () {

    var _charts = {};

    this.helper = {
        randInt: function (min, max) {
            min = Math.ceil(min);
            max = Math.floor(max);

            if (min > max) {
                throw new Error("min은 max보다 클 수 없습니다.");
            }

            return Math.floor(Math.random() * (max - min + 1)) + min;
        },

        randFloat: function (min, max, fixed) {
            if (min > max) {
                throw new Error("min은 max보다 클 수 없습니다.");
            }

            if (fixed == null || String(fixed).trim() === "") {
                min = Math.ceil(min);
                max = Math.floor(max);
                return Math.floor(Math.random() * (max - min + 1)) + min;
            }

            return Number((Math.random() * (max - min) + min).toFixed(fixed));
        },

        createFloatingRangeData: function (count, minStart, maxStart, maxEnd, fixed) {
            var result = [];

            for (var i = 0; i < count; i++) {
                var start = this.randFloat(minStart, maxStart, fixed);
                var end = this.randFloat(start, maxEnd, fixed);
                result.push([start, end]);
            }

            return result;
        },

        createLabels: function (count, prefix) {
            var result = [];
            prefix = prefix || "DATA";

            for (var i = 1; i <= count; i++) {
                result.push(prefix + i);
            }

            return result;
        }
    };

    this.adapter = {
        toSingleDataset: function (rows, labelKey, valueKey, datasetLabel, datasetOptions) {
            var labels = [];
            var data = [];

            rows = rows || [];

            for (var i = 0; i < rows.length; i++) {
                labels.push(rows[i][labelKey]);
                data.push(rows[i][valueKey]);
            }

            var dataset = $.extend(true, {}, ChartUtil.createBasicDataset(datasetLabel || "Dataset", data), datasetOptions || {});
            dataset.data = data;

            return {
                labels: labels,
                datasets: [dataset]
            };
        },

        toMultiDataset: function (rows, labelKey, datasetDefs) {
            var labels = [];
            var datasets = [];
            rows = rows || [];
            datasetDefs = datasetDefs || [];

            for (var i = 0; i < rows.length; i++) {
                labels.push(rows[i][labelKey]);
            }

            for (var d = 0; d < datasetDefs.length; d++) {
                var def = datasetDefs[d];
                var values = [];

                for (var r = 0; r < rows.length; r++) {
                    values.push(rows[r][def.key]);
                }

                var dataset = $.extend(true, {}, ChartUtil.createBasicDataset(def.label || def.key, values), def.options || {});
                dataset.data = values;

                if (def.type) {
                    dataset.type = def.type;
                }

                if (def.parsing) {
                    dataset.parsing = def.parsing;
                }

                datasets.push(dataset);
            }

            return {
                labels: labels,
                datasets: datasets
            };
        },

        toParsingDatasets: function (rows, labelKey, datasetDefs) {
            var labels = [];
            var datasets = [];
            rows = rows || [];
            datasetDefs = datasetDefs || [];

            for (var i = 0; i < rows.length; i++) {
                labels.push(rows[i][labelKey]);
            }

            for (var d = 0; d < datasetDefs.length; d++) {
                var def = datasetDefs[d];
                var dataset = $.extend(true, {}, def.options || {}, {
                    label: def.label || def.key,
                    data: rows,
                    parsing: {
                        yAxisKey: def.key
                    }
                });

                if (def.type) {
                    dataset.type = def.type;
                }

                datasets.push(dataset);
            }

            return {
                labels: labels,
                datasets: datasets
            };
        }
    };

    this.getChart = function (canvasId) {
        return _charts[canvasId];
    };

    this.getCanvas = function (canvasId) {
        var canvas = document.getElementById(canvasId);

        if (!canvas) {
            console.error("Canvas not found : " + canvasId);
            return null;
        }

        return canvas;
    };

    this.getDefaultOptions = function () {
        return {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    position: "top"
                },
                tooltip: {
                    enabled: true
                }
            }
        };
    };

    this.mergeOptions = function (defaultOptions, customOptions) {
        return $.extend(true, {}, defaultOptions, customOptions || {});
    };

    this.destroy = function (canvasId) {
        if (_charts[canvasId]) {
            _charts[canvasId].destroy();
            delete _charts[canvasId];
        }
    };

    this.destroyAll = function () {
        for (var key in _charts) {
            if (_charts[key]) {
                _charts[key].destroy();
            }
        }
        _charts = {};
    };

    this.create = function (canvasId, chartType, data, options) {
        var canvas = this.getCanvas(canvasId);
        if (!canvas) return null;

        this.destroy(canvasId);

        var config = {
            type: chartType,
            data: data,
            options: this.mergeOptions(this.getDefaultOptions(), options)
        };

        _charts[canvasId] = new Chart(canvas, config);
        return _charts[canvasId];
    };

    this.createByConfig = function (canvasId, config) {
        var canvas = this.getCanvas(canvasId);
        if (!canvas) return null;

        this.destroy(canvasId);

        var finalConfig = $.extend(true, {}, config);
        finalConfig.options = this.mergeOptions(this.getDefaultOptions(), finalConfig.options);

        _charts[canvasId] = new Chart(canvas, finalConfig);
        return _charts[canvasId];
    };

    this.createMixed = function (canvasId, config) {
        return this.createByConfig(canvasId, config);
    };

    this.createFloatingBar = function (canvasId, labels, data, options) {
        var defaultOptions = {
            scales: {
                y: {
                    min: -100,
                    max: 100
                }
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            var value = context.raw;
                            return "시작: " + value[0] + ", 종료: " + value[1];
                        }
                    }
                }
            }
        };

        var chartData = {
            labels: labels,
            datasets: [{
                label: "Floating Bar",
                data: data,
                backgroundColor: this.randomColorSet(),
                borderColor: this.randomColorSet(),
                borderWidth: 1
            }]
        };

        return this.create(canvasId, "bar", chartData, this.mergeOptions(defaultOptions, options));
    };

    this.createBar = function (canvasId, data, options) {
        return this.create(canvasId, "bar", data, options);
    };

    this.createLine = function (canvasId, data, options) {
        return this.create(canvasId, "line", data, options);
    };

    this.createPie = function (canvasId, data, options) {
        return this.create(canvasId, "pie", data, options);
    };

    this.createDoughnut = function (canvasId, data, options) {
        return this.create(canvasId, "doughnut", data, options);
    };

    this.createHorizontalBar = function (canvasId, data, options) {
        var defaultOptions = {
            indexAxis: "y"
        };
        return this.create(canvasId, "bar", data, this.mergeOptions(defaultOptions, options));
    };

    this.createStackedBar = function (canvasId, data, options) {
        var defaultOptions = {
            scales: {
                x: {
                    stacked: true
                },
                y: {
                    stacked: true
                }
            }
        };
        return this.create(canvasId, "bar", data, this.mergeOptions(defaultOptions, options));
    };

    this.createRadar = function (canvasId, data, options) {
        return this.create(canvasId, "radar", data, options);
    };

    this.createPolarArea = function (canvasId, data, options) {
        return this.create(canvasId, "polarArea", data, options);
    };

    this.updateData = function (canvasId, data) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return;
        }

        chart.data = data;
        chart.update();
    };

    this.setLabels = function (canvasId, labels) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return;
        }

        chart.data.labels = labels;
        chart.update();
    };

    this.setDatasets = function (canvasId, datasets) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return;
        }

        chart.data.datasets = datasets;
        chart.update();
    };

    this.appendDataset = function (canvasId, dataset) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return;
        }

        chart.data.datasets.push(dataset);
        chart.update();
    };

    this.appendData = function (canvasId, label, values) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return;
        }

        chart.data.labels.push(label);

        for (var i = 0; i < chart.data.datasets.length; i++) {
            var val = $.isArray(values) ? values[i] : values;
            chart.data.datasets[i].data.push(val);
        }

        chart.update();
    };

    this.removeData = function (canvasId) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return;
        }

        if (chart.data.labels && chart.data.labels.length > 0) {
            chart.data.labels.pop();
        }

        for (var i = 0; i < chart.data.datasets.length; i++) {
            if (chart.data.datasets[i].data && chart.data.datasets[i].data.length > 0) {
                chart.data.datasets[i].data.pop();
            }
        }

        chart.update();
    };

    this.clearData = function (canvasId) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return;
        }

        chart.data.labels = [];

        for (var i = 0; i < chart.data.datasets.length; i++) {
            chart.data.datasets[i].data = [];
        }

        chart.update();
    };

    this.redraw = function (canvasId) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return;
        }

        chart.update();
    };

    this.setOptions = function (canvasId, options) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return;
        }

        chart.options = this.mergeOptions(chart.options, options);
        chart.update();
    };

    this.randomColorSet = function () {
        return [
            "rgb(255, 99, 132)",
            "rgb(54, 162, 235)",
            "rgb(255, 205, 86)",
            "rgb(75, 192, 192)",
            "rgb(153, 102, 255)",
            "rgb(255, 159, 64)"
        ];
    };

    this.createBasicDataset = function (label, data) {
        return {
            label: label,
            data: data,
            backgroundColor: this.randomColorSet(),
            borderColor: this.randomColorSet(),
            borderWidth: 1
        };
    };

    /**
     * 클릭/이벤트 발생 좌표의 데이터 조회
     * ------------------------------------------------------------------
     * [용도]
     * - 클릭한 차트 요소의 datasetIndex, dataIndex, label, value 반환
     *
     * [파라미터]
     * @param {string} canvasId
     * @param {Event} evt
     * @param {string} mode 기본값 nearest
     * @param {boolean} intersect 기본값 true
     *
     * [반환값]
     * {
     *   datasetIndex: 0,
     *   dataIndex: 2,
     *   dataset: {...},
     *   datasetLabel: "매출",
     *   label: "3월",
     *   value: 300,
     *   element: ...
     * }
     *
     * [사용 예시]
     * var result = ChartUtil.getClickData("myChart1", evt);
     * if (result) {
     *     console.log(result.label, result.value);
     * }
     */
    this.getClickData = function (canvasId, evt, mode, intersect) {
        var chart = this.getChart(canvasId);
        if (!chart) {
            console.error("Chart not found : " + canvasId);
            return null;
        }

        var points = chart.getElementsAtEventForMode(
            evt,
            mode || "nearest",
            { intersect: intersect !== false },
            true
        );

        if (!points || points.length === 0) {
            return null;
        }

        var point = points[0];
        var datasetIndex = point.datasetIndex;
        var dataIndex = point.index;
        var dataset = chart.data.datasets[datasetIndex];

        return {
            datasetIndex: datasetIndex,
            dataIndex: dataIndex,
            dataset: dataset,
            datasetLabel: dataset ? dataset.label : null,
            label: chart.data.labels ? chart.data.labels[dataIndex] : null,
            value: dataset && dataset.data ? dataset.data[dataIndex] : null,
            element: point.element,
            raw: point
        };
    };

    /**
     * 클릭 이벤트 바인딩
     * ------------------------------------------------------------------
     * [용도]
     * - 차트 클릭 시 해당 데이터 정보를 callback으로 전달
     *
     * [사용 예시]
     * ChartUtil.bindClickEvent("myChart1", function(result, evt){
     *     if (!result) return;
     *     console.log(result.datasetLabel, result.label, result.value);
     * });
     */
    this.bindClickEvent = function (canvasId, callback, mode, intersect) {
        var canvas = this.getCanvas(canvasId);
        if (!canvas) return;

        canvas.onclick = function (evt) {
            var result = ChartUtil.getClickData(canvasId, evt, mode, intersect);
            if (typeof callback === "function") {
                callback(result, evt);
            }
        };
    };

    /**
     * 더블클릭 이벤트 바인딩
     * ------------------------------------------------------------------
     * [용도]
     * - 차트 더블클릭 시 해당 데이터 정보를 callback으로 전달
     *
     * [사용 예시]
     * ChartUtil.bindDblClickEvent("myChart1", function(result, evt){
     *     if (!result) return;
     *     alert(result.label + " / " + result.value);
     * });
     */
    this.bindDblClickEvent = function (canvasId, callback, mode, intersect) {
        var canvas = this.getCanvas(canvasId);
        if (!canvas) return;

        canvas.ondblclick = function (evt) {
            var result = ChartUtil.getClickData(canvasId, evt, mode, intersect);
            if (typeof callback === "function") {
                callback(result, evt);
            }
        };
    };

    /**
     * hover 이벤트 바인딩
     * ------------------------------------------------------------------
     * [용도]
     * - 마우스 이동 시 해당 위치의 차트 데이터 확인
     * - 요소 위에 있을 때만 cursor 변경 등의 처리 가능
     *
     * [사용 예시]
     * ChartUtil.bindHoverEvent("myChart1", function(result, evt){
     *     if (result) {
     *         console.log("hover:", result.label, result.value);
     *     }
     * });
     */
    this.bindHoverEvent = function (canvasId, callback, mode, intersect) {
        var canvas = this.getCanvas(canvasId);
        if (!canvas) return;

        canvas.onmousemove = function (evt) {
            var result = ChartUtil.getClickData(canvasId, evt, mode || "nearest", intersect);
            if (typeof callback === "function") {
                callback(result, evt);
            }
        };
    };
};