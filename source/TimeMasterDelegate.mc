import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Application;

class TimeMasterDelegate extends WatchUi.BehaviorDelegate {

    hidden var _currentDuration = 1800;  // Default 30 minutes (in seconds)
    hidden var _elapsedTime = 0;  // Total elapsed time in minutes
    hidden var _timer; // Timer instance
    hidden var _view;  // Reference to the current view
    hidden var time_started = false;  // Boolean to check if timer is running
    hidden var selectedMode = 1;  // Default mode set to 1 (Work mode)

    function initialize() {
        System.println("Initializing TimeMasterDelegate");
        BehaviorDelegate.initialize();
        _currentDuration = DataManager.getCurrentTimer();  // Fetch the saved timer value
        System.println("Initial Timer Duration: " + _currentDuration + " seconds");
    }

    // Define getView() to return the main view
    function getView() as WatchUi.View {
        System.println("Getting the view");
        return new TimeMasterView();  // Your main view class
    }

    function onMenu() as Boolean {
        System.println("Menu opened");
        WatchUi.pushView(new Rez.Menus.MainMenu(), new TimeMasterMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    // Triggered when the user selects an option
    function onSelect() as Boolean {
        System.println("Option selected");
        if (!time_started) {
            System.println("Starting the countdown");
            startCountdown();  // Start countdown if it's not already running
        } else {
            System.println("Timer is already running");
        }
        return true;
    }

    // Start the countdown
    function startCountdown() as Void {
        System.println("Countdown started");
        time_started = true;
        _timer = new Timer.Timer();
        _timer.start(method(:countdown), 1000, true);  // Call countdown every second
    }

    // Countdown logic, decreases the timer each second
    function countdown() as Void {
        System.println("Countdown ticking...");
        if (_currentDuration > 0) {
            _currentDuration -= 1;  // Decrease timer by 1 second
            System.println("Time remaining: " + _currentDuration + " seconds");
            DataManager.setCurrentTimer(_currentDuration);  // Save updated timer
        } else {
            System.println("Timer finished");
            time_started = false;  // Reset time_started when countdown finishes
            _timer.stop();  // Stop the timer
            endSession();  // End session and reset UI
        }
    }

    // Update the UI with new timer value
    function updateUI() as Void {
        System.println("Updating UI with new timer: " + _currentDuration + " seconds");
        //_view.setTimer(_currentDuration);
    }

    // End session logic
    function endSession() as Void {
        System.println("Ending session and resetting the timer");
        _currentDuration = DataManager.getCurrentTimer();  // Reset duration to the original value
        //_view.setTimer(_currentDuration);  // Update the UI with the reset timer
    }
}
