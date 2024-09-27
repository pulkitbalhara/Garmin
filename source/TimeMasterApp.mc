import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class TimeMasterApp extends Application.AppBase {

    function initialize() {
        System.println("Initializing TimeMasterApp...");
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        System.println("App has started.");
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        System.println("App is stopping.");
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        System.println("Returning initial view...");
        return [ new TimeMasterView(), new TimeMasterDelegate() ];
    }
}

// Get the application instance
function getApp() as TimeMasterApp {
    System.println("Getting the TimeMasterApp instance...");
    return Application.getApp() as TimeMasterApp;
}
