package com.kpmg.kdb.util;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class MiscUtils {

	/**
	 * 레벨1메뉴의 하위 메뉴목록으로 왼쪽 메뉴 html (<div>여기에 들어갈 html임</div>) 문자열을 생성하여 반환

            <li><a href="#">신청등록</a>
              <ul>
                <li><a href="#">교육국 전도금 신청</a></li>
                <li><a href="#">본부 전도금 신청</a></li>
                <li><a href="#">교육국 전도금 일괄신청</a></li>
              </ul>
            </li>

	 * @param 	parentCode	레벨1 메뉴ID
	 * @param 	treelist	레벨1메뉴의 하위 메뉴목록(레벨1 미포함)
	 * @param 	selectedMenu	선택된 메뉴(현재 메뉴)
	 * @return	html 문자열(<div>여기에 들어갈 html임</div>)
	 */
	@SuppressWarnings("unchecked")
	public static String getLeftMenuHtml(int parentCode, List<Map> treelist, Map selectedMenu) {
		if ( parentCode<0 ) {
			return null;
		}
		if (null==treelist || treelist.isEmpty()) {
			return null;
		}

		StringBuffer s = new StringBuffer();

		int subListFromIndex = 0;
		int subListToIndex   = treelist.size();

		for(Map node : treelist) {
			int currentCode = ((BigDecimal)node.get("MENU_ID")).intValue(); //(String)node.get("MENU_ID");
			int currentParent = ((BigDecimal)node.get("PARENT_MENU_ID")).intValue(); //(String)node.get("PARENT_MENU_ID")
			int currentLevel = ((BigDecimal)node.get("LVL")).intValue();
			int childCount   = ((BigDecimal)node.get("CHILD_COUNT")).intValue();
			String menuYn = (String)node.get("MENU_YN");
			String pgmType = (String)node.get("PGM_TYPE");
			String psel = (String)node.get("PARENT_SELECTED");
			String sel = (String)node.get("SELECTED");

			int selectedMenuId = -1; //((BigDecimal)selectedMenu.get("MENU_ID")).intValue();
			int selectedParentId = -1; //((BigDecimal)selectedMenu.get("PARENT_MENU_ID")).intValue();
			if (null!=selectedMenu) {
				try {
					selectedMenuId   = ((BigDecimal)selectedMenu.get("MENU_ID")).intValue();
					selectedParentId = ((BigDecimal)selectedMenu.get("PARENT_MENU_ID")).intValue();
				}
				catch (Exception e) {
					selectedMenuId   = -1;
					selectedParentId = -1;
				}
			}

			String _indent = StringUtil.pad(" ", currentLevel*4);

			if ( StringUtils.equalsIgnoreCase("SUB", pgmType) ) {
				continue; //(주의) PGM_TYPE가 'SUB'인 메뉴는 메뉴트리에 추가하지 않는다.
			}

			if ( parentCode == currentParent ) { //현재노드가 부모 parent의 하위 노드임
				s.append(_indent);
				s.append("<li");
				String classes = null;

				if ( currentCode==selectedMenuId ) {
					classes = currentCode==selectedMenuId ? "pgm-selected" : "";
					//classes += StringUtils.isNotBlank(classes) ? " " : "";
					//classes += currentCode==selectedParentId ? "pgm-menu-selected" : "";
					s.append(" class='").append(classes).append("'");
				}
				/*if ( StringUtils.equals("true", sel) || StringUtils.equals("true", psel) ) {
					classes = StringUtils.equals("true", sel) ? "pgm-selected" : "";
					if ( StringUtils.equals("true", psel) ) {
						classes += (StringUtils.isNotBlank(classes) ? " " : "") + "pgm-menu-selected";
					}
					s.append(" class='").append(classes).append("'");
				}*/
				//(예) <li class='pgm-selected pgm-menu-selected'>
				//s.append("").append(StringUtils.equals("true", sel) ? " class='pgm-selected'" : "");
				s.append(">"); //end of li
				//StringUtils.equals("true", sel) ? " style='display: block;'" : ""

				//주의 data("key") 는 소문자로 인식함 (예) $(this).data("menu_name")
				s.append("<a href='").append(node.get("PGM_PATH")).append("'");
				s.append(" id='left-menu-id_").append(node.get("MENU_ID")).append("'");
				s.append(" data-MENU_ID='").append(node.get("MENU_ID")).append("'");
				s.append(" data-MENU_NAME='").append(node.get("MENU_NAME")).append("'");
				s.append(" data-PARENT_MENU_ID='").append(node.get("PARENT_MENU_ID")).append("'");
				s.append(" data-PGM_ID='").append(node.get("PGM_ID")).append("'");
				s.append(" data-MENU_YN='").append(node.get("MENU_YN")).append("'");
				s.append(" data-PGM_TYPE='").append(node.get("PGM_TYPE")).append("'");
				s.append(" data-CHILD_COUNT='").append(childCount).append("'");

				s.append(" class='left-menu-node has-").append(1>childCount ? "no" : "").append("-child'");
				s.append(">"); //end of a
				s.append(node.get("MENU_NAME"));
				s.append("</a>");

				List<Map> sublist = treelist.subList(subListFromIndex, subListToIndex);

				String subTreeHtml = getLeftMenuHtml(currentCode, sublist, selectedMenu); //재귀순환함수

				if ( StringUtils.isNotBlank(subTreeHtml) ) {
					s.append("\n");
					s.append(_indent).append("  <ul");
					s.append( subTreeHtml.indexOf("pgm-selected")>0 ? " class='pgm-menu-selected'" : " style='display:none;'" );
					s.append(">\n");
					s.append( subTreeHtml );
					s.append(_indent).append("  </ul>\n");
					s.append(_indent);
				}
				else {
					//s.append( StringUtil.pad("\t", currentLevel) ).append("\n");
				}

				s.append("</li>\n");
			}
			else { //현재 노드가 시작노드와 레벨이 다름
				continue;
			}
		}
		return s.toString();
	}

/*
<ul id="red" class="treeview-red">
	<li><span>Item 1</span>
		<ul>
			<li><span>Item 1.0</span>
				<ul>
					<li><span>Item 1.0.0</span></li>
				</ul>
			</li>
		</ul>
	</li>
</ul>

 */

	/**
	 * jsTree용 메뉴 html (<ul>여기에 들어갈 html임</ul>) 문자열을 생성하여 반환
	 *
	   		<li id="1" parentId="0" depth="1" rel="folder"><a href='#'>자금배정</a>
	   			<ul>
					<li id="21" parentId="1" depth="2" rel="folder"><a href='#'>기준정보</a>
						<ul>
							<li id="201" parentId="21" depth="3" rel="default"><a href='#'>조직관리비 단가 정의</a></li>
							<li id="202" parentId="21" depth="3" rel="default"><a href='#'>기본마케팅비 단가 정의</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li id="208" parentId="3" depth="2" rel="folder"><a href='#'>기준정보</a>
				<ul>
					<li id="209" parentId="208" depth="3" rel="default"><a href='#'>코드그룹관리</a></li>
					<li id="210" parentId="208" depth="3" rel="default"><a href='#'>코드관리</a></li>
				</ul>
			</li>
	 * 
	 * 
	 * @param 	treelist	계층적으로 조회된 메뉴목록
	 * @return	html 문자열(<ul>여기에 들어갈 html임</ul>)
	 */
	@SuppressWarnings("unchecked")
	public static String getMenuHtmlForJsTree(int parentCode, List<Map> treelist) {
		if ( parentCode<0 ) { //StringUtils.isBlank(parentCode)
			return null;
		}
		if (null==treelist || treelist.isEmpty()) {
			return null;
		}

		StringBuffer s = new StringBuffer();

		int subListFromIndex = 0;
		int subListToIndex   = treelist.size();

		for(Map node : treelist) {
			int currentCode = ((BigDecimal)node.get("MENU_ID")).intValue(); //(String)node.get("MENU_ID");
			int currentParent = ((BigDecimal)node.get("PARENT_MENU_ID")).intValue(); //(String)node.get("PARENT_MENU_ID")
			int currentLevel = ((BigDecimal)node.get("LEVEL")).intValue();
			int childCount   = ((BigDecimal)node.get("CHILD_COUNT")).intValue();
			String currentType = (String)node.get("MENU_YN");
			String _indent = StringUtil.pad(" ", currentLevel*4);

			if ( parentCode == currentParent ) { //현재노드가 부모 parent의 하위 노드임
				//<li id="209" parentId="208" depth="3" rel="default"><a href='#'>코드그룹관리</a></li>
				s.append(_indent);
				s.append("<li id='MENU_ID_").append(node.get("MENU_ID")).append("'");
				s.append(" parentId='MENU_ID_").append(node.get("PARENT_MENU_ID")).append("'");
				s.append(" depth='").append(currentLevel).append("'");
				
				if (StringUtils.equals("Y", currentType)) {
					s.append(" rel='folder'");
				}
				else {
					s.append(" rel='default'");
				}
				s.append(">"); //end of li

				s.append("<a href='#' id='MENU_ID_").append(node.get("MENU_ID")).append("'");
				s.append(" data-MENU_ID='").append(node.get("MENU_ID")).append("'");
				s.append(" data-MENU_NAME='").append(node.get("MENU_NAME")).append("'");
				s.append(" data-PARENT_MENU_ID='").append(node.get("PARENT_MENU_ID")).append("'");
				s.append(" data-PGM_ID='").append(node.get("PGM_ID")).append("'");
				s.append(" data-MENU_YN='").append(node.get("MENU_YN")).append("'");
				s.append(" data-PGM_TYPE='").append(node.get("PGM_TYPE")).append("'");
				s.append(" data-CHILD_COUNT='").append(childCount).append("'");

				if (0==childCount) {
					s.append(" class='treenode has-no-child'");
				}
				else {
					s.append(" class='treenode has-child'");
				}

				s.append(">"); //end of a
				s.append(node.get("MENU_NAME"));
				s.append("</a>");

				List<Map> sublist = treelist.subList(subListFromIndex, subListToIndex);

				String subTreeHtml = getMenuHtmlForJsTree(currentCode, sublist); //재귀순환함수
				
				if ( StringUtils.isNotBlank(subTreeHtml) ) {
					s.append("\n");
					s.append(_indent).append("  <ul>\n");
					s.append( subTreeHtml );
					s.append(_indent).append("  </ul>\n");
					s.append(_indent);
				}
				else {
					//s.append( StringUtil.pad("\t", currentLevel) ).append("\n");
				}

				s.append("</li>\n");
			}
			else { //현재 노드가 시작노드와 레벨이 다름
				continue;
			}
		}
		return s.toString();
	}
	public static String getMenuHtmlForTreeview(int parentCode, List<Map> treelist) {
		if ( parentCode<0 ) { //StringUtils.isBlank(parentCode)
			return null;
		}
		if (null==treelist || treelist.isEmpty()) {
			return null;
		}

		StringBuffer s = new StringBuffer();

		int subListFromIndex = 0;
		int subListToIndex   = treelist.size();

		for(Map node : treelist) {
			int currentCode = ((BigDecimal)node.get("MENU_ID")).intValue(); //(String)node.get("MENU_ID");
			int currentParent = ((BigDecimal)node.get("PARENT_MENU_ID")).intValue(); //(String)node.get("PARENT_MENU_ID")
			int currentLevel = ((BigDecimal)node.get("LEVEL")).intValue();
			int childCount   = ((BigDecimal)node.get("CHILD_COUNT")).intValue();
			String currentType = (String)node.get("MENU_YN");
			String _indent = StringUtil.pad(" ", currentLevel*4);

			if ( parentCode == currentParent ) { //현재노드가 부모 parent의 하위 노드임
				s.append(_indent);
				s.append("<li>");

				//주의 data("key") 는 소문자로 인식함 (예) $(this).data("menu_name")
				s.append("<a href='#' id='MENU_ID_").append(node.get("MENU_ID")).append("'");
				s.append(" data-MENU_ID='").append(node.get("MENU_ID")).append("'");
				s.append(" data-MENU_NAME='").append(node.get("MENU_NAME")).append("'");
				s.append(" data-PARENT_MENU_ID='").append(node.get("PARENT_MENU_ID")).append("'");
				s.append(" data-PGM_ID='").append(node.get("PGM_ID")).append("'");
				s.append(" data-MENU_YN='").append(node.get("MENU_YN")).append("'");
				s.append(" data-PGM_TYPE='").append(node.get("PGM_TYPE")).append("'");
				s.append(" data-CHILD_COUNT='").append(childCount).append("'");

				if (0==childCount) {
					s.append(" class='treenode has-no-child'");
				}
				else {
					s.append(" class='treenode has-child'");
				}

				s.append(">"); //end of a
				s.append(node.get("MENU_NAME"));
				s.append("</a>");

				List<Map> sublist = treelist.subList(subListFromIndex, subListToIndex);

				String subTreeHtml = getMenuHtmlForTreeview(currentCode, sublist); //재귀순환함수
				
				if ( StringUtils.isNotBlank(subTreeHtml) ) {
					s.append("\n");
					s.append(_indent).append("  <ul>\n");
					s.append( subTreeHtml );
					s.append(_indent).append("  </ul>\n");
					s.append(_indent);
				}
				else {
					//s.append( StringUtil.pad("\t", currentLevel) ).append("\n");
				}

				s.append("</li>\n");
			}
			else { //현재 노드가 시작노드와 레벨이 다름
				continue;
			}
		}
		return s.toString();
	}
	
	/**
	 * 레벨1메뉴의 하위 메뉴목록으로 왼쪽 메뉴 html (<div>여기에 들어갈 html임</div>) 문자열을 생성하여 반환
	 * <code>
	 * <ul id="red" class="treeview-red">
			<li><span>Item 1</span>
				<ul>
					<li><span>Item 1.0</span>
						<ul>
							<li><span>Item 1.0.0</span></li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	 * </code>
	 * 
	 * @param 	treelist	계층적으로 조회된 조직목록
	 * @return	html 문자열(<div>여기에 들어갈 html임</div>)
	 */
	@SuppressWarnings("unchecked")
	public static String getOrgTreeHtml(String parentCode, List<Map> treelist) {
		if ( StringUtils.isBlank(parentCode) ) {
			return null;
		}
		if (null==treelist || treelist.isEmpty()) {
			return null;
		}

		StringBuffer s = new StringBuffer();

		int subListFromIndex = 0;
		int subListToIndex   = treelist.size();

		for(Map node : treelist) {
			String currentCode = (String)node.get("ORG_KOSTL");
			String currentParent = (String)node.get("PARENT_ORG_KOSTL");
			int currentLevel = ((BigDecimal)node.get("LEVEL")).intValue();
			int childCount   = ((BigDecimal)node.get("CHILD_COUNT")).intValue();
			String _indent = StringUtil.pad(" ", currentLevel*4);

			if ( StringUtils.equals(parentCode, currentParent) ) { //현재노드가 부모 parent의 하위 노드임
				s.append(_indent);
				s.append("<li>");
				s.append("<span id='spn_org_").append(node.get("ORG_KOSTL")).append("'");
				s.append(" data-ORG_KOSTL='").append(node.get("ORG_KOSTL")).append("'");
				s.append(" data-ORG_KOSTL_NM='").append(node.get("ORG_KOSTL_NM")).append("'");
				s.append(" data-ORG_LOCATION='").append(node.get("ORG_LOCATION")).append("'");
				s.append(" data-PARENT_ORG_KOSTL='").append(node.get("PARENT_ORG_KOSTL")).append("'");
				s.append(" data-PARENT_ORG_KOSTL_NM='").append(node.get("PARENT_ORG_KOSTL_NM")).append("'");
				s.append(" data-CHILD_COUNT='").append(childCount).append("'");

				if (0==childCount) {
					s.append(" class='treenode has-no-child'");
				}
				else {
					s.append(" class='treenode has-child'");
				}

				s.append(">"); //end of span
				s.append(node.get("ORG_KOSTL_NM"));
				s.append("</span>");

				List<Map> sublist = treelist.subList(subListFromIndex, subListToIndex);

				String subTreeHtml = getOrgTreeHtml(currentCode, sublist);
				
				if ( StringUtils.isNotBlank(subTreeHtml) ) {
					s.append("\n");
					s.append(_indent).append("  <ul>\n");
					s.append( subTreeHtml );
					s.append(_indent).append("  </ul>\n");
					s.append(_indent);
				}
				else {
					//s.append( StringUtil.pad("\t", currentLevel) ).append("\n");
				}

				s.append("</li>\n");
			}
			else { //현재 노드가 시작노드와 레벨이 다름
				continue;
			}
		}
		return s.toString();
	}
	

}
