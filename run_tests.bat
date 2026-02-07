@echo off
cd %~dp0

echo ===============================
echo Step 1: Installing dependencies...
echo ===============================
npm install
if %ERRORLEVEL% NEQ 0 (
    echo npm install failed! Exiting.
    exit /b %ERRORLEVEL%
)

echo ===============================
echo Step 2: Installing Playwright browsers...
echo ===============================
npx playwright install
if %ERRORLEVEL% NEQ 0 (
    echo Playwright browser install failed! Exiting.
    exit /b %ERRORLEVEL%
)

echo ===============================
echo Step 3: Running tests with Allure reporter...
echo ===============================
npm run test:allure
set TEST_EXITCODE=%ERRORLEVEL%
echo Test exit code: %TEST_EXITCODE%

echo ===============================
echo Step 4: Showing Allure results folder...
echo ===============================
dir allure-results

echo ===============================
echo Step 5: Generating Allure report...
echo ===============================
allure generate allure-results -o allure-report --clean
if %ERRORLEVEL% NEQ 0 (
    echo Allure report generation failed, but build will not fail.
) else (
    echo Allure report generated successfully in "allure-report" folder.
)

:: Only fail the build if tests actually failed
if %TEST_EXITCODE% NEQ 0 (
    echo Some tests failed! Build marked as FAILED.
    exit /b %TEST_EXITCODE%
)

echo All tests passed! Build SUCCESS.
exit /b 0