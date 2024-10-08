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
        //.println("TimeMasterDelegate.mc --- Initialized with view");
    }

    function onMenu() as Boolean {
    // Ensure to pass _view when initializing TimeMasterMenuDelegate
    WatchUi.pushView(new Rez.Menus.MainMenu(), new TimeMasterMenuDelegate(_view), WatchUi.SLIDE_UP);
    return true;
}
function onBack() as Boolean {
    //.println("TimeMasterDelegate.mc --- Back button pressed");

    if (paused) {
        //.println("TimeMasterDelegate.mc --- Timer paused, showing pause menu");
        WatchUi.pushView(new Rez.Menus.TimerPausedMenu(), new TimerPausedMenuDelegate(_view), WatchUi.SLIDE_UP);  // Pass the delegate
        return true;
    }

    if (time_started) {
        System.println("TimeMasterDelegate --- Timer is running, pausing timer and showing options");
        pauseCountdown();  // Pause the timer
        WatchUi.pushView(new Rez.Menus.TimerPausedMenu(), new TimerPausedMenuDelegate(_view), WatchUi.SLIDE_UP);
        return true;  // Do not exit the app
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
    //.println("TimeMasterDelegate.mc --- Starting countdown");
    _currentDuration = DataManager.getTimerDuration();  // Fetch stored timer duration
    time_started = true;
    paused = false;
    _timer = new Timer.Timer();
    _view.setStatus("Timer Running", Graphics.COLOR_GREEN);
    _timer.start(method(:countdown), 60000, true);  // Call countdown every second
}

    function pauseCountdown() as Void {
        //.println("TimeMasterDelegate.mc --- Pausing countdown");
        time_started = false;
        paused = true;
        _view.setStatus("Timer Paused", Graphics.COLOR_RED); 
        _timer.stop();  // Stop the timer
        pausedDuration = _currentDuration;  // Save the current duration
        DataManager.setCurrentTimer(_currentDuration);
    }

   function resumeCountdown() as Void {
    //.println("TimeMasterDelegate.mc --- Resuming countdown");
    _currentDuration = DataManager.getCurrentTimer();
    time_started = true;
    paused = false;
    _view.setStatus("Timer Running", Graphics.COLOR_GREEN);
    _timer.start(method(:countdown), 60000, true);  // Resume the countdown
    updateUI();  // Ensure UI is updated after resuming
}
    function countdown() as Void {
        
        if (_currentDuration > 0) {
            _currentDuration -= 60;  // Decrease timer by 60 seconds
            //.println("TimeMasterDelegate.mc --- Timer: " + _currentDuration + " seconds left");
            DataManager.setCurrentTimer(_currentDuration);  // Save updated timer
            updateUI();  // Update the UI with the new timer value
        } else {
            endSession();  // End session and reset UI
        }
    }

    function endSession() as Void {
    AlertsManager.triggerDefaultAlert();
    //.println("TimeMasterDelegate.mc --- Session ended");
    time_started = false;
    _view.setStatus("Timer Ended", Graphics.COLOR_WHITE);
    _timer.stop();  // Stop the timer

    // Get the elapsed time for the session and convert to minutes
    var elapsedTimeInSeconds = DataManager.getTimerDuration();
    var elapsedTimeInMinutes = elapsedTimeInSeconds / 60;
    //.println("TimeMasterDelegate.mc --- Elapsed time: " + elapsedTimeInMinutes + " minutes");

    // Get the current mode and update the appropriate time
    var mode = DataManager.getMode();
    //.println("TimeMasterDelegate.mc --- Current mode: " + mode);

    if (mode == 1) {
        var currentWorkTime = DataManager.getWorkTime();
        DataManager.setWorkTime(currentWorkTime + elapsedTimeInMinutes);
        //.println("TimeMasterDelegate.mc --- Work time updated: " + (currentWorkTime + elapsedTimeInMinutes));
    } else if (mode == 2) {
        var currentOutdoorTime = DataManager.getOutdoorTime();
        DataManager.setOutdoorTime(currentOutdoorTime + elapsedTimeInMinutes);
        //.println("TimeMasterDelegate.mc --- Outdoor time updated: " + (currentOutdoorTime + elapsedTimeInMinutes));
    } else if (mode == 3) {
        var currentLearningTime = DataManager.getLearningTime();
        DataManager.setLearningTime(currentLearningTime + elapsedTimeInMinutes);
        //.println("TimeMasterDelegate.mc --- Learning time updated: " + (currentLearningTime + elapsedTimeInMinutes));
    } else if (mode == 4) {
        var currentMiscllTime = DataManager.getMiscllTime();
        DataManager.setMiscllTime(currentMiscllTime + elapsedTimeInMinutes);
        //.println("TimeMasterDelegate.mc --- Miscellaneous time updated: " + (currentMiscllTime + elapsedTimeInMinutes));
    }

    // Update total invested time in minutes
    var totalTime = DataManager.getTotalMinutesInvested();
    DataManager.setTotalMinutesInvested(totalTime + elapsedTimeInMinutes);
    //.println("TimeMasterDelegate.mc --- Total invested time updated: " + (totalTime + elapsedTimeInMinutes));

    // Reset the timer to the default duration and update the UI
    _currentDuration = DataManager.getTimerDuration();  // Reset to default duration
    DataManager.logSession(mode, elapsedTimeInMinutes);
    updateUI();  // Refresh the UI
}


    function updateUI() as Void {
        var mode = DataManager.getMode();
        _view.setModeType(mode);  // Use _view to set mode
        _view.setTimer(_currentDuration);  // Update timer in view
        _view.setElapsedTime(DataManager.getTotalMinutesInvested());  // Update elapsed time in view
        WatchUi.requestUpdate();  // Request an update to redraw the UI
    }

    function resetTimer() as Void {
    //.println("TimeMasterDelegate.mc --- Resetting timer to default duration");
    _currentDuration = DataManager.getTimerDuration();  // Reset to default timer duration from storage
    _elapsedTime = 0;  // Reset elapsed time
    time_started = false;
    updateUI();  // Update the UI to reflect the reset timer
}

}
