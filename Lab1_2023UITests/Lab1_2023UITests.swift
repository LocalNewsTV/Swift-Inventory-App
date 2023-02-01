//
//  Lab1_2023UITests.swift
//  Lab1_2023UITests
//
//  Created by ICS 224 on 2023-01-11.
//

import XCTest

final class Lab1_2023UITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharCount() throws {
        let app = XCUIApplication()
        app.launch()
        
        let add = app.navigationBars["Inventory"].buttons["PlusButton"]
        if(app.collectionViews.buttons.count == 0){
            add.tap()
        }
        app.collectionViews.buttons.firstMatch.tap()
        let detailText = app.staticTexts["DetailText"]
        let initTextLength = app.textViews["DetailTextEditor"].value as? String
        let count = initTextLength!.count
        print("\(count) TEST")
        XCTAssertEqual(detailText.label, "\(count)/150")
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        
        let keyH = app.keys["H"]
        keyH.tap()
        XCTAssertTrue(detailText.waitForExistence(timeout: 5))
        XCTAssertEqual(detailText.label, "\(count+1)/150")
        
        let keyi = app.keys["i"]
        keyi.tap()
        XCTAssertEqual(detailText.label, "\(count+2)/150")
        //Delete all List objects
        while(app.collectionViews.buttons.count > 0){
            app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
            app.collectionViews.buttons["Delete"].tap()
        }
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
    }
    func testCharLimits() throws {
        let app = XCUIApplication()
        app.launch()
        let add = app.navigationBars["Inventory"].buttons["PlusButton"]
        if(app.collectionViews.buttons.count == 0){
            add.tap()
        }
        app.collectionViews.buttons.firstMatch.tap()
        let initTextLength = app.textViews["DetailTextEditor"].value as? String
        let count = initTextLength!.count
        let detailText = app.staticTexts["DetailText"]
                XCTAssertEqual(detailText.label, "\(count)/150")
        
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        
        let keyH = app.keys["H"]
        let keyE = app.keys["e"]
        keyH.tap()
        keyE.tap()
        
        var manyY = ""
        for _ in 0...450{
            manyY += "y"
        }
        detailTextEditor.typeText(manyY)
        XCTAssertTrue(detailText.waitForExistence(timeout: 5))
        XCTAssertEqual(detailText.label, "150/150")
        //Delete all List objects
        while(app.collectionViews.buttons.count > 0){
            app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
            app.collectionViews.buttons["Delete"].tap()
        }
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
    }
    func testStepperFunctionality() throws {
        //Grab all relevent component references
        let app = XCUIApplication()
        let detailText = app.staticTexts["DetailText"]
        let settingsToggle = app.buttons["NavigationButton"]
        let detailTextEditor = app.textViews["DetailTextEditor"]
        let back = app.buttons["Inventory"]
        //        app.collectionViews.buttons.firstMatch.tap()
        
        app.launch()
        
        let add = app.navigationBars["Inventory"].buttons["PlusButton"]
        while(app.collectionViews.buttons.count < 1){
            add.tap()
        }
        //toggle into settings and bring attempt bringing stepper below minimum value
        settingsToggle.tap()
        while app.steppers["MaxCountStepper"].label != "Value: 10"{
            app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
        }
        app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
        settingsToggle.tap()
        
        app.collectionViews.buttons.firstMatch.tap()
        let initTextLength = app.textViews["DetailTextEditor"].value as? String
        let count = initTextLength!.count
        XCTAssertEqual(detailText.label, "\(count)/10")
        
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
        //relaunch app to verify changes remained
        app.terminate()
        app.launch()
        app.collectionViews.buttons.firstMatch.tap()
        XCTAssertEqual(detailText.label, "\(count)/10")
        
        //test new character limit is in effect
        detailTextEditor.tap()
        detailTextEditor.typeText("Testing 10 character Limit")
        XCTAssertEqual(detailText.label, "10/10")
        back.tap()
        settingsToggle.tap()
        
        //attempt to bring stepper above maxiumum value
        while app.steppers["MaxCountStepper"].label != "Value: 300"{
            print(app.steppers["MaxCountStepper"].label)
            app.steppers["MaxCountStepper"].buttons["Increment"].tap()
        }
        app.steppers["MaxCountStepper"].buttons["Increment"].tap()
        settingsToggle.tap()
        app.collectionViews.buttons.firstMatch.tap()
        XCTAssertEqual(detailText.label, "10/300")
        back.tap()
        settingsToggle.tap()
        
        //Bring stepper back to 150
        while app.steppers["MaxCountStepper"].label != "Value: 150"{
            app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
        }
        settingsToggle.tap()
        app.collectionViews.buttons.firstMatch.tap()
        XCTAssertEqual(detailText.label, "10/150")
        back.tap()
        //Delete all List objects
        while(app.collectionViews.buttons.count > 0){
            app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
            app.collectionViews.buttons["Delete"].tap()
        }
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
    }
    func testFavourites(){
        let app = XCUIApplication()
        let favouriteToggle = app.switches["FavouriteToggle"]
        let back = app.buttons["Inventory"]

        app.launch()
        
        let add = app.navigationBars["Inventory"].buttons["PlusButton"]
        while(app.collectionViews.buttons.count < 3){
            add.tap()
        }
        let secondEntry = app.collectionViews.buttons.element(boundBy: 1)
        let thirdEntry = app.collectionViews.buttons.element(boundBy: 2)
        app.collectionViews.buttons.firstMatch.tap()
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1") // 1 == enabled
        back.tap()
        //Check second item is not fave'd
        secondEntry.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        back.tap()
        //Fave third item in list
        thirdEntry.tap()
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1")
        back.tap()
        //Check second entry still not triggered
        secondEntry.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        back.tap()
        
        //Delete all List objects
        while(app.collectionViews.buttons.count > 0){
            app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
            app.collectionViews.buttons["Delete"].tap()
        }
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
    }
    func testAdditionalItems(){
        let app = XCUIApplication()
        let add = app.navigationBars["Inventory"].buttons["PlusButton"]
        app.launch()
        let initCollectionCount = app.collectionViews.buttons.count
        add.tap()
        XCTAssertEqual(app.collectionViews.buttons.count, initCollectionCount+1)
        //Delete all List objects
        while(app.collectionViews.buttons.count > 0){
            app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
            app.collectionViews.buttons["Delete"].tap()
        }
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
    }
    func testDeleteItem(){
        let app = XCUIApplication()
        app.launch()
        let initCollectionCount = app.collectionViews.buttons.count
        app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)

        app.collectionViews.buttons["Delete"].tap()
        print("\(initCollectionCount), \(app.collectionViews.buttons.count) Lookie")
        XCTAssertEqual(app.collectionViews.buttons.count, initCollectionCount-1)
        //Delete all List objects
        while(app.collectionViews.buttons.count > 0){
            app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
            app.collectionViews.buttons["Delete"].tap()
        }
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
    }
    func testSavedFaves(){
        let app = XCUIApplication()
        let favouriteToggle = app.switches["FavouriteToggle"]
        let add = app.navigationBars["Inventory"].buttons["PlusButton"]
        let back = app.buttons["Inventory"]

        app.launch()

        while(app.collectionViews.buttons.count < 2){
            add.tap()
        }
        let firstEntry = app.collectionViews.buttons.firstMatch
        let secondEntry = app.collectionViews.buttons.element(boundBy: 1)
        
        firstEntry.tap()
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1") // 1 == enabled
        back.tap()

        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
        app.launch()
        
        firstEntry.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1") // 1 == enabled
        back.tap()
        //Delete all List objects
        while(app.collectionViews.buttons.count > 0){
            app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
            app.collectionViews.buttons["Delete"].tap()
        }
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
    }
}
