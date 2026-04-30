package com.cinema.utils;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class CacheManager {
    private static final Map<String, CacheEntry> cache = new ConcurrentHashMap<>();
    private static final long DEFAULT_EXPIRY = 600000; // 10 phút (ms)

    public static void put(String key, Object value) {
        cache.put(key, new CacheEntry(value, DEFAULT_EXPIRY));
    }

    public static Object get(String key) {
        CacheEntry entry = cache.get(key);
        if (entry == null || entry.isExpired()) {
            cache.remove(key);
            return null;
        }
        return entry.getValue();
    }

    public static void clear(String key) {
        cache.remove(key);
    }

    private static class CacheEntry {
        private final Object value;
        private final long expiryTime;

        public CacheEntry(Object value, long duration) {
            this.value = value;
            this.expiryTime = System.currentTimeMillis() + duration;
        }

        public Object getValue() {
            return value;
        }

        public boolean isExpired() {
            return System.currentTimeMillis() > expiryTime;
        }
    }
}
