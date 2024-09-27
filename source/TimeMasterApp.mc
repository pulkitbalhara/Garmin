import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class TimeMasterApp extends Application.AppBase {

    hidden var _view;  // Declare the view to persist throughout app lifecycle
    hidden var _initializedValue = 1800;  // Example variable initialization for timer (30 minutes)

    function initialize() {
        AppBase.initialize();
        //System.println("TimeMasterApp.mc --- App initialized with timer value: " + _initializedValue);
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        _view = new TimeMasterView();  // Initialize the view here once
        DataManager.initializeData();
        //System.println("TimeMasterApp.mc --- onStart triggered");
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        //System.println("TimeMasterApp.mc --- onStop triggered");
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        //System.println("TimeMasterApp.mc --- Initial view returned");
        return [ _view, new TimeMasterDelegate(_view) ];  // Pass the same view to the delegate
    }
}

function getApp() as TimeMasterApp {
    return Application.getApp() as TimeMasterApp;
}
