*** Settings ***
Resource        keywords.robot
Resource        resource.robot
Suite Setup     Test Suite Setup
Suite Teardown  Test Suite Teardown
Library         Selenium2Library

*** Variables ***
@{USED_ROLES}  viewer  provider  provider1
${round1_bidder1}  id=stage-1
${round1_bidder2}  id=stage-2
${round2_bidder1}  id=stage-4
${round2_bidder2}  id=stage-5
${round3_bidder1}  id=stage-7
${round3_bidder2}  id=stage-8


*** Test Cases ***
Можливість знайти закупівлю по ідентифікатору
  [Tags]   ${USERS.users['${viewer}'].broker}: Пошук тендера
  ...      ${USERS.users['${viewer}'].broker}
  ...      find_tender
  Завантажити дані про тендер
  Run As  ${viewer}  Пошук тендера по ідентифікатору   ${TENDER['TENDER_UAID']}

##############################################################################################
#             AUCTION
##############################################################################################

Відображення дати початку аукціону
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних аукціону
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      tender_view
  [Setup]  Дочекатись дати закінчення прийому пропозицій  ${viewer}  ${TENDER['TENDER_UAID']}
  Дочекатись дати початку періоду аукціону  ${viewer}  ${TENDER['TENDER_UAID']}
  Отримати дані із тендера  ${viewer}  ${TENDER['TENDER_UAID']}  auctionPeriod.startDate  ${TENDER['LOT_ID']}


Можливість дочекатися початку аукціону
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      auction
  Дочекатись дати початку аукціону  ${viewer}


Можливість вичитати посилання на аукціон для першого учасника
  [Tags]   ${USERS.users['${provider}'].broker}: Процес аукціону
  ...      provider
  ...      ${USERS.users['${provider}'].broker}
  ...      auction
  Можливість вичитати посилання на аукціон для ${provider}


Можливість вичитати посилання на аукціон для другого учасника
  [Tags]   ${USERS.users['${provider1}'].broker}: Процес аукціону
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      auction
  Можливість вичитати посилання на аукціон для ${provider1}


Можливість вичитати посилання на аукціон для глядача
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      auction
  Можливість вичитати посилання на аукціон для ${viewer}


Можливість дочекатись першого раунду
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer  provider  provider1
  ...      ${USERS.users['${viewer}'].broker}
  ...      ${USERS.users['${provider}'].broker}
  ...      ${USERS.users['${provider1}'].broker}
  ...      auction
  Дочекатись завершення паузи перед першим раундом


Можливість проведення 1 го раунду аукціону для першого учасника
  [Tags]   ${USERS.users['${provider}'].broker}: Процес аукціону
  ...      provider
  ...      ${USERS.users['${provider}'].broker}
  ...      auction
  Вибрати учасника, який може зробити ставку
  Спробувати вказати невалідну тривалість дії контракту
  Спробувати вказати невалідний відсоток щорічних платежів
  Поставити мінімально можливу ставку  8  220  90
  Дочекатись учасником закінчення стадії ставок
  Перевірити чи ставка була прийнята  ${round1_bidder1}


Можливість проведення 1 го раунду аукціону для другого учасника
  [Tags]   ${USERS.users['${provider1}'].broker}: Процес аукціону
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      auction
  Вибрати учасника, який може зробити ставку
  Поставити мінімально можливу ставку  8  220  90
  Дочекатись учасником закінчення стадії ставок
  Перевірити чи ставка була прийнята  ${round1_bidder2}


Можливість дочекатись другого раунду
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer  provider  provider1
  ...      ${USERS.users['${viewer}'].broker}
  ...      ${USERS.users['${provider}'].broker}
  ...      ${USERS.users['${provider1}'].broker}
  ...      auction
  Дочекатись завершення паузи перед 2 раундом


Можливість проведення 2 го раунду аукціону для першого учасника
  [Tags]   ${USERS.users['${provider}'].broker}: Процес аукціону
  ...      provider
  ...      ${USERS.users['${provider}'].broker}
  ...      auction
  Вибрати учасника, який може зробити ставку
  Поставити мінімально можливу ставку  8  220  85
  Дочекатись учасником закінчення стадії ставок
  Перевірити чи ставка була прийнята  ${round2_bidder1}


Можливість проведення 2 го раунду аукціону для другого учасника
  [Tags]   ${USERS.users['${provider1}'].broker}: Процес аукціону
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      auction
  Вибрати учасника, який може зробити ставку
  Поставити мінімально можливу ставку  8  220  85
  Дочекатись учасником закінчення стадії ставок
  Перевірити чи ставка була прийнята  ${round2_bidder2}

Можливість дочекатись третього раунду
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer  provider  provider1
  ...      ${USERS.users['${viewer}'].broker}
  ...      ${USERS.users['${provider}'].broker}
  ...      ${USERS.users['${provider1}'].broker}
  ...      auction
  Дочекатись завершення паузи перед 3 раундом


