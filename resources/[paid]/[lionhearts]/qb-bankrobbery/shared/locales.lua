local Locales = {
    -- Laptops
    ['laptop_target_label'] = 'Offer Item',
    ['laptop_not_enough'] = 'You don\'t have enough ', -- Leave a space

    -- Main
    ['not_enough_cops'] = 'Not enough cops..',
    ['missing_items'] = 'You are missing some item(s)..',
    ['canceled'] = 'Cancelled..',
    ['trolly_target_label'] = 'Grab Loot',
    ['trolly_hit'] = 'There is nothing to grab anymore..',
    ['locker_target_label'] = 'Open Locker',
    ['locker_missing_drill'] = 'You need a drill for this..',
    ['locker_hit'] = 'The locker is already broken open..',
    ['minigame_failed'] = 'Minigame failed..',
    ['hack_failed'] = 'Hack failed..',
    ['locker_failed'] = 'Failed drilling the locker..',
    ['thermite_success'] = 'The door is burned open!',
    ['thermite_failed'] = 'Thermite failed..',
    ['bank_hacked'] = 'You cracked the security system..',
    ['bank_cooldown'] = 'The security lock is active, opening the door is currently not possible..',
    ['mail_sender'] = 'h4ckerm4n',
    ['mail_message'] = 'I\'ve received your input codes and will now start disabling the security system..<br/>This might take a minute..',

    -- Fleeca
    ['panel_target_hack'] = 'Hack Security',
    ['panel_target_pd'] = 'Close Vault',
    ['keycard_target'] = 'Grab Keycard',
    ['progressbar_laptop'] = 'Connecting the laptop..',
    ['laptop_hit'] = 'Somebody already hacked the security of this bank..',
    ['progressbar_innerpanel'] = 'Starting hack..',
    ['keycard_taken'] = 'The keycard has already been taken..',
    ['keycard_used'] = 'You used the keycard and unlocked the door..',
    ['keycard_toofar'] = 'Nothing happens..',

    -- Paleto
    ['paleto_progressbar_sidehack'] = 'Bypassing security..',
    ['paleto_sidehack_fail'] = 'Security bypass failed..',
    ['paleto_camera_header'] = 'Camera Controls',
    ['paleto_camera_txt'] = 'ESC or click to close',
    ['paleto_hacks_header'] = 'Paleto Bay Bank Controls',
    ['paleto_office_hack_fail'] = 'Tampering with security failed..',
    ['paleto_input_header'] = 'Enter Passcode',
    ['input_submit'] = 'Submit',
    ['paleto_lockdown'] = 'Doing this will trigger the lockdown system..',
    ['paleto_lockdown2'] = 'Maybe you should disable it first?',
    ['paleto_target_sidehack'] = 'Hack Security Panel',
    ['paleto_camera_target'] = 'Camera Controls',
    ['paleto_target_office_hack'] = 'Tamper Secutiy',
    ['paleto_inputs_fail'] = 'Credentials timing mismatch..',
    ['paleto_inputs_success'] = 'Access authorized..',

    -- Pacific
    ['pacific_progressbar_sidehack'] = 'Bypassing security..',
    ['pacific_sidehack_fail'] = 'Security bypass failed..',
    ['pacific_sidehack_hit'] = 'This has already been hacked..',
    ['pacific_need_datakey'] = 'Missing credentials, insert data key..',
    ['pacific_search_drawer'] = 'Searching Drawer..',
    ['pacific_input_header'] = 'Enter Code',
    ['pacific_lockdown_active'] = 'Lockdown is active..',
    ['pacific_cannot_disable_laser'] = 'Cannot disable the power supply, too much voltage!',
    ['pacific_already_disable_laser'] = 'The power supply has already been disabled..',
    ['pacific_vault_not_hit'] = 'You need to bypass the main vault first..',
    ['pacific_target_sidehack'] = 'Hack Security Panel',
    ['pacific_target_hackcomputer'] = 'Hack Computer',
    ['pacific_target_decryptkey'] = 'Decrypt Data Key',
    ['pacific_target_drawers'] = 'Search Drawers',
    ['pacific_target_disablepower'] = 'Disable Power',
    ['pacific_mail_sender'] = 'Trinity',
    ['pacific_mail_subject'] = 'Trinity',
    ['pacific_mail_text1'] = 'You found the first set of vault codes. ',
    ['pacific_mail_text2'] = '<br><br>Try hacking the computers in the other offices. <br><br>The employees are known to use data keys that store their credentials.. <br><br>Maybe you should try finding those first?',
    ['pacific_found_datakey'] = 'You found a data key..',
    ['pacific_found_no_datakey'] = 'You didn\'t find anything..',
    ['pacific_input_authorized'] = 'Access authorized..',
    ['pacific_input_incorrect'] = 'Incorrect credentials..',
    ['pacific_input_timing'] = 'Credentials timing mismatch..',
    ['pacific_hitbylaser'] = 'You notice the laser touching you..',
}

_U = function(entry)
    return Locales[entry]
end
