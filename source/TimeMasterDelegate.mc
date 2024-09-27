import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Lang;

class TimeMasterDelegate extends WatchUi.BehaviorDelegate {

    hidden var _currentDuration = DataManager.getCurrentTimer();  // Default 30 minutes (in seconds)
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
    // Ensure to pass _view when initializing TimeMasterMenuDelegate
    WatchUi.pushView(new Rez.Menus.MainMenu(), new TimeMasterMenuDelegate(_view), WatchUi.SLIDE_UP);
    return true;
}
function onBack() as Boolean {
    System.println("TimeMasterDelegate.mc --- Back button pressed");

    if (paused) {
        System.println("TimeMasterDelegate.mc --- Timer paused, showing pause menu");
        WatchUi.pushView(new Rez.Menus.TimerPausedMenu(), new TimerPausedMenuDelegate(_view), WatchUi.SLIDE_UP);  // Pass the delegate
        return true;
    }

    return false;
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
    _currentDuration = DataManager.getTimerDuration();  // Fetch stored timer duration
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
        DataManager.setCurrentTimer(_currentDuration);
    }

   function resumeCountdown() as Void {
    System.println("TimeMasterDelegate.mc --- Resuming countdown");
    _currentDuration = DataManager.getCurrentTimer();
    time_started = true;
    paused = false;
    _timer.start(method(:countdown), 1000, true);  // Resume the countdown
    updateUI();  // Ensure UI is updated after resuming
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

    // Get the elapsed time for the session and convert to minutes
    var elapsedTimeInSeconds = DataManager.getTimerDuration();
    var elapsedTimeInMinutes = elapsedTimeInSeconds / 60;
    System.println("TimeMasterDelegate.mc --- Elapsed time: " + elapsedTimeInMinutes + " minutes");

    // Get the current mode and update the appropriate time
    var mode = DataManager.getMode();
    System.println("TimeMasterDelegate.mc --- Current mode: " + mode);

    if (mode == 1) {
        var currentWorkTime = DataManager.getWorkTime();
        DataManager.setWorkTime(currentWorkTime + elapsedTimeInMinutes);
        System.println("TimeMasterDelegate.mc --- Work time updated: " + (currentWorkTime + elapsedTimeInMinutes));
    } else if (mode == 2) {
        var currentOutdoorTime = DataManager.getOutdoorTime();
        DataManager.setOutdoorTime(currentOutdoorTime + elapsedTimeInMinutes);
        System.println("TimeMasterDelegate.mc --- Outdoor time updated: " + (currentOutdoorTime + elapsedTimeInMinutes));
    } else if (mode == 3) {
        var currentLearningTime = DataManager.getLearningTime();
        DataManager.setLearningTime(currentLearningTime + elapsedTimeInMinutes);
        System.println("TimeMasterDelegate.mc --- Learning time updated: " + (currentLearningTime + elapsedTimeInMinutes));
    } else if (mode == 4) {
        var currentMiscllTime = DataManager.getMiscllTime();
        DataManager.setMiscllTime(currentMiscllTime + elapsedTimeInMinutes);
        System.println("TimeMasterDelegate.mc --- Miscellaneous time updated: " + (currentMiscllTime + elapsedTimeInMinutes));
    }

    // Update total invested time in minutes
    var totalTime = DataManager.getTotalMinutesInvested();
    DataManager.setTotalMinutesInvested(totalTime + elapsedTimeInMinutes);
    System.println("TimeMasterDelegate.mc --- Total invested time updated: " + (totalTime + elapsedTimeInMinutes));

    // Reset the timer to the default duration and update the UI
    _currentDuration = DataManager.getTimerDuration();  // Reset to default duration
    updateUI();  // Refresh the UI
}


    function updateUI() as Void {
        var mode = DataManager.getMode();
        _view.setModeType(mode);  // Use _view to set mode
        _view.setTimer(_currentDuration);  // Update timer in view
        _view.setElapsedTime(_elapsedTime);  // Update elapsed time in view
        WatchUi.requestUpdate();  // Request an update to redraw the UI
    }

    function resetTimer() as Void {
    System.println("TimeMasterDelegate.mc --- Resetting timer to default duration");
    _currentDuration = DataManager.getTimerDuration();  // Reset to default timer duration from storage
    _elapsedTime = 0;  // Reset elapsed time
    time_started = false;
    updateUI();  // Update the UI to reflect the reset timer
}

}
