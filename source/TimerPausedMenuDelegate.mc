import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

class TimerPausedMenuDelegate extends WatchUi.MenuInputDelegate {

    hidden var _view;  // Add _view to refer to the view instance

    // Constructor to initialize with view
    function initialize(view) {
        MenuInputDelegate.initialize();
        _view = view;
        //System.println("TimerPausedMenuDelegate.mc --- Delegate initialized");
    }

    function onMenuItem(item as Symbol) as Void {
        //System.println("TimerPausedMenuDelegate.mc --- onMenuItem triggered with: " + item);

        if (item == :resume) {
            //System.println("TimerPausedMenuDelegate.mc --- Resuming session");
            // Fetch the current timer and update the view
            _view.setTimer(DataManager.getCurrentTimer());  
            //_view.startCountdown();  // Resume the countdown timer
            //WatchUi.popView();  // Close the paused menu and return to the main view
        } else if (item == :discard) {
            //System.println("TimerPausedMenuDelegate.mc --- Discarding session");
            // Reset the timer to the default duration
            _view.setTimer(DataManager.getTimerDuration());
            DataManager.setCurrentTimer(DataManager.getTimerDuration());
            //_view.resetTimer();  // Reset the timer in the view
            //WatchUi.popView();  // Close the paused menu and return to the main view
        } else if (item == :save) {
            //System.println("TimerPausedMenuDelegate.mc --- Placeholder for saving session");
            // Placeholder: Future implementation for saving session
            saveSession();
            //WatchUi.popView();
            AlertsManager.triggerVibration(50,1000);
            _view.setStatus("Timer Ended", Graphics.COLOR_WHITE);
        }
    }


    function saveSession() as Void {
    //System.println("TimerPausedMenuDelegate.mc --- Saving session");

    // Calculate elapsed time in minutes
    var elapsedTime = (DataManager.getTimerDuration() - DataManager.getCurrentTimer()) / 60;
    //System.println("TimerPausedMenuDelegate.mc --- Elapsed time: " + elapsedTime + " minutes");

    // Get the current mode
    var mode = DataManager.getMode();
    //System.println("TimerPausedMenuDelegate.mc --- Current mode: " + mode);

    // Update the appropriate mode time
    // Update Work time
if (mode == 1) {
    var currentWorkTime = DataManager.getWorkTime();
    if (currentWorkTime == null) { currentWorkTime = 0; }
    DataManager.setWorkTime(currentWorkTime + elapsedTime);
    //System.println("TimerPausedMenuDelegate.mc --- Work time updated: " + (currentWorkTime + elapsedTime));
}
// Update Outdoor time
else if (mode == 2) {
    var currentOutdoorTime = DataManager.getOutdoorTime();
    if (currentOutdoorTime == null) { currentOutdoorTime = 0; }
    DataManager.setOutdoorTime(currentOutdoorTime + elapsedTime);
    //System.println("TimerPausedMenuDelegate.mc --- Outdoor time updated: " + (currentOutdoorTime + elapsedTime));
}
// Update Learning time
else if (mode == 3) {
    var currentLearningTime = DataManager.getLearningTime();
    if (currentLearningTime == null) { currentLearningTime = 0; }
    DataManager.setLearningTime(currentLearningTime + elapsedTime);
    //System.println("TimerPausedMenuDelegate.mc --- Learning time updated: " + (currentLearningTime + elapsedTime));
}
// Update Miscellaneous time
else if (mode == 4) {
    var currentMiscllTime = DataManager.getMiscllTime();
    if (currentMiscllTime == null) { currentMiscllTime = 0; }
    DataManager.setMiscllTime(currentMiscllTime + elapsedTime);
    //System.println("TimerPausedMenuDelegate.mc --- Miscellaneous time updated: " + (currentMiscllTime + elapsedTime));
}

    // Update total invested time
    var totalTime = DataManager.getTotalMinutesInvested();
    DataManager.setTotalMinutesInvested(totalTime + elapsedTime);
    //System.println("TimerPausedMenuDelegate.mc --- Total invested time updated: " + (totalTime + elapsedTime));
    DataManager.logSession(mode, elapsedTime);
    // Reset the timer and elapsed time in the view
    _view.setTimer(DataManager.getTimerDuration());  // Reset to default duration
    _view.setElapsedTime(DataManager.getTotalMinutesInvested());  // Set elapsed time from total invested time
    DataManager.setCurrentTimer(DataManager.getTimerDuration());
    // End the session and reset UI
    _view.requestUpdate();
    
    //System.println("TimerPausedMenuDelegate.mc --- Session saved and ended");
}

}
