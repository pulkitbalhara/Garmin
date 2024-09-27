import Toybox.System;
import Toybox.WatchUi;
import Toybox.Lang;

class TimeMasterMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        System.println("TimeMasterMenuDelegate.mc --- Initializing TimeMasterMenuDelegate");
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            System.println("TimeMasterMenuDelegate.mc --- Start Session selected");
            // In the future, we can trigger start session functionality
        } else if (item == :item_2) {
            System.println("TimeMasterMenuDelegate.mc --- Settings selected");
            // In the future, we can add settings functionality
        }
    }
}
