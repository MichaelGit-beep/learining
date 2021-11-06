def suites = [
    "NewUI": 
        [
            "TestSuite": "NewUI", 
            "ProjectPath": "NewUI/NewUI.prj", 
            "ExecutionProfile": "NewUI"
        ],
    "Sanity":
    [
            "TestSuite": "Sanity", 
            "ProjectPath": "NewUI/NewU12312I.prj", 
            "ExecutionProfile": "NewUI"
    ]
]


// println "${dict}"

suites.each {
    suite, value ->  
        def value1 = "${value['ProjectPath']}"
        println value1
}

