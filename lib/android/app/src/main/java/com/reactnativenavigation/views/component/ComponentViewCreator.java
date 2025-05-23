package com.reactnativenavigation.views.component;

import android.app.Activity;

import com.facebook.react.ReactInstanceManager;
import com.reactnativenavigation.viewcontrollers.viewcontroller.IReactView;
import com.reactnativenavigation.viewcontrollers.viewcontroller.ReactViewCreator;
import com.reactnativenavigation.react.ReactComponentViewCreator;
import com.reactnativenavigation.react.ReactView;

public class ComponentViewCreator implements ReactViewCreator {
	@Override
	public IReactView create(Activity activity, String componentId, String componentName) {
        ReactView reactView = new ReactComponentViewCreator().create(activity, componentId, componentName);
        return new ComponentLayout(activity, reactView);
	}
}
