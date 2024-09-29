import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

class TimerSettingsMenuDelegate extends WatchUi.MenuInputDelegate {
    hidden var _view;
    function initialize(view as TimeMasterView) {
        MenuInputDelegate.initialize();
        _view = view;
        //System.println("TimerSettingsMenuDelegate --- Initialized with view");
    }
    function onMenuItem(item as Symbol) as Void {
        //System.println("TimerSettingsMenuDelegate --- onMenuItem triggered: " + item);

        if (item == :timer_30) {
            DataManager.setTimerDuration(1800);  // Set 30 minutes
            _view.setTimer(1800);
            DataManager.setCurrentTimer(DataManager.getTimerDuration());

        } else if (item == :timer_45) {
            DataManager.setTimerDuration(2700);  // Set 45 minutes
            _view.setTimer(2700);
            DataManager.setCurrentTimer(DataManager.getTimerDuration());
        } else if (item == :timer_60) {
            DataManager.setTimerDuration(3600);  // Set 60 minutes
            _view.setTimer(3600);
            DataManager.setCurrentTimer(DataManager.getTimerDuration());
        }

        //System.println("TimerSettingsMenuDelegate --- Timer Duration updated to: " + DataManager.getTimerDuration());
        WatchUi.popView(WatchUi.SLIDE_DOWN);  // Go back to the previous view
    }
}
