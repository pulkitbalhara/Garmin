import Toybox.Application;
import Toybox.Lang;

class DataManager {
    
    // Get the current timer value, handle case where property doesn't exist yet
    static function getCurrentTimer() as Number {
        var value = Application.Properties.getValue("CurrentTimer");
        if (value == null) {
            Application.Properties.setValue("CurrentTimer", 1800);  // Initialize to 1800 seconds if not set
            return 1800;
        }
        return value;
    }

    // Set the current timer value
    static function setCurrentTimer(timer as Number) as Void {
        Application.Properties.setValue("CurrentTimer", timer);
    }
}
