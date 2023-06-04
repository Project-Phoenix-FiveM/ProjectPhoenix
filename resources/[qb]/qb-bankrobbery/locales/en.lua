local Translations = {
    success = {
        success_message = "Successful",
        fuses_are_blown = "The fuses have been blown",
        door_has_opened = "The door has opened"
    },
    error = {
        cancel_message = "Cancelled",
        safe_too_strong = "Looks like the safe lock is too strong...",
        missing_item = "You're missing an item...",
        bank_already_open = "The bank is already open...",
        minimum_police_required = "Minimum of %{police} police required",
        security_lock_active = "The security lock is active, opening the door is currently not possible",
        wrong_type = "%{receiver} did not receive the right type for argument '%{argument}'\nreceived type: %{receivedType}\nreceived value: %{receivedValue}\n expected type: %{expected}",
        fuses_already_blown = "The fuses are already blown...",
        event_trigger_wrong = "%{event}%{extraInfo} was triggered when some conditions weren't met, source: %{source}",
        missing_ignition_source = "You're missing an ignition source"
    },
    general = {
        breaking_open_safe = "Breaking the safe open...",
        connecting_hacking_device = "Connecting the hacking device...",
        fleeca_robbery_alert = "Fleeca bank robbery attempt",
        paleto_robbery_alert = "Blain County Savings bank robbery attempt",
        pacific_robbery_alert = "Pacific Standard Bank robbery attempt",
        break_safe_open_option_target = "Break Safe Open",
        break_safe_open_option_drawtext = "[E] Break open the safe",
        validating_bankcard = "Validating Card...",
        thermite_detonating_in_seconds = "Thermite is going off in %{time} second(s)",
        bank_robbery_police_call = "10-90: Bank Robbery"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
