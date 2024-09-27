import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class TimeMasterView extends WatchUi.View {
    var mode = 1;  // Class-level mode
    var timer = 1800;  // 30 minutes in seconds
    var elapsed = 0.2; // Elapsed time in hours
    
    var _mode_label; 
    var _timer_label;
    var _elapsed_label;

    function initialize() {
        System.println("TimeMasterView.mc --- Initializing TimeMasterView");
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        System.println("TimeMasterView.mc --- onLayout called");
        setLayout(Rez.Layouts.MainLayout(dc));  // Load the updated layout
        _mode_label = findDrawableById("mode_label");
        _timer_label = findDrawableById("timer_label");  // Retrieve timer label
        _elapsed_label = findDrawableById("elapsed_label");  // Retrieve elapsed label

        System.println("TimeMasterView.mc --- Setting mode to Outdoor");
        setModeType(2);  // Example: Set mode to Outdoor
        setTimer(259);
        setElapsedTime(110);  // Example: Set timer to 30:00 (1800 seconds)
        System.println("TimeMasterView.mc --- Layout setup complete");
    }

    function onUpdate(dc as Dc) as Void {
        System.println("TimeMasterView.mc --- Updating view");
        View.onUpdate(dc);
    }

    function onShow() as Void {
        System.println("TimeMasterView.mc --- View is now visible (onShow)");
    }

    function onHide() as Void {
        System.println("TimeMasterView.mc --- View is being hidden (onHide)");
    }

    // Updated setModeType to use class-level mode
    function setModeType(modeNumber as Number) as Void {
        System.println("TimeMasterView.mc --- setModeType called with modeNumber: " + modeNumber);
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
        System.println("TimeMasterView.mc --- setTimer called with seconds: " + seconds);
        var minutes = seconds / 60;
        var remainingSeconds = seconds % 60;
        var formattedTime = minutes.format("%02d") + ":" + remainingSeconds.format("%02d");
        
        _timer_label.setText(formattedTime);  // Update the timer label
        System.println("TimeMasterView.mc --- Timer updated to: " + formattedTime);
        WatchUi.requestUpdate();  // Refresh the UI to reflect the change
    }

    function setElapsedTime(minutes as Number) as Void {
        System.println("TimeMasterView.mc --- setElapsedTime called with minutes: " + minutes);
        var hours = minutes / 60;
        var remainingMinutes = minutes % 60;
        
        var formattedElapsedTime = hours.format("%02d") + ":" + remainingMinutes.format("%02d");
        
        _elapsed_label.setText(formattedElapsedTime);  // Update the elapsed time label
        System.println("TimeMasterView.mc --- Elapsed time updated to: " + formattedElapsedTime);
        WatchUi.requestUpdate();  // Refresh the UI to reflect the change
    }
}
