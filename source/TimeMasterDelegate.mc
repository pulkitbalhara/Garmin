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

    function initialize(view as WatchUi.View) {
        BehaviorDelegate.initialize();
        _view = view;  // Get the view reference from TimeMasterApp
        _currentDuration = DataManager.getCurrentTimer();  // Fetch the saved timer value
          // Fetch total time from DataManager
        System.println("TimeMasterDelegate.mc --- Initialized with _currentDuration: " + _currentDuration + ", _elapsedTime: " + _elapsedTime);
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new TimeMasterMenuDelegate(), WatchUi.SLIDE_UP);
        System.println("TimeMasterDelegate.mc --- Menu opened");
        return true;
    }

    function onSelect() as Boolean {
        if (!time_started) {
            System.println("TimeMasterDelegate.mc --- Starting countdown");
            startCountdown();  // Start countdown if it's not already running
        } else {
            System.println("TimeMasterDelegate.mc --- Timer is already running");
        }
        return true;
    }

    function startCountdown() as Void {
        time_started = true;
        _timer = new Timer.Timer();
        _timer.start(method(:countdown), 1000, true);  // Call countdown every second
        System.println("TimeMasterDelegate.mc --- Countdown started");
    }

    function countdown() as Void {
        if (_currentDuration > 0) {
            _currentDuration -= 1;  // Decrease timer by 1 second
            DataManager.setCurrentTimer(_currentDuration);  // Save updated timer
            System.println("TimeMasterDelegate.mc --- Countdown: " + _currentDuration + " seconds remaining");
            updateUI();  // Update the UI with the new timer value
        } else {
            time_started = false;  // Reset time_started when countdown finishes
            _timer.stop();  // Stop the timer
            System.println("TimeMasterDelegate.mc --- Countdown finished, timer stopped");
            endSession();  // End session and reset UI
        }
    }

    function updateUI() as Void {
        _view.setTimer(_currentDuration);
        _view.setElapsedTime(_elapsedTime);
        System.println("TimeMasterDelegate.mc --- UI updated with current timer: " + _currentDuration + ", elapsed time: " + _elapsedTime);
    }

    function endSession() as Void {
        _currentDuration = DataManager.getCurrentTimer();  // Reset duration to the original value
        System.println("TimeMasterDelegate.mc --- Session ended, timer reset to: " + _currentDuration);
        updateUI();  // Update the UI with the reset timer
    }
}
