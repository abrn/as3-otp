# as3-otp
ActionScript3 implementation of the OTP/TOTP protocols. [RFC4226](https://tools.ietf.org/html/rfc4226) and [RFC628](https://tools.ietf.org/html/rfc6238) compliant, minus the error handling.  

The only requirement is the [as3crypto library](https://github.com/timkurvers/as3-crypto) for computing SHA-HMACS.

### Examples 

**OTP (one-time-password)**

```
var otp: OTP = new OTP(); // an optional secret key, period and output digit count can be passed here

var secret: String = otp.getSecret(); // the secret key used by the class
var digits: int = otp.getDigits(); // the amount of digits used in the output code

var code: String = otp.at(1337); // generate an OTP code with a given integer counter
```

**TOTP (time-based one-time-password)**

```
var totp: TOTP = new TOTP(); // an optional secret key, period and output digit count can be passed

var secret: String = otp.getSecret(); // the secret key used by the class
var digits: int = otp.getDigits(); // the amount of digits used in the output code

var codeNow: String = totp.now(); // get the generated code at the current time period
var codeCustom: String = totp.at(1605830400); // get the generated code for a custom unix timestamp
```