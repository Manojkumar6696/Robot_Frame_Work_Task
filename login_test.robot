#importing necessary Library

*** Settings ***
Library    SeleniumLibrary

#Creating Keyword to open url in browser

*** Keywords ***
Open Application Browser
    [Documentation]    Open the browser and navigate to the application
    Open Browser    https://www.saucedemo.com/     browser=chrome

#Creating Keyword to Valid login functionality

Valid Login
    [Documentation]    Input valid credentials and submit the form
    Input Text    id:user-name    standard_user
    Input Text    id:password    secret_sauce
    Click Button  xpath://*[@id="login-button"]


#Creating Keyword to Invalid login functionality
Invalid Login
    [Documentation]    Input invalid credentials and check error displaying
    Input Text    id:user-name   standard_user1.0
    Input Text    id:password    secret_sauce5.0
    Click Button  xpath://*[@id="login-button"]


#Creating Keyword to check Valid login functionality
Verify Valid Login
    [Documentation]    Verify that we landed in product page
    Page Should Contain Image  xpath: //*[@id="item_4_img_link"]/img

#Creating Keyword to check Invalid login functionality
Verify Invalid Login
    [Documentation]    Verify that error message is displayed
    Page Should Contain Element  xpath: //*[@id="login_button_container"]/div/form/div[3]/h3

#Creating Keyword to add product in cart
Adding Product to the Cart
    [Documentation]    Verify the product is added in cart
    Click Button    xpath: //*[@id="add-to-cart-sauce-labs-backpack"]
    Click Button    xpath: //*[@id="add-to-cart-sauce-labs-bike-light"]
    Click Button    xpath: //*[@id="add-to-cart-sauce-labs-fleece-jacket"]
    Click Link      xpath: /html/body/div/div/div/div[1]/div[1]/div[3]/a
    Page Should Contain Element   xpath: //*[@id="item_0_title_link"]/div  Sauce Labs Backpack
    Page Should Contain Element   xpath: //*[@id="item_0_title_link"]/div  Sauce Labs Bike Light
    Page Should Contain Element   xpath: //*[@id="item_0_title_link"]/div  Sauce Labs Fleece Jacket

#Creating Keyword to check product count in checkout page

Checking Product count in Checkout page
    [Documentation]    Verify the product is added in cart
    Click Button    xpath: //*[@id="add-to-cart-sauce-labs-backpack"]
    Click Button    xpath: //*[@id="add-to-cart-sauce-labs-bike-light"]
    Click Button    xpath: //*[@id="add-to-cart-sauce-labs-fleece-jacket"]
    Click Link      xpath: /html/body/div/div/div/div[1]/div[1]/div[3]/a
    Click Button   xpath: //*[@id="checkout"]
    Input Text    id:first-name    Manoj
    Input Text    id:last-name    Kumar
    Input Text    id:postal-code  Chennai-39
    Click Button  id:continue
    Page Should Contain Element   xpath: //*[@id="item_0_title_link"]/div  Sauce Labs Backpack
    Page Should Contain Element   xpath: //*[@id="item_0_title_link"]/div  Sauce Labs Bike Light
    Page Should Contain Element   xpath: //*[@id="item_0_title_link"]/div  Sauce Labs Fleece Jacket

#Creating Keyword to check Logout Functionality

Logout
    [Documentation]    Log out of the application
    Click Button   xpath://*[@id="react-burger-menu-btn"]
    Wait Until Element Is Visible  id:logout_sidebar_link  timeout=20
    Click Link    id:logout_sidebar_link

#Writing Test case to check Valid login functionality

*** Test Cases ***
Verify Login Functionality

    [Documentation]    Test case to verify the valid login functionality
    Open Application Browser
    Valid Login
    Verify Valid Login
    Logout


#Writing Test case to check Invalid login functionality

*** Test Cases ***
Verify Invalid Login Functionality

    [Documentation]    Test case to verify the Invalid login functionality
    Open Application Browser
    Invalid Login
    Verify Invalid Login


#Writing Test case to check product is added in cart

*** Test Cases ***
Verify product is added in cart

    [Documentation]    Test case to verify the product is added to the cart
    Open Application Browser
    Valid Login
    Adding Product to the Cart
    Logout

#Writing Test case to check correct items and quantities are listed in the checkout summary

*** Test Cases ***
Verify that the correct items and quantities are listed in the checkout summary

    [Documentation]    Test case to verify that the correct items and quantities are listed in the checkout summary
    Open Application Browser
    Valid Login
    Checking Product count in Checkout page
    Logout
