local beats = {
    -- intro
    0.074694,
    0.517999,
    1.084732,
    1.617020,
    2.184250,
    2.718168,
    3.234569,
    3.784831,
    4.334984,
    4.917634,
    5.451175,
    6.001313,
    6.502222,
    7.068748,
    7.602592,
    8.134966,

    -- sizzle
    8.718743,
    9.235596,
    9.768553,
    10.336233,
    10.869045,
    11.402683,
    11.968786,
    12.535960,
    13.086370,
    13.619746,
    14.169813,
    14.686793,
    15.236707,
    15.769359,
    16.319405,
    16.837210,

    -- theme
    17.437192,
    17.953802,
    18.503298,
    19.053075,
    19.569871,
    20.120602,
    20.686884,
    21.203723,
    21.770379,
    22.320489,
    22.887685,
    23.437252,
    23.954563,
    24.504929,
    25.087935,
    25.604583,

    -- theme
    26.171998,
    26.688341,
    27.237944,
    27.805438,
    28.337944,
    28.855283,
    29.421515,
    29.971382,
    30.521105,
    31.071706,
    31.622669,
    32.172101,
    32.705604,
    33.222233,
    33.789447,
    34.322093,

    -- muted theme
    34.872747,
    35.405673,
    35.989952,
    36.522719,
    37.072890,
    37.557045,
    38.123868,
    38.656693,
    39.256862,
    39.773063,
    40.373365,
    40.907176,
    41.457137,
    41.990374,
    42.523838,
    43.040172,

    -- muted theme
    43.623923,
    44.141447,
    44.674162,
    45.224217,
    45.773787,
    46.324203,
    46.908204,
    47.441531,
    47.974601,
    48.491766,
    49.092160,
    49.625720,
    50.158312,
    50.674780,
    51.241694,
    51.775384,

    -- hard theme
    52.375615,
    52.926008,
    53.426350,
    53.975923,
    54.509005,
    55.075384,
    55.626107,
    56.126285,
    56.709718,
    57.260119,
    57.793641,
    58.343323,
    58.876504,
    59.426421,
    59.992859,
    60.527010,
    
    -- hard theme
    61.060745,
    61.594193,
    62.160281,
    62.677389,
    63.260504,
    63.826870,
    64.377197,
    64.893711,
    65.443789,
    65.977904,
    66.544174,
    67.094505,
    67.628190,
    68.160899,
    68.711552,
    69.228212,

    -- hard theme
    69.794508,
    70.361459,
    70.911817,
    71.428106,
    71.995430,
    72.544651,
    73.062090,
    73.579258,
    74.161725,
    74.712433,
    75.261936,
    75.812534,
    76.345540,
    76.879633,
    77.446207,
    77.962407,

    -- hard theme
    78.496330,
    79.063028,
    79.596481,
    80.146827,
    80.729352,
    81.263021,
    81.797387,
    82.329655,
    82.879744,
    83.430511,
    83.980294,
    84.513409,
    85.063570,
    85.663636,
    86.180005,
    86.697892,

    -- lighter theme
    87.263594,
    87.830621,
    88.380624,
    88.914741,
    89.447631,
    89.998056,
    90.514165,
    91.065242,
    91.631627,
    92.165230,
    92.681500,
    93.264891,
    93.798575,
    94.348657,
    94.915599,
    95.448676,

    -- lighter theme
    96.015932,
    96.532541,
    97.049641,
    97.615148,
    98.148951,
    98.682490,
    99.249153,
    99.748841,
    100.366064,
    100.916844,
    101.432442,
    101.982600,
    102.532783,
    103.033812,
    103.600153,
    104.133889,

    -- theme
    104.717197,
    105.283351,
    105.800107,
    106.350722,
    106.883918,
    107.417071,
    107.983855,
    108.484726,
    109.050774,
    109.617685,
    110.184956,
    110.717570,
    111.251192,
    111.801233,
    112.367611,
    112.884520,

    -- theme
    113.434955,
    113.985073,
    114.534538,
    115.084790,
    115.585570,
    116.134963,
    116.685566,
    117.219105,
    117.801902,
    118.352533,
    118.868870,
    119.435968,
    119.986103,
    120.552275,
    121.086502,
    121.619837,

    -- theme
    122.185620,
    122.702488,
    123.286070,
    123.836647,
    124.369743,
    124.920067,
    125.453782,
    125.970495,
    126.553712,
    127.070657,
    127.620863,
    128.170856,
    128.703289,
    129.287195,
    129.804038,
    130.354085,

    -- theme
    130.903630,
    131.454008,
    131.970681,
    132.538195,
    133.071669,
    133.621019,
    134.154758,
    134.671441,
    135.238171,
    135.821336,
    136.338198,
    136.871372,
    137.455260,
    138.005524,
    138.538553,
    139.089054,

    -- interlude
    139.638515,
    140.189329,
    140.705422,
    141.255483,
    141.822107,
    142.322470,
    142.889182,
    143.439817,

    -- dark bridge
    144.023450,
    144.556507,
    145.073149,
    145.606086,
    146.123569,
    146.672903,
    147.222975,
    147.806587,
    148.373784,
    148.856327,
    149.440501,
    149.990284,
    150.474528,
    151.041394,
    151.640731,
    152.191114,

    -- dark bridge
    152.740717,
    153.324432,
    153.791242,
    154.375266,
    154.907574,
    155.424623,
    155.991513,
    156.541623,
    157.091205,
    157.624471,
    158.141434,
    158.658127,
    159.225401,
    159.792435,
    160.325022,
    160.841714,

    -- interlude
    161.408887,
    161.958495,
    162.509615,
    163.076241,
    163.592805,
    164.126110,
    164.692320,
    165.209953,

    -- theme
    165.809769,
    166.343240,
    166.876723,
    167.410343,
    167.976173,
    168.527166,
    169.093410,
    169.577157,
    170.143990,
    170.693442,
    171.260347,
    171.810725,
    172.360864,
    172.911221,
    173.426832,
    173.993881,

    -- theme
    174.560751,
    175.111000,
    175.611289,
    176.127678,
    176.694857,
    177.277937,
    177.811251,
    178.344819,
    178.911381,
    179.461520,
    180.012279,
    180.545799,
    181.095315,
    181.645310,
    182.195262,
    182.744928,

    -- theme
    183.279394,
    183.795597,
    184.362434,
    184.879566,
    185.462856,
    186.012611,
    186.562336,
    187.062505,
    187.596832,
    188.179356,
    188.746777,
    189.297058,
    189.813465,
    190.363242,
    190.913984,
    191.446481,

    -- theme
    191.996893,
    192.546844,
    193.097762,
    193.580692,
    194.147594,
    194.730812,
    195.280922,
    195.830897,
    196.363867,
    196.914446,
    197.497821,
    197.997154,
    198.515494,
    199.081977,
    199.615044,
    200.165163,

    -- lighter theme
    200.748603,
    201.248614,
    201.798819,
    202.348782,
    202.898445,
    203.431703,
    203.981679,
    204.549122,
    205.115364,
    205.631937,
    206.182950,
    206.699323,
    207.299378,
    207.832932,
    208.366519,
    208.883402,

    -- lighter theme
    209.449734,
    210.016799,
    210.516226,
    211.083489,
    211.633410,
    212.166299,
    212.716693,
    213.233669,
    213.800000,
    214.366711,
    214.917349,
    215.467114,
    216.001129,
    216.517011,
    217.050408,
    217.567926,

    -- lighter still
    218.184592,
    218.734362,
    219.268142,
    219.834735,
    220.383854,
    220.901909,
    221.451993,
    222.001531,
    222.568506,
    223.085304,
    223.634703,
    224.152489,
    224.752464,
    225.302031,
    225.819016,
    226.351917,

    -- lighter still
    226.919081,
    227.435903,
    228.018942,
    228.552613,
    229.102349,
    229.652318,
    230.219566,
    230.719530,
    231.302909,
    231.836397,
    232.353344,
    232.919814,
    233.436590,
    234.003621,
    234.520483,
    235.070007,

    -- done
    235.620043,
}

return beats