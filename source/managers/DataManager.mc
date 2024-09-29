import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
class DataManager {

    // Fetches the saved mode from the application properties
    static function getMode() as Number {
        //System.println("DataManager.mc --- Fetching Mode from Properties");
        return Application.Properties.getValue("Mode");
    }

    // Saves the mode to the application properties
    static function setMode(mode as Number) as Void {
        //System.println("DataManager.mc --- Saving Mode to Properties: " + mode);
        Application.Properties.setValue("Mode", mode);
    }

    // Fetches the current timer value
    static function getCurrentTimer() as Number {
        //System.println("DataManager.mc --- Fetching Timer from Properties");
        return Application.Properties.getValue("CurrentTimer");
    }

    // Saves the current timer value
    static function setCurrentTimer(timer as Number) as Void {
        //System.println("DataManager.mc --- Saving Timer to Properties: " + timer);
        Application.Properties.setValue("CurrentTimer", timer);
    }

    // Fetches the total invested time
    static function getTotalMinutesInvested() as Number {
        //System.println("DataManager.mc --- Fetching TotalMinutesInvested from Properties");
        return Application.Storage.getValue("TotalMinutesInvested");
    }

    // Saves the total invested time
    static function setTotalMinutesInvested(minutes as Number) as Void {
        //System.println("DataManager.mc --- Saving TotalMinutesInvested to Properties: " + minutes);
        Application.Storage.setValue("TotalMinutesInvested", minutes);
    }


    // Work time
    static function getWorkTime() as Number {
        return Application.Storage.getValue("WorkTime");
    }

    static function setWorkTime(time as Number) as Void {
        Application.Storage.setValue("WorkTime", time);
    }

    // Outdoor time
    static function getOutdoorTime() as Number {
        return Application.Storage.getValue("OutdoorTime");
    }

    static function setOutdoorTime(time as Number) as Void {
        Application.Storage.setValue("OutdoorTime", time);
    }

    // Learning time
    static function getLearningTime() as Number {
        return Application.Storage.getValue("LearningTime");
    }

    static function setLearningTime(time as Number) as Void {
        Application.Storage.setValue("LearningTime", time);
    }

    // Miscellaneous time
    static function getMiscllTime() as Number {
        return Application.Storage.getValue("MiscllTime");
    }

    static function setMiscllTime(time as Number) as Void {
        Application.Storage.setValue("MiscllTime", time);
    }

    static function getTimerDuration() as Number {
        //System.println("DataManager.mc --- Fetching TimerDuration from Properties");
        return Application.Storage.getValue("TimerDuration");
    }

    // Saves the TimerDuration to the application properties
    static function setTimerDuration(timerDuration as Number) as Void {
        //System.println("DataManager.mc --- Saving TimerDuration to Properties: " + timerDuration);
        Application.Storage.setValue("TimerDuration", timerDuration);
    }

   static function initializeData() as Void {
    var minutesDaily = DataManager.getTotalMinutesInvested();
    if (minutesDaily == null) {
        //System.println("initializeData.mc --- TimerDuration is null, setting default to 1800");
        DataManager.setTotalMinutesInvested(0);  // Default to 1800 seconds (30 minutes)
    } else {
        //System.println("initializeData.mc --- TimerDuration found: " + timerDuration);
    }

    // Check and initialize TimerDuration
    var timerDuration = DataManager.getTimerDuration();
    if (timerDuration == null) {
        //System.println("initializeData.mc --- TimerDuration is null, setting default to 1800");
        DataManager.setTimerDuration(1800);  // Default to 1800 seconds (30 minutes)
    } else {
        //System.println("initializeData.mc --- TimerDuration found: " + timerDuration);
    }

    // Check and initialize WorkTime
    var workTime = DataManager.getWorkTime();
    if (workTime == null) {
        //System.println("initializeData.mc --- WorkTime is null, setting default to 0");
        DataManager.setWorkTime(0);  // Default to 0
    } else {
        //System.println("initializeData.mc --- WorkTime found: " + workTime);
    }

    // Check and initialize OutdoorTime
    var outdoorTime = DataManager.getOutdoorTime();
    if (outdoorTime == null) {
        //System.println("initializeData.mc --- OutdoorTime is null, setting default to 0");
        DataManager.setOutdoorTime(0);  // Default to 0
    } else {
        //System.println("initializeData.mc --- OutdoorTime found: " + outdoorTime);
    }

    // Check and initialize LearningTime
    var learningTime = DataManager.getLearningTime();
    if (learningTime == null) {
        //System.println("initializeData.mc --- LearningTime is null, setting default to 0");
        DataManager.setLearningTime(0);  // Default to 0
    } else {
        //System.println("initializeData.mc --- LearningTime found: " + learningTime);
    }

    // Check and initialize MiscllTime
    var miscllTime = DataManager.getMiscllTime();
    if (miscllTime == null) {
        //System.println("initializeData.mc --- MiscllTime is null, setting default to 0");
        DataManager.setMiscllTime(0);  // Default to 0
    } else {
        //System.println("initializeData.mc --- MiscllTime found: " + miscllTime);
    }
}

static function logSession(mode as Number, sessionTime as Number) as Void {
    var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    var logEntry = Lang.format(
        "$1$:$2$:$3$-$4$-$5$/$6$/$7$, Mode: $8$, SessionTime: $9$ minutes",
        [
            today.hour,
            today.min,
            today.sec,
            today.day_of_week,
            today.day,
            today.month,
            today.year,
            mode,
            sessionTime
        ]
    );

    var sessionLog = Storage.getValue("SessionLog");
    if (sessionLog == null) {
        sessionLog = "";  // Initialize an empty string if no log exists
    }

    // Append the new log entry
    sessionLog += logEntry + "\n";
    System.println("Session logged: " + logEntry);
    Storage.setValue("SessionLog", sessionLog);
}



}
