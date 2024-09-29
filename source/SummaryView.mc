using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System;
import Toybox.Lang;

class SummaryView extends Ui.View {
    hidden var _totalTimeLabel;
    hidden var _workTimeLabel;
    hidden var _outdoorTimeLabel;
    hidden var _learningTimeLabel;
    hidden var _miscllTimeLabel;

    function initialize() {
        View.initialize();
        System.println("SummaryView.mc --- SummaryView initialized");
    }

    function onLayout(dc as Gfx.Dc) as Void {
        System.println("SummaryView.mc --- onLayout triggered");
        
        // Load the layout from the resources
        setLayout(Rez.Layouts.SummaryLayout(dc));
        
        // Get the drawable elements
        _totalTimeLabel = findDrawableById("total_time_label");
        _workTimeLabel = findDrawableById("work_time_label");
        _outdoorTimeLabel = findDrawableById("outdoor_time_label");
        _learningTimeLabel = findDrawableById("learning_time_label");
        _miscllTimeLabel = findDrawableById("miscll_time_label");

        updateSummary(); // Update the labels with the actual data
    }

    function onShow() as Void {
        System.println("SummaryView.mc --- View shown");
        View.onShow();  // Call parent function to handle base setup
    }

    function onHide() as Void {
        System.println("SummaryView.mc --- View hidden");
        View.onHide();  // Call parent function to handle base setup
    }

    // Function to convert minutes into "HH:MM" format
    function convertMinutesToHoursMinutes(minutes as Number) as String {
        var hours = minutes / 60;
        var remainingMinutes = minutes % 60;
        return hours.format("%02d") + ":" + remainingMinutes.format("%02d");
    }

    // Update the labels with data from DataManager
    function updateSummary() as Void {
        // Fetch the time values from DataManager (in minutes)
        var totalMinutesInvested = DataManager.getTotalMinutesInvested();  
        var workTime = DataManager.getWorkTime();  
        var outdoorTime = DataManager.getOutdoorTime();
        var learningTime = DataManager.getLearningTime();
        var miscllTime = DataManager.getMiscllTime();

        // Use the local conversion function to display time in "HH:MM" format
        _totalTimeLabel.setText("Total Time: " + convertMinutesToHoursMinutes(totalMinutesInvested));
        _workTimeLabel.setText("Work Time: " + convertMinutesToHoursMinutes(workTime));
        _outdoorTimeLabel.setText("Outdoor Time: " + convertMinutesToHoursMinutes(outdoorTime));
        _learningTimeLabel.setText("Learning Time: " + convertMinutesToHoursMinutes(learningTime));
        _miscllTimeLabel.setText("Miscellaneous Time: " + convertMinutesToHoursMinutes(miscllTime));

        // Request UI update
        WatchUi.requestUpdate();
    }

    function onBack() as Boolean {
        System.println("SummaryView.mc --- Back button pressed, returning to previous menu");
        // Return to the main menu or previous view
        Ui.popView(Ui.SLIDE_DOWN);
        return true;
    }

    function onSelect() as Boolean {
        // No specific action on select, but you can handle it here if needed
        System.println("SummaryView.mc --- Select button pressed");
        return true;
    }
}