Можливість проведення 3 го раунду аукціону для першого учасника
  [Tags]   ${USERS.users['${provider}'].broker}: Процес аукціону
  ...      provider
  ...      ${USERS.users['${provider}'].broker}
  ...      auction
  Вибрати учасника, який може зробити ставку
  Поставити мінімально можливу ставку  7  220  80
  Дочекатись учасником закінчення стадії ставок
  Перевірити чи ставка була прийнята  ${round3_bidder1}


Можливість проведення 3 го раунду аукціону для другого учасника
  [Tags]   ${USERS.users['${provider1}'].broker}: Процес аукціону
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      auction
  Вибрати учасника, який може зробити ставку
  Поставити мінімально можливу ставку  7  220  80
  Відмінитити ставку
  Дочекатись учасником закінчення стадії ставок
  Перевірити чи ставка була відмінена  ${round3_bidder2}


Можливість дочекатися завершення аукціону
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer  provider  provider1
  ...      ${USERS.users['${viewer}'].broker}
  ...      ${USERS.users['${provider}'].broker}
  ...      ${USERS.users['${provider1}'].broker}
  ...      auction
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Дочекатись дати закінчення аукціону


Відображення дати завершення аукціону
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних аукціону
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      tender_view
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Отримати дані із тендера  ${viewer}  ${TENDER['TENDER_UAID']}  auctionPeriod.endDate  ${TENDER['LOT_ID']}


*** Keywords ***
Дочекатись дати початку аукціону
  [Arguments]  ${username}
  # Can't use that dirty hack here since we don't know
  # the date of auction when creating the procurement :)
  ${auctionStart}=  Отримати дані із тендера   ${username}  ${TENDER['TENDER_UAID']}   auctionPeriod.startDate  ${TENDER['LOT_ID']}
  Дочекатись дати  ${auctionStart}
  Оновити LAST_MODIFICATION_DATE
  Дочекатись синхронізації з майданчиком  ${username}


Можливість вичитати посилання на аукціон для ${username}
  ${url}=  Run Keyword If  '${username}' == '${viewer}'  Run As  ${viewer}  Отримати посилання на аукціон для глядача  ${TENDER['TENDER_UAID']}  ${TENDER['LOT_ID']}
  ...      ELSE  Run As  ${username}  Отримати посилання на аукціон для учасника  ${TENDER['TENDER_UAID']}  ${TENDER['LOT_ID']}
  Should Be True  '${url}'
  Should Match Regexp  ${url}  ^https?:\/\/auction(?:-sandbox)?\.prozorro\.openprocurement\.auction\/esco-tenders\/([0-9A-Fa-f]{32})
  Log  URL: ${url}
  [return]  ${url}


Відкрити сторінку аукціону для ${username}
  ${url}=  Можливість вичитати посилання на аукціон для ${username}
  Open browser  ${url}  ${USERS.users['${username}'].browser}  ${username}
  Set Window Position  @{USERS['${username}']['position']}
  Set Window Size      @{USERS['${username}']['size']}
  Run Keyword Unless  '${username}' == '${viewer}'
  ...      Click Element                  xpath=//button[contains(@class, 'btn btn-success')]


Дочекатись завершення паузи перед першим раундом
  Відкрити сторінку аукціону для ${viewer}
  Дочекатись паузи перед першим раундом глядачем
  Дочекатись завершення паузи перед першим раундом для користувачів


Дочекатись дати закінчення аукціону
  Переключитись на учасника  ${viewer}
  ${status}  ${_}=  Run Keyword And Ignore Error  Wait Until Keyword Succeeds  61 times  30 s  Page should contain  Аукціон завершився
  Run Keyword If  '${status}' == 'FAIL'
  ...      Run Keywords
  ...      Отримати дані із тендера  ${username}  ${TENDER['TENDER_UAID']}  auctionPeriod.startDate  ${TENDER['LOT_ID']}
  ...      AND
  ...      Дочекатись дати початку аукціону  ${username}
  ...      AND
  ...      Дочекатись дати закінчення аукціону для ${username}
  ...      ELSE
  ...      Run Keywords
  ...      Wait Until Keyword Succeeds  15 times  30 s  Page should not contain  Очікуємо на розкриття імен учасників
  ...      AND
  ...      Переключитись на учасника  ${provider}
  ...      AND
  ...      Page should contain  Аукціон завершився
  ...      AND
  ...      Переключитись на учасника  ${provider1}
  ...      AND
  ...      Page should contain  Аукціон завершився
  ...      AND
  ...      Close browser


Дочекатись паузи перед першим раундом глядачем
  ${status}  ${_}=  Run Keyword And Ignore Error  Page should contain  Очікування
  Run Keyword If  '${status}' == 'PASS'
  ...      Run Keywords
  ...      Дочекатись дати початку аукціону  ${viewer}
  ...      AND
  ...      Wait Until Keyword Succeeds  15 times  10 s  Page should contain  до початку раунду


