package com.util;

public class MyUtil {
	
	//��ü ������ �� ���ϱ�
	//numPerPage : �� ȭ�鿡 ǥ���� �������� ����
	//dataCount : ��ü �������� ����
	
	public int getPageCount(int numPerPage, int dataCount) {
		
		int pageCount = 0;
		
		// ������ ������ ��ü ������ / ȭ�鿡 ǥ���� ����
		pageCount = dataCount / numPerPage;
		
		
		if(dataCount%numPerPage != 0) {
			pageCount++;
		}
		return pageCount; 
	}
	
	// ����¡ ó��
	// currentPage : ���� ǥ���� ������
	// totalPage : ��ü ������ ��
	// listURL : ��ũ�� ������ URL ( list.jsp )
	
	public String pageIndexList(int currentPage, int totalPage, String listUrl) {
				
		int numPerBlock = 5;	// ������ �������� ��
		int currentPageSetup;	//������ , ǥ���� ù ������-1
		int page;
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage==0 || totalPage==0) {
			return "";
		}
		
		//list.jsp
		//list.jsp?searchKey="name&searchVakye="�ٽ�"
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
		
		// ���� ��
		// <a href="list.jsp?pageNum=5"> ���� </a>&nbsp;
		if (totalPage > numPerBlock && currentPageSetup > 0) {
			sb.append("<a href=\"" + listUrl + "pageNum="+ currentPageSetup+"\">������</a>&nbsp;");
		}
		
		// �ٷΰ��� ������
		page = currentPageSetup + 1;
		
		// ���� ������ ���� +5������ ������.
		while(page<=totalPage && page <= (currentPageSetup + numPerBlock)) {

			// �������� ���� �� �������� �����ٲ�
			if(page==currentPage) {
				// <font color="Fuchsia"> 6 </font>&nbsp;
				sb.append("<font color=\"Fuchsia\">"+page+"</font>&nbsp;");
			}
			// �� �� �ٸ� ������ ��ȣ
			else {
				// <a href="listUrl?pageNum=7"> 7 </a>&nbsp;
				sb.append("<a href=\""+listUrl+"pageNum="+page+"\">" + page + "</a>&nbsp;");
			}
			
			page++;
			
		}
		
		// ���� ��
		// 
		if( totalPage - currentPageSetup > numPerBlock ) {
				// <a href="listUrl?pageNum=11">���� </a>&nbsp;
			sb.append("<a href=\""+listUrl+ "pageNum="+ page + "\">������</a>&nbsp;");
		}
		
		return sb.toString();
	}
}
