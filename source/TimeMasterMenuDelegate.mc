import Toybox.System;
import Toybox.WatchUi;
import Toybox.Lang;
class TimeMasterMenuDelegate extends WatchUi.MenuInputDelegate {
    
    function initialize() {
        MenuInputDelegate.initialize();
        System.println("TimeMasterMenuDelegate.mc --- Menu Delegate initialized");
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            System.println("TimeMasterMenuDelegate.mc --- Start Session selected");
            // Trigger start session functionality here
        } else if (item == :item_2) {
            System.println("TimeMasterMenuDelegate.mc --- Settings selected");
            // Trigger settings functionality here
        } else if (item == :item_3) {
            System.println("TimeMasterMenuDelegate.mc --- Change Mode selected");
            // Open the mode selection menu here
            WatchUi.pushView(new ModeSelectionView(), new ModeSelectionDelegate(), WatchUi.SLIDE_UP);
        }
    }
}
