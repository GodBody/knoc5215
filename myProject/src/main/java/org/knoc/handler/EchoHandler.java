package org.knoc.handler;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler {

	private Logger logger = LoggerFactory.getLogger(EchoHandler.class);

	/**
	 * 서버에 연결한 사용자들을 저장하는 리스트
	 */

	private Map<String, WebSocketSession> sessionMap = new HashMap<>();

//	private List<WebSocketSession> connectedUsers = new ArrayList<WebSocketSession>();

	// public EchoHandler() {
	// connectedUsers = new ArrayList<WebSocketSession>();
	// }

	/**
	 * 접속과 관련된 Event Method
	 *
	 *
	 * @param WebSocketSession
	 *            접속한 사용자
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionMap.put(session.getId(), session);
		// connecteddUsers.add(session);

		logger.info(session.getId() + "님이 접속했습니다.");
		logger.info("연결 IP : " + session.getRemoteAddress().getHostName());
	}

	/**
	 * 두 가지 이벤트를 처리
	 *
	 * 1. Send : 클라이언트가 서버에게 메시지를 보냄 2. Emit : 서버에 연결되어 있는 클라이언트에게 메시지를 보냄
	 *
	 * @param WebSocketSession
	 *            메시지를 보낸 클라이언트
	 * @param TextMessage
	 *            메시지의 내용
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		logger.info(session.getId() + "님의 메시지 : " + message.getPayload());

		Iterator<String> itr = sessionMap.keySet().iterator();
		String sessionId = "";
		while (itr.hasNext()) {
			sessionId = itr.next();

			sessionMap.get(sessionId)
					.sendMessage(new TextMessage(session.getPrincipal().getName() + " : " + message.getPayload()));
		}

//		for (WebSocketSession webSocketSession : connectedUsers) {
//			webSocketSession.sendMessage(new TextMessage(message.getPayload()));
//		}

	}

	/*
	 * Payload : 사용자가 보낸 메시지
	 */

	/**
	 * 클라이언트가 서버와 연결을 끊었을때 실행되는 메소드
	 *
	 * @param WebSocketSession
	 *            연결을 끊은 클라이언트
	 * @param CloseStatus
	 *            연결 상태(확인 필요함)
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		 sessionMap.remove(session.getId());

//		connectedUsers.remove(session);

		// for (WebSocketSession webSocketSession : connectedUsers) {
		// /*
		// * 자신이 보낸 메시지를 받지 않는다.
		// */
		// if (!session.getId().equals(webSocketSession.getId())) {
		// // webSocketSession.sendMessage(new
		// // TextMessage(session.getRemoteAddress().getHostName() + "퇴장했습니다."));
		// webSocketSession.sendMessage(new TextMessage(session.getId() + " 님이
		// 퇴장했습니다."));
		// }
		// }

		logger.info(session.getId() + "님이 퇴장했습니다.");
	}

}
