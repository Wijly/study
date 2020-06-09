package com.util;

public class MyUtil {
	
	//전체 페이지 수 구하기
	//numPerPage : 한 화면에 표시할 데이터의 개수
	//dataCount : 전체 데이터의 개수
	
	public int getPageCount(int numPerPage, int dataCount) {
		
		int pageCount = 0;
		
		// 페이지 개수는 전체 데이터 / 화면에 표시할 개수
		pageCount = dataCount / numPerPage;
		
		
		if(dataCount%numPerPage != 0) {
			pageCount++;
		}
		return pageCount; 
	}
	
	// 페이징 처리
	// currentPage : 현재 표시할 페이지
	// totalPage : 전체 페이지 수
	// listURL : 링크를 설정할 URL ( list.jsp )
	
	public String pageIndexList(int currentPage, int totalPage, String listUrl) {
				
		int numPerBlock = 5;	// 보여줄 페이지의 수
		int currentPageSetup;	//이전◀ , 표시할 첫 페이지-1
		int page;
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage==0 || totalPage==0) {
			return "";
		}
		
		//list.jsp
		//list.jsp?searchKey="name&searchVakye="다슬"
		if(listUrl.indexOf("?")!=- 1) {
			listUrl = listUrl + "&";
		}else {
			listUrl = listUrl + "?";
		}
		
		currentPageSetup = ( currentPage / numPerBlock ) * numPerBlock;
		
		// 
		if(currentPage % numPerBlock ==0 ) {
			currentPageSetup = currentPageSetup-numPerBlock;
		}
		
		// 이전 ◀
		// <a href="list.jsp?pageNum=5"> 이전 </a>&nbsp;
		if (totalPage > numPerBlock && currentPageSetup > 0) {
			sb.append("<a href=\"" + listUrl + "pageNum="+ currentPageSetup+"\">◀이전</a>&nbsp;");
		}
		
		// 바로가기 페이지
		page = currentPageSetup + 1;
		
		// 현재 페이지 부터 +5개까지 보여줌.
		while(page<=totalPage && page <= (currentPageSetup + numPerBlock)) {

			// 페이지가 현재 내 페이지면 색을바꿈
			if(page==currentPage) {
				// <font color="Fuchsia"> 6 </font>&nbsp;
				sb.append("<font color=\"Fuchsia\">"+page+"</font>&nbsp;");
			}
			// 그 외 다른 페이지 번호
			else {
				// <a href="listUrl?pageNum=7"> 7 </a>&nbsp;
				sb.append("<a href=\""+listUrl+"pageNum="+page+"\">" + page + "</a>&nbsp;");
			}
			
			page++;
			
		}
		
		// 다음 ▶
		// 
		if( totalPage - currentPageSetup > numPerBlock ) {
				// <a href="listUrl?pageNum=11">다음 </a>&nbsp;
			sb.append("<a href=\""+listUrl+ "pageNum="+ page + "\">다음▶</a>&nbsp;");
		}
		
		return sb.toString();
	}
}
