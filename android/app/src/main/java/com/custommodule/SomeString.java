package com.custommodule;

import android.support.annotation.Nullable;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.modules.core.DeviceEventManagerModule;

public class SomeString extends ReactContextBaseJavaModule {
    public SomeString(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "SomeString";
    }

    /**
     * hello method, return simple string back to js world using callback
     *
     * @param name String
     * @param callback Callback
     */
    @ReactMethod
    public void hello(String name, Callback callback) {
        String helloString = "Hi " + name + ", This message from native";
        callback.invoke(helloString);
    }

    /**
     * async await method
     *
     * @param value Boolean
     * @param promise Promise
     */
    @ReactMethod
    public void isString(String value, Promise promise) {
        try {
            Boolean isInt = isInteger(value,10);
            if(isInt) {
                String string = String.format(" %s, This is not string.", value);
                throw new Exception(string);
            }
            String data = String.format(" %s, This is string.", value);
            promise.resolve(data);
        }catch(Exception e) {
            promise.reject(e);
        }
    }

    public static boolean isInteger(String s, int radix) {
    if(s.isEmpty()) return false;
    for(int i = 0; i < s.length(); i++) {
        if(i == 0 && s.charAt(i) == '-') {
            if(s.length() == 1) return false;
            else continue;
        }
        if(Character.digit(s.charAt(i),radix) < 0) return false;
    }
    return true;
}



}