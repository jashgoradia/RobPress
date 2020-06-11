The vulnerabilities fixed on this site are listed below:

<b>1) SQL injection:</b> Use of prepared statements at login and search to escape user input before feeding it to the database

<b>2) Information Exposure:</b> Hid unnecessary files and directories from user by configuring the .htacess files

<b>3) XSS:</b> Used functions to either escpae or limit html input to whitelisted tags (for wysiwyg editors).

<b>4) Insecure Upload:</b> Added checks for extension, mime type, file size and content type of the file. If these validation checks pass, the file is renamed using a psuedo random variable to ensure that files in the upload folder are not replaced by new ones.

<b>5) CSRF:</b> Anti-CSRF token, a type of server-side CSRF protection, is used to secure the site against CSRF. It is a random string that is only known to the user’s browser and the web application. The anti-CSRF token is stored inside a session variable. On a page, it is in a hidden field that is sent with the request. The request is only accepted if the values of the session variable and hidden form field match.

<b>6) Authorisation Bypass:</b> Implemented a check to see if the user is an Admin on trying to access the admin only pages.

<b>7) Internal Information:</b> Restricted error messages so that only admins (and debug mode users) are shown the full error message with stack trace while normal users are just shown the error code and status.

<b>8) Parameter Manipulation:</b> Created helper validation functions in the model which are called from the controller as and when required to validate user input.

<b>9) Out of Date Software:</b> Downloaded and installed update patch.

<b>10) File Inclusion:</b> The file name is extracted from the directory path mentioned by the user, this file name is then appended to a predefined path to ensure that users are not able to access files that they are not meant to.

<b>11) Brute Force:</b> Implemented Google's ReCAPTCHA which shows up once the user fails to enter the correct credentials thrice.

<b>12) Unhashed Passwords:</b> Employed the use to PHP's "password_hash" function to hash passwords using the CRYPT_BLOWFISH algorithm. Subsequently, "password_verify" function was used to verify plain text password entered by the users.
