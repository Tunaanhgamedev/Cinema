package com.cinema.controller.User;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 * WebSocket endpoint to handle real-time seat selection updates.
 * Clients connect with ?showtimeId=...
 */
@ServerEndpoint("/ws/seat")
public class SeatWebSocket {

    // Store sessions grouped by showtimeId to broadcast only to users viewing the same movie session
    private static final ConcurrentHashMap<String, Set<Session>> showtimeSessions = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session) {
        String showtimeId = getShowtimeId(session);
        if (showtimeId != null) {
            showtimeSessions.computeIfAbsent(showtimeId, k -> Collections.synchronizedSet(new HashSet<>())).add(session);
            System.out.println("WebSocket opened for showtime: " + showtimeId + ", session: " + session.getId());
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        // Expected message format: "showtimeId:seatCode:action"
        // Action: "select" or "deselect"
        System.out.println("WebSocket message received: " + message);
        String[] parts = message.split(":");
        if (parts.length == 3) {
            String showtimeId = parts[0];
            broadcast(showtimeId, message, session);
        }
    }

    @OnClose
    public void onClose(Session session) {
        String showtimeId = getShowtimeId(session);
        if (showtimeId != null && showtimeSessions.containsKey(showtimeId)) {
            showtimeSessions.get(showtimeId).remove(session);
            System.out.println("WebSocket closed for showtime: " + showtimeId + ", session: " + session.getId());
        }
    }

    @OnError
    public void onError(Session session, Throwable t) {
        System.err.println("WebSocket error for session " + session.getId() + ": " + t.getMessage());
        t.printStackTrace();
    }

    private void broadcast(String showtimeId, String message, Session sender) {
        Set<Session> sessions = showtimeSessions.get(showtimeId);
        if (sessions != null) {
            synchronized (sessions) {
                for (Session s : sessions) {
                    if (s.isOpen() && !s.equals(sender)) {
                        try {
                            s.getBasicRemote().sendText(message);
                        } catch (IOException e) {
                            System.err.println("Error broadcasting to session " + s.getId() + ": " + e.getMessage());
                        }
                    }
                }
            }
        }
    }

    private String getShowtimeId(Session session) {
        String query = session.getQueryString();
        if (query != null && query.contains("showtimeId=")) {
            // Simple query parsing
            for (String param : query.split("&")) {
                if (param.startsWith("showtimeId=")) {
                    return param.substring("showtimeId=".length());
                }
            }
        }
        return null;
    }
}
