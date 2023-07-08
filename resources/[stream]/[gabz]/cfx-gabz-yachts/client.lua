--[[

--------------------------------------------
Customization of each yatch explained:
--------------------------------------------

In the stream folder you can find each ipl ymap per yacht, if you want to change the color on
a yacht you can open the ymap either in OpenIV or Codewalker and change the "tint Value" on the items named:
"apa_mp_apa_yacht" and "apa_mp_apa_yacht_option3"

Color list:

Pacific = 0
Azure = 1  
Nautical = 2  
Continental = 3 
Battleship = 4
Intrepid = 5
Uniform = 6
Classico = 7 
Mediterranean = 8
Command = 9 
Mariner = 10
Ruby = 11
Vintage = 12
Pristine = 13 
Merchant = 14  
Voyager = 15  

If you want to change the colors of the light on the yacht you can change the itemname on the prop named:
"apa_mp_apa_y3_l2a" to one of the following:

apa_mp_apa_y3_l2a - Yellow: https://i.gyazo.com/c81501c9539154e5bcafaeb8c974d5ea.png
apa_mp_apa_y3_l2b - Blue: https://i.gyazo.com/887dec63b0f87eedfe8aee2c952272af.png
apa_mp_apa_y3_l2c - Pink: https://i.gyazo.com/50a420260ed97eca01d2fff5acba2b8e.jpg
apa_mp_apa_y3_l2d - Green: https://i.gyazo.com/6dcf44f7548c6ff6b7a32b045eb9760d.png

If you dont want to have all yachts loaded you can simple turn enabled to false in the table below.

]] 

