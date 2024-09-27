import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Lang;

class TimeMasterDelegate extends WatchUi.BehaviorDelegate {

    hidden var _currentDuration = 1800;  // Default 30 minutes (in seconds)
    hidden var _elapsedTime = 0;  // Total elapsed time in minutes
    hidden var _timer; // Timer instance
    hidden var _view;  // Reference to the current view
    hidden var time_started = false;  // Boolean to check if timer is running
    hidden var paused = false;  // To check if the timer is paused
    hidden var pausedDuration = 0;  // To track the duration while paused

    function initialize(view) {
        BehaviorDelegate.initialize();
        _view = view;
        System.println("TimeMasterDelegate.mc --- Initialized with view");
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new TimeMasterMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onSelect() as Boolean {
        if (time_started) {
            pauseCountdown();  // If timer is running, pause it
        } else if (paused) {
            resumeCountdown();  // If paused, resume it
        } else {
            startCountdown();  // Start countdown if it's not already running
        }
        return true;
    }

    function startCountdown() as Void {
        System.println("TimeMasterDelegate.mc --- Starting countdown");
        time_started = true;
        paused = false;
        _timer = new Timer.Timer();
        _timer.start(method(:countdown), 1000, true);  // Call countdown every second
    }

    function pauseCountdown() as Void {
        System.println("TimeMasterDelegate.mc --- Pausing countdown");
        time_started = false;
        paused = true;
        _timer.stop();  // Stop the timer
        pausedDuration = _currentDuration;  // Save the current duration
    }

    function resumeCountdown() as Void {
        System.println("TimeMasterDelegate.mc --- Resuming countdown");
        time_started = true;
        paused = false;
        _timer.start(method(:countdown), 1000, true);  // Restart countdown
    }

    function countdown() as Void {
        if (_currentDuration > 0) {
            _currentDuration -= 1;  // Decrease timer by 1 second
            System.println("TimeMasterDelegate.mc --- Timer: " + _currentDuration + " seconds left");
            DataManager.setCurrentTimer(_currentDuration);  // Save updated timer
            updateUI();  // Update the UI with the new timer value
        } else {
            endSession();  // End session and reset UI
        }
    }

    function endSession() as Void {
        System.println("TimeMasterDelegate.mc --- Session ended");
        time_started = false;
        _timer.stop();  // Stop the timer
        _currentDuration = 1800;  // Reset timer to 30 minutes
        updateUI();  // Reset UI
    }

    function updateUI() as Void {
        var mode = DataManager.getMode();
        _view.setModeType(mode);  // Use _view to set mode
        _view.setTimer(_currentDuration);  // Update timer in view
        _view.setElapsedTime(_elapsedTime);  // Update elapsed time in view
        WatchUi.requestUpdate();  // Request an update to redraw the UI
    }
}
