import Toybox.System;
import Toybox.WatchUi;
import Toybox.Lang;

class TimeMasterMenuDelegate extends WatchUi.MenuInputDelegate {
    hidden var _view;

    function initialize(view) {
        MenuInputDelegate.initialize();
        _view = view;  // Store the view reference
    }

    function onMenuItem(item as Symbol) as Void {
        //System.println("TimeMasterMenuDelegate.mc --- onMenuItem triggered with: " + item);

        if (item == :item_1) {
            //System.println("TimeMasterMenuDelegate.mc --- Start Session selected");
        } else if (item == :item_4) {
            //System.println("TimeMasterMenuDelegate.mc --- Settings selected");
            WatchUi.pushView(new Rez.Menus.TimerSettingsMenu(), new TimerSettingsMenuDelegate(_view), WatchUi.SLIDE_UP);
        }else if (item == :item_0) {
            //System.println("TimeMasterMenuDelegate.mc --- Settings selected");
            //WatchUi.pushView(new Rez.Menus.TimerSettingsMenu(), new TimerSettingsMenuDelegate(_view), WatchUi.SLIDE_UP);
            //startBackgroundMode();

        } else if (item == :item_3) {
            //System.println("TimeMasterMenuDelegate.mc --- Change Mode selected");
            WatchUi.pushView(new Rez.Menus.ModeMenu(), new ModeSelectionDelegate(_view), WatchUi.SLIDE_UP);
        }else if (item == :item_2) {
            //System.println("TimeMasterMenuDelegate.mc --- Change Mode selected");
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }else if (item == :item_5) {
        //System.println("Showing summary...");
        WatchUi.pushView(new SummaryView(), null, WatchUi.SLIDE_UP);
        //showSummary(); 
        }else if (item == :item_6) {
        //System.println("Resetting daily log...");
        resetDailyLog();
        } else if (item == :item_7) {
        //System.println("Resetting all data...");
        resetAllData();
       }


    }

    function resetDailyLog() as Void {
    System.println("DataManager --- Resetting Daily Log");
    
    // Reset daily total invested time to zero
    DataManager.setTotalMinutesInvested(0);
    
    // Optionally, notify the user
    //_view.showAlert("Daily Log Reset!", "Total time spent today has been reset.", WatchUi.ALERT_OK);
    _view.setElapsedTime(0);
    // Update the UI if necessary
    WatchUi.requestUpdate();
}

function resetAllData() as Void {
    System.println("DataManager --- Resetting All Data");

    // Reset all storage values
    DataManager.setWorkTime(0);
    DataManager.setOutdoorTime(0);
    DataManager.setLearningTime(0);
    DataManager.setMiscllTime(0);
    DataManager.setTotalMinutesInvested(0);
    
    // Optionally, notify the user
    //_view.showAlert("All Data Reset!", "All session data has been reset.", WatchUi.ALERT_OK);
    
    // Update the UI to reflect the reset
    _view.setElapsedTime(0);
    WatchUi.requestUpdate();
}

}



    