Дочекатись завершення паузи перед ${round_number} раундом
  Переключитись на учасника  ${viewer}
  Wait Until Keyword Succeeds  30 times  5s  Page should contain  → ${round_number}
  ${date}=  Get Current Date
  Переключитись на учасника  ${provider}
  Page should contain  → ${round_number}
  Переключитись на учасника  ${provider1}
  Page should contain  → ${round_number}
  Переключитись на учасника  ${viewer}
  Wait Until Keyword Succeeds  30 times  5 s  Page should not contain  → ${round_number}
  ${new_date}=  Get Current Date
  Переключитись на учасника  ${provider}
  Page should not contain  → ${round_number}
  Переключитись на учасника  ${provider1}
  Page should not contain  → ${round_number}
  ${time}=  Subtract Date From Date  ${new_date}  ${date}
  Should Be True  ${time} < 140 and ${time} > 100


Дочекатись завершення паузи перед першим раундом для користувачів
  Wait Until Keyword Succeeds  30 times  5s  Page should contain  → 1
  ${date}=  Get Current Date
  Відкрити сторінку аукціону для ${provider}
  Відкрити сторінку аукціону для ${provider1}
  Переключитись на учасника  ${viewer}
  Wait Until Keyword Succeeds  62 times  5 s  Page should not contain  → 1
  ${new_date}=  Get Current Date
  ${time}=  Subtract Date From Date  ${new_date}  ${date}
  Should Be True  ${time} < 310 and ${time} > 250
  Переключитись на учасника  ${provider}
  Page should not contain  → 1
  Переключитись на учасника  ${provider1}
  Page should not contain  → 1


Дочекатись закінчення стадії ставок глядачем
  Wait Until Keyword Succeeds  30 times  5s  Page should contain  до закінчення раунду
  ${date}=  Get Current Date
  Wait Until Keyword Succeeds  50 times  5 s  Page should not contain  до закінчення раунду
  ${new_date}=  Get Current Date
  ${time}=  Subtract Date From Date  ${new_date}  ${date}
  Should Be True  ${time} < 250 and ${time} > 210


Дочекатись учасником закінчення стадії ставок
  Wait Until Keyword Succeeds  12 times  10 s  Page should not contain  до закінчення вашої черги


Дочекатись оголошення результатів глядачем
  Wait Until Keyword Succeeds  30 times  5s  Page should contain  до оголошення результатів
  ${date}=  Get Current Date
  Wait Until Keyword Succeeds  50 times  5 s  Page should not contain  до оголошення результатів
  ${new_date}=  Get Current Date
  ${time}=  Subtract Date From Date  ${new_date}  ${date}
  Should Be True  ${time} < 250 and ${time} > 210


Переключитись на учасника
  [Arguments]  ${username}
  Switch Browser  ${username}
  ${CURRENT_USER}=  Set Variable  ${username}
  Set Global Variable  ${CURRENT_USER}


Спробувати вказати невалідну тривалість дії контракту
  Поставити ставку еско  16  6  99  css=input:invalid
  Поставити ставку еско  20  6  99  css=input:invalid
  Поставити ставку еско  14  365  99   css=input:invalid
  Поставити ставку еско  12   2132  99   css=input:invalid
  Поставити ставку еско  45   2132  99   css=input:invalid
  Поставити ставку еско  0  0  99   Ви не можете встановити 0 днів та 0 років


Спробувати вказати невалідний відсоток щорічних платежів
  Поставити ставку еско  2  123  79   Percentage value must be between 80.0 and 100


Поставити мінімально можливу ставку
  [Arguments]  ${years}  ${days}  ${percent}
  Поставити ставку еско  ${years}  ${days}  ${percent}   Заявку прийнято


Поставити ставку еско
  [Arguments]  ${years}  ${days}  ${percent}  ${msg}
  Input Text  id=contract-duration-years-input  ${years}
  Input Text  id=contract-duration-days-input  ${days}
  Input Text  id=yearly-payments-percentage  ${percent}
  sleep  1s
  Capture Page Screenshot
  Click Element                id=place-bid-button
  Run Keyword If  "${msg}" == "css=input:invalid"           Wait Until Element Is Visible  ${msg}
  ...    ELSE     Wait Until Page Contains  ${msg}  10s
  ${current_VPN}=  Get text  id=current-npv
  Set Global Variable   ${current_VPN}
  Capture Page Screenshot


Відмінитити ставку
  Click Element                id=cancel-bid-button
  Wait Until Page Contains     Заявку відмінено      10s
  Capture Page Screenshot


Вибрати учасника, який може зробити ставку
  :FOR    ${username}    IN    ${provider}  ${provider1}
  \   Переключитись на учасника   ${username}
  \   ${status}  ${_}=  Run Keyword And Ignore Error  Page Should Contain  до закінчення вашої черги
  \   Run Keyword If  '${status}' == 'PASS'    Exit For Loop


Перевірити чи ставка була прийнята
  [Arguments]    ${locator}
  Element should contain  ${locator}  ${current_VPN}


Перевірити чи ставка була відмінена
  [Arguments]    ${locator}
  ${amount}=  Get text  ${round2_bidder2}
  Element should contain  ${locator}  ${amount}
