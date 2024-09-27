import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class TimeMasterView extends WatchUi.View {
    var mode = 1;  // Class-level mode
    var timer = 1800;  // 30 minutes in seconds
    var elapsed = 0; // Elapsed time in hours
    
    var _mode_label; 
    var _timer_label;
    var _elapsed_label;

    function initialize() {
        View.initialize();
        System.println("TimeMasterView.mc --- View initialized");
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));  // Load the updated layout
        _mode_label = findDrawableById("mode_label");
        _timer_label = findDrawableById("timer_label");  // Retrieve timer label
        _elapsed_label = findDrawableById("elapsed_label");  // Retrieve elapsed label
        
        System.println("TimeMasterView.mc --- Layout set, labels loaded");
        setModeType(1);  // Example: Set mode to Outdoor
        setTimer(DataManager.getCurrentTimer());  // Example: Set timer to 30:00 (1800 seconds)
        setElapsedTime(0);  // Example: Set elapsed time to 2 hours (7200 seconds)
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        System.println("TimeMasterView.mc --- View updated");
    }

    function onShow() as Void {
        System.println("TimeMasterView.mc --- View shown");
    }

    function onHide() as Void {
        System.println("TimeMasterView.mc --- View hidden");
    }

    // Updated setModeType to use class-level mode
    function setModeType(modeNumber as Number) as Void {
        var mode;
        switch(modeNumber) {
            case 1:
                mode = "Work";
                break;
            case 2:
                mode = "Outdoor";
                break;
            case 3:
                mode = "Learning";
                break;
            case 4:
                mode = "Miscellaneous";
                break;
            default:
                mode = "Work";  // Default to Work if no valid input
        }
        System.println("TimeMasterView.mc --- Mode set to: " + mode);
        _mode_label.setText(mode);  // Update the label
        WatchUi.requestUpdate();  // Refresh the UI to reflect the change
    }

    function setTimer(seconds as Number) as Void {
        var minutes = seconds / 60;
        var remainingSeconds = seconds % 60;
        var formattedTime = minutes.format("%02d") + ":" + remainingSeconds.format("%02d");
        
        _timer_label.setText(formattedTime);  // Update the timer label
        System.println("TimeMasterView.mc --- Timer set to: " + formattedTime);
        WatchUi.requestUpdate();  // Refresh the UI to reflect the change
    }

    function setElapsedTime(minutes as Number) as Void {
        var hours = minutes / 60;
        var remainingMinutes = minutes % 60;
        
        var formattedElapsedTime = hours.format("%02d") + ":" + remainingMinutes.format("%02d");
        
        _elapsed_label.setText(formattedElapsedTime);  // Update the elapsed time label
        System.println("TimeMasterView.mc --- Elapsed time set to: " + formattedElapsedTime);
        WatchUi.requestUpdate();  // Refresh the UI to reflect the change
    }

    
}
