import Toybox.Application;
import Toybox.Lang;
import Toybox.System;

class DataManager {

    // Fetches the saved mode from the application properties
    static function getMode() as Number {
        System.println("DataManager.mc --- Fetching Mode from Properties");
        return Application.Properties.getValue("Mode");
    }

    // Saves the mode to the application properties
    static function setMode(mode as Number) as Void {
        System.println("DataManager.mc --- Saving Mode to Properties: " + mode);
        Application.Properties.setValue("Mode", mode);
    }

    // Fetches the current timer value
    static function getCurrentTimer() as Number {
        System.println("DataManager.mc --- Fetching Timer from Properties");
        return Application.Properties.getValue("CurrentTimer");
    }

    // Saves the current timer value
    static function setCurrentTimer(timer as Number) as Void {
        System.println("DataManager.mc --- Saving Timer to Properties: " + timer);
        Application.Properties.setValue("CurrentTimer", timer);
    }

    // Fetches the total invested time
    static function getTotalMinutesInvested() as Number {
        System.println("DataManager.mc --- Fetching TotalMinutesInvested from Properties");
        return Application.Properties.getValue("TotalMinutesInvested");
    }

    // Saves the total invested time
    static function setTotalMinutesInvested(minutes as Number) as Void {
        System.println("DataManager.mc --- Saving TotalMinutesInvested to Properties: " + minutes);
        Application.Properties.setValue("TotalMinutesInvested", minutes);
    }
}
