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
        System.println("TimeMasterMenuDelegate.mc --- onMenuItem triggered with: " + item);

        if (item == :item_1) {
            System.println("TimeMasterMenuDelegate.mc --- Start Session selected");
        } else if (item == :item_2) {
            System.println("TimeMasterMenuDelegate.mc --- Settings selected");
            WatchUi.pushView(new Rez.Menus.TimerSettingsMenu(), new TimerSettingsMenuDelegate(_view), WatchUi.SLIDE_UP);
        } else if (item == :item_3) {
            System.println("TimeMasterMenuDelegate.mc --- Change Mode selected");
            WatchUi.pushView(new Rez.Menus.ModeMenu(), new ModeSelectionDelegate(_view), WatchUi.SLIDE_UP);
        }
    }
}