local yachts = {
	{ enabled = true, coords = { x = -3542.82200000, y = 1488.25000000, z = 5.42990900 }, ipls = { "apa_yacht_grp01_1", "apa_yacht_grp01_1_int", "apa_yacht_grp01_1_lod" }, },
	{ enabled = true, coords = { x = -3148.37900000, y = 2807.55500000, z = 5.43004400 }, ipls = { "apa_yacht_grp01_2", "apa_yacht_grp01_2_int", "apa_yacht_grp01_2_lod" }, },
	{ enabled = true, coords = { x = -3280.50100000, y = 2140.50700000, z = 5.42995500 }, ipls = { "apa_yacht_grp01_3", "apa_yacht_grp01_3_int", "apa_yacht_grp01_3_lod" }, },
	{ enabled = true, coords = { x = -2814.48900000, y = 4072.74000000, z = 5.42835300 }, ipls = { "apa_yacht_grp02_1", "apa_yacht_grp02_1_int", "apa_yacht_grp02_1_lod" }, },
	{ enabled = true, coords = { x = -3254.55200000, y = 3685.67600000, z = 5.42995500 }, ipls = { "apa_yacht_grp02_2", "apa_yacht_grp02_2_int", "apa_yacht_grp02_2_lod" }, },
	{ enabled = true, coords = { x = -2368.44100000, y = 4697.87400000, z = 5.42995500 }, ipls = { "apa_yacht_grp02_3", "apa_yacht_grp02_3_int", "apa_yacht_grp02_3_lod" }, },
	{ enabled = true, coords = { x = -3205.34400000, y = -219.01040000, z = 5.42995500 }, ipls = { "apa_yacht_grp03_1", "apa_yacht_grp03_1_int", "apa_yacht_grp03_1_lod" }, },
	{ enabled = true, coords = { x = -3448.25400000, y = 311.50180000, z = 5.42995500 }, ipls = { "apa_yacht_grp03_2", "apa_yacht_grp03_2_int", "apa_yacht_grp03_2_lod" }, },
	{ enabled = true, coords = { x = -2697.86200000, y = -540.61230000, z = 5.42995500 }, ipls = { "apa_yacht_grp03_3", "apa_yacht_grp03_3_int", "apa_yacht_grp03_3_lod" }, },
	{ enabled = true, coords = { x = -1995.72500000, y = -1523.69400000, z = 5.42997000 }, ipls = { "apa_yacht_grp04_1", "apa_yacht_grp04_1_int", "apa_yacht_grp04_1_lod" }, },
	{ enabled = true, coords = { x = -2117.58100000, y = -2543.34600000, z = 5.42995500 }, ipls = { "apa_yacht_grp04_2", "apa_yacht_grp04_2_int", "apa_yacht_grp04_2_lod" }, },
	{ enabled = true, coords = { x = -1605.07400000, y = -1872.46800000, z = 5.42995500 }, ipls = { "apa_yacht_grp04_3", "apa_yacht_grp04_3_int", "apa_yacht_grp04_3_lod" }, },
	{ enabled = true, coords = { x = -753.08170000, y = -3919.06800000, z = 5.42995500 }, ipls = { "apa_yacht_grp05_1", "apa_yacht_grp05_1_int", "apa_yacht_grp05_1_lod" }, },
	{ enabled = true, coords = { x = -351.06080000, y = -3553.32300000, z = 5.42995500 }, ipls = { "apa_yacht_grp05_2", "apa_yacht_grp05_2_int", "apa_yacht_grp05_2_lod" }, },
	{ enabled = true, coords = { x = -1460.53600000, y = -3761.46700000, z = 5.42995500 }, ipls = { "apa_yacht_grp05_3", "apa_yacht_grp05_3_int", "apa_yacht_grp05_3_lod" }, },
	{ enabled = true, coords = { x = 1546.89200000, y = -3045.62700000, z = 5.43018400 }, ipls = { "apa_yacht_grp06_1", "apa_yacht_grp06_1_int", "apa_yacht_grp06_1_lod" }, },
	{ enabled = true, coords = { x = 2490.88600000, y = -2428.84800000, z = 5.42995500 }, ipls = { "apa_yacht_grp06_2", "apa_yacht_grp06_2_int", "apa_yacht_grp06_2_lod" }, },
	{ enabled = true, coords = { x = 2049.79000000, y = -2821.62400000, z = 5.42995500 }, ipls = { "apa_yacht_grp06_3", "apa_yacht_grp06_3_int", "apa_yacht_grp06_3_lod" }, },
	{ enabled = true, coords = { x = 3029.01800000, y = -1495.70200000, z = 5.42996800 }, ipls = { "apa_yacht_grp07_1", "apa_yacht_grp07_1_int", "apa_yacht_grp07_1_lod" }, },
	{ enabled = true, coords = { x = 3021.25400000, y = -723.39030000, z = 5.42998600 }, ipls = { "apa_yacht_grp07_2", "apa_yacht_grp07_2_int", "apa_yacht_grp07_2_lod" }, },
	{ enabled = true, coords = { x = 2976.62200000, y = -1994.76000000, z = 5.42995500 }, ipls = { "apa_yacht_grp07_3", "apa_yacht_grp07_3_int", "apa_yacht_grp07_3_lod" }, },
	{ enabled = true, coords = { x = 3404.51000000, y = 1977.04400000, z = 5.42995500 }, ipls = { "apa_yacht_grp08_1", "apa_yacht_grp08_1_int", "apa_yacht_grp08_1_lod" }, },
	{ enabled = true, coords = { x = 3411.10000000, y = 1193.44500000, z = 5.43006200 }, ipls = { "apa_yacht_grp08_2", "apa_yacht_grp08_2_int", "apa_yacht_grp08_2_lod" }, },
	{ enabled = true, coords = { x = 3784.80200000, y = 2548.54100000, z = 5.42995500 }, ipls = { "apa_yacht_grp08_3", "apa_yacht_grp08_3_int", "apa_yacht_grp08_3_lod" }, },
	{ enabled = true, coords = { x = 4225.02800000, y = 3988.00200000, z = 5.42995500 }, ipls = { "apa_yacht_grp09_1", "apa_yacht_grp09_1_int", "apa_yacht_grp09_1_lod" }, },
	{ enabled = true, coords = { x = 4250.58100000, y = 4576.56500000, z = 5.42995500 }, ipls = { "apa_yacht_grp09_2", "apa_yacht_grp09_2_int", "apa_yacht_grp09_2_lod" }, },
	{ enabled = true, coords = { x = 4204.35600000, y = 3373.70000000, z = 5.42995500 }, ipls = { "apa_yacht_grp09_3", "apa_yacht_grp09_3_int", "apa_yacht_grp09_3_lod" }, },
	{ enabled = true, coords = { x = 3751.68100000, y = 5753.50100000, z = 5.42995500 }, ipls = { "apa_yacht_grp10_1", "apa_yacht_grp10_1_int", "apa_yacht_grp10_1_lod" }, },
	{ enabled = true, coords = { x = 3490.10500000, y = 6305.78500000, z = 5.42995500 }, ipls = { "apa_yacht_grp10_2", "apa_yacht_grp10_2_int", "apa_yacht_grp10_2_lod" }, },
	{ enabled = true, coords = { x = 3684.85300000, y = 5212.23800000, z = 5.42995500 }, ipls = { "apa_yacht_grp10_3", "apa_yacht_grp10_3_int", "apa_yacht_grp10_3_lod" }, },
	{ enabled = true, coords = { x = 581.59550000, y = 7124.55800000, z = 5.42995500 }, ipls = { "apa_yacht_grp11_1", "apa_yacht_grp11_1_int", "apa_yacht_grp11_1_lod" }, },
	{ enabled = true, coords = { x = 2004.46200000, y = 6907.15700000, z = 5.42997400 }, ipls = { "apa_yacht_grp11_2", "apa_yacht_grp11_2_int", "apa_yacht_grp11_2_lod" }, },
	{ enabled = true, coords = { x = 1396.63800000, y = 6860.20300000, z = 5.42995900 }, ipls = { "apa_yacht_grp11_3", "apa_yacht_grp11_3_int", "apa_yacht_grp11_3_lod" }, },
	{ enabled = true, coords = { x = -1170.69000000, y = 5980.68100000, z = 5.42994400 }, ipls = { "apa_yacht_grp12_1", "apa_yacht_grp12_1_int", "apa_yacht_grp12_1_lod" }, },
	{ enabled = true, coords = { x = -777.48650000, y = 6566.90700000, z = 5.42995500 }, ipls = { "apa_yacht_grp12_2", "apa_yacht_grp12_2_int", "apa_yacht_grp12_2_lod" }, },
	{ enabled = true, coords = { x = -381.77390000, y = 6946.96000000, z = 5.42990000 }, ipls = { "apa_yacht_grp12_3", "apa_yacht_grp12_3_int", "apa_yacht_grp12_3_lod" }, },
}

CreateThread(function()
	RequestIpl("apa_ch2_superyacht")
    for _, yacht in ipairs(yachts) do
        if yacht.enabled then
            for __, ipl in ipairs(yacht.ipls) do
                RequestIpl(ipl)
            end
        end
    end
    print("^5[GABZ]^7 Yachts loaded.")
end)
