QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.QBJobsStatus = false -- true: integrate qb-jobs into the whole of qb-core | false: treat qb-jobs as an add-on resource.
QBShared.Jobs = {} -- All of below has been migrated into qb-jobs
if QBShared.QBJobsStatus then return end
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 10
            },
        },
	},
	['police'] = {
		label = 'Law Enforcement',
        type = "leo",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Officer',
                payment = 75
            },
			['2'] = {
                name = 'Sergeant',
                payment = 100
            },
			['3'] = {
                name = 'Lieutenant',
                payment = 125
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
        type = 'ems',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Paramedic',
                payment = 75
            },
			['2'] = {
                name = 'Doctor',
                payment = 100
            },
			['3'] = {
                name = 'Surgeon',
                payment = 125
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Driver',
                payment = 75
            },
			['2'] = {
                name = 'Event Driver',
                payment = 100
            },
			['3'] = {
                name = 'Sales',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
    ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
		},
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Finance',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100,
                bankAuth = true
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 50
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 50
            },
        },
	},

    --Gabz Resturant Jobs.
    ['beanmachine'] = {
		label = 'Bean Machine',
        type = "beanmachine",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50 
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Resturant Manager',
                payment = 125
            },
			['4'] = {
                name = 'Resturant Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
    ['hornys'] = {
		label = 'Hornys Resturant',
        type = "hornys",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Resturant Manager',
                payment = 125
            },
			['4'] = {
                name = 'Resturant Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
    ['maldinis'] = {
		label = 'Maldinis Pizzarea',
        type = "maldinis",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Resturant Manager',
                payment = 125
            },
			['4'] = {
                name = 'Resturant Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
    ['pearls'] = {
		label = 'Pearls Diner',
        type = "pearls",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Resturant Manager',
                payment = 125
            },
			['4'] = {
                name = 'Resturant Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
    ['koi'] = {
		label = 'Kois Diner',
        type = "koi",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Resturant Manager',
                payment = 125
            },
			['4'] = {
                name = 'Resturant Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
    ['burgershot'] = {
		label = 'Burger Shot',
        type = "burgershot",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Resturant Manager',
                payment = 125
            },
			['4'] = {
                name = 'Resturant Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
    ['uwucafe'] = {
		label = 'UWU Cafe',
        type = "uwucafe",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Resturant Manager',
                payment = 125
            },
			['4'] = {
                name = 'Resturant Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
    ['upnatom'] = {
		label = 'Up n Atom Diner',
        type = "upnatom",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Resturant Manager',
                payment = 125
            },
			['4'] = {
                name = 'Resturant Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},

    --Gabz Bars
    ['bahama'] = {
		label = 'Bahama Mamas',
        type = "bahama",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Bar Manager',
                payment = 125
            },
			['4'] = {
                name = 'Bar Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
    ['vu'] = {
		label = 'Vanilla Unicorn',
        type = "vu",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Assistant Manager',
                payment = 100
            },
			['3'] = {
                name = 'Bar Manager',
                payment = 125
            },
			['4'] = {
                name = 'Bar Owner',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},

}
