<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>ChartUtil API Documentation</title>
  <style>
    :root {
      --bg: #f5f7fb;
      --panel: #ffffff;
      --panel-2: #f9fbff;
      --text: #1f2937;
      --muted: #6b7280;
      --line: #e5e7eb;
      --primary: #2563eb;
      --primary-2: #1d4ed8;
      --code-bg: #0f172a;
      --code-text: #e5edf8;
      --shadow: 0 10px 30px rgba(15, 23, 42, 0.08);
      --menu-width: 290px;
      --header-height: 64px;
      --radius: 14px;
    }

    * {
      box-sizing: border-box;
    }

    html {
      scroll-behavior: smooth;
    }

    body {
      margin: 0;
      background: var(--bg);
      color: var(--text);
      font-family: "Segoe UI", Arial, sans-serif;
      line-height: 1.6;
    }

    .topbar {
      position: sticky;
      top: 0;
      z-index: 1000;
      height: var(--header-height);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 24px;
      background: linear-gradient(90deg, #1e3a8a, #2563eb);
      color: #fff;
      box-shadow: 0 4px 18px rgba(0, 0, 0, 0.12);
    }

    .topbar h1 {
      margin: 0;
      font-size: 22px;
      font-weight: 700;
      letter-spacing: 0.2px;
    }

    .topbar .sub {
      font-size: 13px;
      opacity: 0.9;
    }

    .layout {
      display: flex;
      min-height: calc(100vh - var(--header-height));
    }

    .sidebar {
      width: var(--menu-width);
      flex-shrink: 0;
      position: sticky;
      top: var(--header-height);
      height: calc(100vh - var(--header-height));
      overflow-y: auto;
      padding: 20px 16px 28px;
      background: #eef4ff;
      border-right: 1px solid #dbe4f0;
    }

    .sidebar h2 {
      margin: 6px 8px 12px;
      font-size: 14px;
      color: var(--primary-2);
      text-transform: uppercase;
      letter-spacing: 0.08em;
    }

    .menu-group {
      margin-bottom: 18px;
      background: rgba(255, 255, 255, 0.7);
      border: 1px solid #dbe4f0;
      border-radius: 12px;
      padding: 10px;
    }

    .menu-group-title {
      font-weight: 700;
      font-size: 13px;
      margin: 4px 8px 8px;
      color: #334155;
    }

    .sidebar a {
      display: block;
      text-decoration: none;
      color: #334155;
      font-size: 14px;
      padding: 7px 10px;
      border-radius: 8px;
      margin: 2px 0;
      transition: all 0.15s ease;
    }

    .sidebar a:hover {
      background: #dbeafe;
      color: #1d4ed8;
    }

    .content {
      flex: 1;
      min-width: 0;
      padding: 28px;
    }

    .hero {
      background: linear-gradient(135deg, #eff6ff, #ffffff);
      border: 1px solid #dbeafe;
      border-radius: 18px;
      padding: 28px;
      box-shadow: var(--shadow);
      margin-bottom: 24px;
    }

    .hero h2 {
      margin: 0 0 10px;
      font-size: 28px;
      color: #1e3a8a;
    }

    .hero p {
      margin: 0;
      color: var(--muted);
    }

    .badge-row {
      margin-top: 14px;
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
    }

    .badge {
      display: inline-block;
      font-size: 12px;
      color: #1d4ed8;
      background: #dbeafe;
      border: 1px solid #bfdbfe;
      border-radius: 999px;
      padding: 4px 10px;
    }

    .section {
      background: var(--panel);
      border: 1px solid var(--line);
      border-radius: var(--radius);
      padding: 24px;
      box-shadow: var(--shadow);
      margin-bottom: 22px;
      scroll-margin-top: 80px;
    }

    .section h2 {
      margin: 0 0 14px;
      padding-bottom: 10px;
      border-bottom: 2px solid #eef2f7;
      color: #1e3a8a;
      font-size: 24px;
    }

    .section h3 {
      margin-top: 28px;
      margin-bottom: 10px;
      color: #0f172a;
      font-size: 18px;
    }

    .section p {
      margin: 8px 0 12px;
      color: #374151;
    }

    .note {
      background: #fffbeb;
      border: 1px solid #fde68a;
      color: #92400e;
      padding: 12px 14px;
      border-radius: 10px;
      margin: 12px 0 16px;
      font-size: 14px;
    }

    .small {
      font-size: 13px;
      color: var(--muted);
    }

    .api-box {
      border: 1px solid #e8edf5;
      background: var(--panel-2);
      border-radius: 12px;
      padding: 18px;
      margin: 14px 0 18px;
    }

    .signature {
      display: inline-block;
      background: #eff6ff;
      color: #1e40af;
      border: 1px solid #bfdbfe;
      border-radius: 8px;
      padding: 8px 12px;
      font-family: Consolas, monospace;
      font-size: 14px;
      margin-bottom: 10px;
      word-break: break-word;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin: 10px 0 14px;
      background: #fff;
      border-radius: 10px;
      overflow: hidden;
    }

    th, td {
      border: 1px solid #e5e7eb;
      padding: 10px 12px;
      vertical-align: top;
      text-align: left;
    }

    th {
      background: #f8fafc;
      width: 180px;
      color: #334155;
    }

    pre {
      margin: 12px 0 14px;
      padding: 16px;
      border-radius: 12px;
      background: var(--code-bg);
      color: var(--code-text);
      overflow-x: auto;
      border: 1px solid #1e293b;
      box-shadow: inset 0 0 0 1px rgba(255,255,255,0.02);
    }

    code {
      font-family: Consolas, monospace;
      background : #000 !important;
      color: #FFF;
    }
    
    .jsdoc {
      background: #0b1220;
      color: #dbeafe;
    }

    .footer {
      text-align: center;
      color: #6b7280;
      font-size: 13px;
      padding: 10px 0 30px;
    }

    @media (max-width: 1100px) {
      .layout {
        flex-direction: column;
      }

      .sidebar {
        position: relative;
        top: 0;
        width: 100%;
        height: auto;
        border-right: none;
        border-bottom: 1px solid #dbe4f0;
      }

      .content {
        padding: 18px;
      }
    }
    
    
  </style>
</head>
<body>
  <header class="topbar">
    <div>
      <h1>ChartUtil API Documentation</h1>
      <div class="sub">Chart.js 공통 유틸리티 모듈 문서</div>
    </div>
    <div class="sub">v1.0</div>
  </header>

  <div class="layout">
    <aside class="sidebar">
      <h2>Navigation</h2>

      <div class="menu-group">
        <div class="menu-group-title">소개</div>
        <a href="#overview">개요</a>
        <a href="#dependency">의존성</a>
        <a href="#basic-usage">기본 사용법</a>
      </div>

      <div class="menu-group">
        <div class="menu-group-title">핵심 API</div>
        <a href="#core-api">공통 API</a>
        <a href="#create-api">차트 생성 API</a>
        <a href="#update-api">데이터/옵션 변경 API</a>
        <a href="#event-api">이벤트 API</a>
      </div>

      <div class="menu-group">
        <div class="menu-group-title">보조 기능</div>
        <a href="#helper-api">Helper API</a>
        <a href="#adapter-api">Adapter API</a>
      </div>

      <div class="menu-group">
        <div class="menu-group-title">문서 형식</div>
        <a href="#jsdoc-style">JSDoc 스타일</a>
        <a href="#sample">화면 적용 예시</a>
      </div>
    </aside>

    <main class="content">
      <section class="hero">
        <h2>ChartUtil 문서</h2>
        <p>
          Chart.js 기반 차트 생성, 업데이트, 이벤트 처리, AJAX 응답 변환을 공통화한
          유틸리티 모듈에 대한 문서입니다.
        </p>
        <div class="badge-row">
          <span class="badge">Chart.js</span>
          <span class="badge">Utility Module</span>
          <span class="badge">Adapter</span>
          <span class="badge">Helper</span>
          <span class="badge">Event Binding</span>
        </div>
      </section>

      <section class="section" id="overview">
        <h2>개요</h2>
        <p>
          <code>ChartUtil</code> 은 차트 생성과 갱신 로직을 화면 코드에서 분리하기 위해 만든
          공통 모듈입니다.
        </p>
        <ul>
          <li>차트 생성 공통화</li>
          <li>차트 업데이트 공통화</li>
          <li>클릭/더블클릭/호버 이벤트 공통화</li>
          <li>AJAX 응답 데이터 → Chart.js 구조 변환</li>
          <li>랜덤 데이터 및 보조 유틸 제공</li>
        </ul>
      </section>

      <section class="section" id="dependency">
        <h2>의존성</h2>
        <table>
          <tr>
            <th>필수 라이브러리</th>
            <td>Chart.js</td>
          </tr>
          <tr>
            <th>추가 라이브러리</th>
            <td>jQuery (<code>$.extend</code>, <code>$.isArray</code> 사용)</td>
          </tr>
          <tr>
            <th>전역 객체명</th>
            <td><code>ChartUtil</code></td>
          </tr>
        </table>

        <pre><code>&lt;script src="/rcs/js/chartjs_v451/chart.js"&gt;&lt;/script&gt;
&lt;script src="/rcs/js/package.chartjs.utils.js"&gt;&lt;/script&gt;</code></pre>
      </section>

      <section class="section" id="basic-usage">
        <h2>기본 사용법</h2>
        <div class="api-box">
          <div class="signature">ChartUtil.createBar(canvasId, data, options)</div>
          <p>가장 기본적인 차트 생성 예시입니다.</p>
          <pre><code>var data = {
  labels: ["A", "B", "C"],
  datasets: [{
    label: "매출",
    data: [100, 200, 300]
  }]
};

ChartUtil.createBar("myChart", data);</code></pre>
        </div>
      </section>

      <section class="section" id="core-api">
        <h2>공통 API</h2>

        <div class="api-box">
          <div class="signature">ChartUtil.getChart(canvasId)</div>
          <p>생성된 차트 인스턴스를 조회합니다.</p>
          <pre><code>var chart = ChartUtil.getChart("myChart");</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.getCanvas(canvasId)</div>
          <p>canvas DOM 객체를 반환합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.destroy(canvasId)</div>
          <p>특정 차트를 제거합니다.</p>
          <pre><code>ChartUtil.destroy("myChart");</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.destroyAll()</div>
          <p>생성된 모든 차트를 제거합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.create(canvasId, chartType, data, options)</div>
          <p>모든 차트 타입의 기본 생성 함수입니다.</p>
        </div>
      </section>

      <section class="section" id="create-api">
        <h2>차트 생성 API</h2>

        <div class="api-box">
          <div class="signature">ChartUtil.createBar(canvasId, data, options)</div>
          <pre><code>ChartUtil.createBar("myChart", data);</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createLine(canvasId, data, options)</div>
          <pre><code>ChartUtil.createLine("myChart", data);</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createPie(canvasId, data, options)</div>
          <pre><code>ChartUtil.createPie("myChart", data);</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createDoughnut(canvasId, data, options)</div>
          <pre><code>ChartUtil.createDoughnut("myChart", data);</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createHorizontalBar(canvasId, data, options)</div>
          <p><code>indexAxis: 'y'</code> 를 적용한 가로 막대 차트를 생성합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createStackedBar(canvasId, data, options)</div>
          <p>누적 막대 차트를 생성합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createRadar(canvasId, data, options)</div>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createPolarArea(canvasId, data, options)</div>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createMixed(canvasId, config)</div>
          <pre><code>ChartUtil.createMixed("myChart", {
  type: "bar",
  data: {
    labels: ["1월", "2월", "3월"],
    datasets: [
      { label: "매출", data: [100, 200, 300], order: 2 },
      { label: "이익", data: [50, 90, 120], type: "line", order: 1 }
    ]
  }
});</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createFloatingBar(canvasId, labels, data, options)</div>
          <p><code>[start, end]</code> 형태의 범위 데이터를 가지는 Floating Bar 차트를 생성합니다.</p>
        </div>
      </section>

      <section class="section" id="update-api">
        <h2>데이터/옵션 변경 API</h2>

        <div class="api-box">
          <div class="signature">ChartUtil.updateData(canvasId, data)</div>
          <p>차트 데이터를 전체 교체합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.setLabels(canvasId, labels)</div>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.setDatasets(canvasId, datasets)</div>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.appendDataset(canvasId, dataset)</div>
          <p>dataset 1개를 추가합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.appendData(canvasId, label, values)</div>
          <p>label 1건과 dataset별 값을 추가합니다.</p>
          <pre><code>ChartUtil.appendData("myChart", "4월", [400, 120]);</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.removeData(canvasId)</div>
          <p>마지막 label/data를 제거합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.clearData(canvasId)</div>
          <p>모든 차트 데이터를 비웁니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.redraw(canvasId)</div>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.setOptions(canvasId, options)</div>
        </div>
      </section>

      <section class="section" id="event-api">
        <h2>이벤트 API</h2>

        <div class="api-box">
          <div class="signature">ChartUtil.getClickData(canvasId, evt, mode, intersect)</div>
          <p>이벤트가 발생한 좌표의 데이터셋과 데이터 값을 반환합니다.</p>
          <table>
            <tr>
              <th>주요 반환값</th>
              <td>
                <code>datasetIndex</code>,
                <code>dataIndex</code>,
                <code>datasetLabel</code>,
                <code>label</code>,
                <code>value</code>
              </td>
            </tr>
          </table>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.bindClickEvent(canvasId, callback, mode, intersect)</div>
          <pre><code>ChartUtil.bindClickEvent("myChart", function(result, evt) {
  if (!result) return;
  console.log(result.label, result.value);
});</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.bindDblClickEvent(canvasId, callback, mode, intersect)</div>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.bindHoverEvent(canvasId, callback, mode, intersect)</div>
          <pre><code>ChartUtil.bindHoverEvent("myChart", function(result) {
  var canvas = document.getElementById("myChart");
  canvas.style.cursor = result ? "pointer" : "default";
});</code></pre>
        </div>
      </section>

      <section class="section" id="helper-api">
        <h2>Helper API</h2>

        <div class="api-box">
          <div class="signature">ChartUtil.helper.randInt(min, max)</div>
          <p>min ~ max 범위의 정수를 반환합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.helper.randFloat(min, max, fixed)</div>
          <p>fixed가 있으면 실수, 없으면 정수를 반환합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.helper.createFloatingRangeData(count, minStart, maxStart, maxEnd, fixed)</div>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.helper.createLabels(count, prefix)</div>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.randomColorSet()</div>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.createBasicDataset(label, data)</div>
        </div>
      </section>

      <section class="section" id="adapter-api">
        <h2>Adapter API</h2>

        <div class="api-box">
          <div class="signature">ChartUtil.adapter.toSingleDataset(rows, labelKey, valueKey, datasetLabel, datasetOptions)</div>
          <p>AJAX 응답 배열을 단일 dataset Chart.js 데이터로 변환합니다.</p>
          <pre><code>var rows = [
  { month: "1월", amount: 100 },
  { month: "2월", amount: 200 }
];

var chartData = ChartUtil.adapter.toSingleDataset(
  rows, "month", "amount", "매출"
);</code></pre>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.adapter.toMultiDataset(rows, labelKey, datasetDefs)</div>
          <p>AJAX 응답을 다중 dataset 구조로 변환합니다.</p>
        </div>

        <div class="api-box">
          <div class="signature">ChartUtil.adapter.toParsingDatasets(rows, labelKey, datasetDefs)</div>
          <p>Chart.js parsing 구조용 dataset 배열을 생성합니다.</p>
        </div>
      </section>

      <section class="section" id="jsdoc-style">
        <h2>JSDoc 스타일 문서 예시</h2>
        <p class="small">
          아래는 <code>ChartUtil</code> 내부 함수를 JSDoc 스타일로 문서화하는 예시입니다.
        </p>

        <pre class="jsdoc"><code>/**
 * bar 차트를 생성한다.
 *
 * @function createBar
 * @memberof ChartUtil
 * @param {string} canvasId - canvas 요소의 id
 * @param {Object} data - Chart.js data 객체
 * @param {Object} [options] - Chart.js options 객체
 * @returns {Chart|null} 생성된 Chart 인스턴스
 *
 * @example
 * ChartUtil.createBar("myChart", {
 *   labels: ["A", "B", "C"],
 *   datasets: [{
 *     label: "매출",
 *     data: [100, 200, 300]
 *   }]
 * });
 */
this.createBar = function (canvasId, data, options) {
    return this.create(canvasId, "bar", data, options);
};</code></pre>

        <pre class="jsdoc"><code>/**
 * 클릭한 차트 요소의 데이터 정보를 반환한다.
 *
 * @function getClickData
 * @memberof ChartUtil
 * @param {string} canvasId - canvas 요소의 id
 * @param {Event} evt - click/mouse 이벤트 객체
 * @param {string} [mode="nearest"] - Chart.js event mode
 * @param {boolean} [intersect=true] - 실제 요소와 교차 여부
 * @returns {Object|null} 클릭한 데이터 정보
 *
 * @property {number} datasetIndex
 * @property {number} dataIndex
 * @property {string} datasetLabel
 * @property {string} label
 * @property {*} value
 *
 * @example
 * canvas.onclick = function(evt) {
 *   var result = ChartUtil.getClickData("myChart", evt);
 *   if (result) {
 *     console.log(result.label, result.value);
 *   }
 * };
 */
this.getClickData = function (canvasId, evt, mode, intersect) {
    ...
};</code></pre>

        <div class="note">
          실제 코드 파일에 JSDoc 주석을 붙여두면 IDE 자동완성, 타입 힌트, 문서 생성 도구에서 활용하기 좋습니다.
        </div>
      </section>

      <section class="section" id="sample">
        <h2>화면 적용 예시</h2>
        <pre><code>var HOME_DASHBOARD = new function () {

    this.initPage = function () {
        this.createBasicCharts();
        this.createParsingChart();
        this.createMixedChart();
        this.createFloatingBarChart();
        this.bindEvents();
    };

    this.createBasicCharts = function () {
        var data = {
            labels: ["Red", "Blue", "Yellow"],
            datasets: [{
                label: "My First Dataset",
                data: [300, 50, 100],
                backgroundColor: [
                    "rgb(255, 99, 132)",
                    "rgb(54, 162, 235)",
                    "rgb(255, 205, 86)"
                ]
            }]
        };

        ChartUtil.createDoughnut("myChart1", data);
        ChartUtil.createBar("myChart2", data);
        ChartUtil.createPie("myChart3", data);
        ChartUtil.createLine("myChart4", data);
    };

    this.createParsingChart = function () {
        var rows = [
            { x: "Jan", net: 100, cogs: 50, gm: 50 },
            { x: "Feb", net: 120, cogs: 55, gm: 75 }
        ];

        var chartData = ChartUtil.adapter.toParsingDatasets(rows, "x", [
            { key: "net", label: "Net sales" },
            { key: "cogs", label: "Cost of goods sold" },
            { key: "gm", label: "Gross margin" }
        ]);

        ChartUtil.createBar("myChart5", chartData);
    };

    this.createMixedChart = function () {
        ChartUtil.createMixed("myChart6", {
            type: "bar",
            data: {
                labels: ["January", "February", "March", "April"],
                datasets: [
                    { label: "Bar Dataset", data: [10, 20, 30, 40], order: 2 },
                    { label: "Line Dataset", data: [10, 10, 30, 20], type: "line", order: 1 }
                ]
            }
        });
    };

    this.createFloatingBarChart = function () {
        var labels = ["A", "B", "C", "D", "E", "F"];
        var ranges = ChartUtil.helper.createFloatingRangeData(6, -100, 50, 100);
        ChartUtil.createFloatingBar("floatingBarChart", labels, ranges);
    };

    this.bindEvents = function () {
        ChartUtil.bindClickEvent("myChart2", function(result) {
            if (!result) return;
            console.log(result.label, result.value);
        });
    };
};

$(document).ready(function () {
    HOME_DASHBOARD.initPage();
});</code></pre>
      </section>

      <div class="footer">
        ChartUtil API Documentation
      </div>
    </main>
  </div>
</body>
</html>