package com.finalproject.sns.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.finalproject.sns.vo.MemVO;

public class Handler extends TextWebSocketHandler {
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	Map<String, WebSocketSession> MemVOSessions = new HashMap<String, WebSocketSession>();
	Map<String, WebSocketSession> MemVOnames = new HashMap<String, WebSocketSession>();
	@Override
	public void afterConnectionEstablished(WebSocketSession session)  throws Exception{ //연결
		sessions.add(session);
		String senderId = getId(session);
		String sendname = getname(session);
		MemVOSessions.put(senderId, session);
		MemVOnames.put(sendname, session);
		for(WebSocketSession sess: sessions) {
			sess.sendMessage(new TextMessage("on_off,none,none"));
		}

	}

	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message)  throws Exception{ //메세지
		System.out.println("handleTextMessage:" + session + " : " + message);
		String sendername = getname(session);
		String senderid = getId(session);
		/*
			최초접속시 현재 접속자 리스트를 보여준다.
			접속 or 종료값을 받으면 접속자리스트에 업데이트 해준다.
		*/
		
		/*
		for(WebSocketSession sess: sessions) {
			if(!sess.getId().equals(senderId))
			sess.sendMessage(new TextMessage(senderId + ": " + message.getPayload()));
		}
		*/
		
		String msg = message.getPayload();
		if(msg != null && !msg.equals("")) {
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 3) {
				String cmd = strs[0];
				String msg2 = strs[1];
				String readid = strs[2];
				
				
				WebSocketSession boardWriterSession = MemVOSessions.get(readid);
				if("chat".equals(cmd) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage("chat" + "," + sendername + "," + msg2 + "," + readid);
					TextMessage tmpMsg2 = new TextMessage("chat" + "," + sendername + "," + msg2 + "," + senderid);
					session.sendMessage(tmpMsg);
					boardWriterSession.sendMessage(tmpMsg2);
				}
				else if("AddFriend".equals(cmd) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage("AddFriend" + "," + sendername);
					boardWriterSession.sendMessage(tmpMsg);
				}
				else if("OKFriend".equals(cmd)) {
					TextMessage tmpMsg = new TextMessage("on_off,none,none");
					session.sendMessage(tmpMsg);
					if(boardWriterSession != null) boardWriterSession.sendMessage(tmpMsg);
				}
				else if("NOFriend".equals(cmd) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage("MSG,친구 신청이 거절 되었습니다.,none");
					boardWriterSession.sendMessage(tmpMsg);
				}
				else if("MSG".equals(cmd) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage("MSG,새로운 메세지!!,none");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
	}
	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		MemVO loginMemVO = (MemVO)httpSession.get("loginVO");
		if(null == loginMemVO)
			return session.getId();
		else
			return loginMemVO.getId();
	}
	private String getname(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		MemVO loginMemVO = (MemVO)httpSession.get("loginVO");
		if(null == loginMemVO)
			return session.getId();
		else
			return loginMemVO.getMemname();
	}
	/*private <K, V> K getKey(Map<K, V> map, V value) {
        for (K key : map.keySet()) {
            if (value.equals(map.get(key))) {
                return key;
            }
        }
        return null;
    }*/
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status)  throws Exception{ //연결종료
		System.out.println("afterConnectionClosed:" + session + " : " + status);
		MemVOSessions.remove(getId(session));
		MemVOnames.remove(getId(session));
		sessions.remove(session);
		for(WebSocketSession sess : sessions) {
			if(!sess.equals(session))
			sess.sendMessage(new TextMessage("on_off,none,none"));
		}
	}

}
