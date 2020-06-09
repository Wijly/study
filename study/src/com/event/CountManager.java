package com.event;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

// ���� ������ ����Ŭ
// HttpSessionListener : ������ ����, ����� ��
// ServletContextListener : ������ ����, ������ ��

public class CountManager implements HttpSessionListener{
	
	private static CountManager countManager;
	private static int count;
	
	// ������
	public CountManager() {
		countManager = this;	// �ڱ� �ڽ�
	}
	
	public static synchronized CountManager getInstance() throws Exception{
		if(countManager == null)
			countManager = new CountManager();	// null�̸� ��ü ����
		
		return countManager;
	}
	
	public static int getCount() {
		return count;
	}

	@Override
	public void sessionCreated(HttpSessionEvent evt) {
		
		// sid Ű ���� �����ͼ� �Ҵ��� ����
		HttpSession session = evt.getSession();
		session.setMaxInactiveInterval(10*60); 		// 10��
		
		count++;
		
		System.out.println(session.getId() + "���� ����,");
		System.out.println("������ �� : "+count);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent evt) {
		
		HttpSession session = evt.getSession();
		
		count--;
		
		System.out.println(session.getId() + "���� �Ҹ�,");
		System.out.println("������ �� : "+count);
		
	}
	

}
