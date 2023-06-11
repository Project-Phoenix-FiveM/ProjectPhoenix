Config = Config or {}

Config.menu = 'keep-menu' -- keep-menu / qb-menu

Config.intraction = {
     npc = {
          model = 'MP_F_ExecPA_01',
          variant = {
               [2] = {
                    -- hair
                    drawableId = 1,
                    textureId = 0,
               },
               [3] = {
                    -- upper
                    drawableId = 2,
                    textureId = 0,
               },
               [4] = {
                    -- lower
                    drawableId = 2,
                    textureId = 2,
               },
               [6] = {
                    -- feet
                    drawableId = 0,
                    textureId = 0,
               },
               [7] = {
                    -- teef
                    drawableId = 0,
                    textureId = 2,
               },
               [8] = {
                    -- accs
                    drawableId = 2,
                    textureId = 1,
               },
               [11] = {
                    -- jbib
                    drawableId = 1,
                    textureId = 1,
               }
          },
          coords = vector4(257.51, 228.19, 105.28, 157.27),
          voice = 'A_F_Y_BUSINESS_02_WHITE_FULL_01',
          --[[ animDict = 'anim@amb@board_room@stenographer@computer@',
          anim = {
               'glance_board_01_left_amy_skater_01',
               'idle_01_right_amy_skater_01',
               'idle_02_left_amy_skater_01',
               'idle_02_right_amy_skater_01',
               'investigate_compueter_01_left_amy_skater_01',
               'investigate_computer_01_right_amy_skater_01',
               'look_around_01_left_amy_skater_01',
               'look_around_01_right_amy_skater_01',
               'look_around_02_left_amy_skater_01',
               'look_around_02_right_amy_skater_01',
               'scratch_leg_01_left_amy_skater_01',
               'scratch_leg_01_right_amy_skater_01',
               'tired_01_left_amy_skater_01',
               'tired_01_right_amy_skater_01',
          }, ]]
          flag = 1,
          freeze = true,
          invincible = true,
          blockevents = true,
     },
     box = {
          minz_offset = -1,
          maxz_offset = 1.75,
          w = 1.5,
          l = 2.35,
          heading = 160.0
     }
}
