package {
  import com.hurlant.crypto.hash.HMAC;
  import com.hurlant.crypto.hash.SHA1;
  
  import flash.utils.ByteArray;
  
  public class OTP implements OTPInterface {
    private static const DIGITS_POWER: Array = [1,10,100,1000,10000,100000,1000000,10000000,100000000];
  
    private static var _secret: ByteArray;
    private static var _digits: int;
  
    /**
     * Initialize the OTP object
     * @param secret - the secret key in byte array format (null for a random byte array)
     * @param period - the period in seconds for the code to be valid
     * @param digits - the amount of digits to use for the generated code
     */
    public function OTP (secret: ByteArray = null, period: int = 30, digits: int = 6) {
      if (secret === null) {
        var ranBytes: ByteArray = new ByteArray();
        ranBytes.length = 16;
        for (var i: int = 0; i < 4; i++) {
          ranBytes.writeUnsignedInt(Math.random() * uint.MAX_VALUE);
        }
        _secret = ranBytes
      } else {
        _secret = secret
      }
      _digits = digits;
    }
  
    /**
     * Generate an OTP code based on the input counter
     * @param input
     * @return
     */
    private static function generateOTP(input: int): String {
      var result: String;
      var text: ByteArray = new ByteArray();
      text.length = 8;
    
      for(var i: int = text.length - 1; i >= 0; i--) {
        text[i] = input & 0xFF;
        input >>= 8;
      }
      var hmac: HMAC = new HMAC(new SHA1());
      var digest: ByteArray = hmac.compute(_secret, text);
    
      var offset: int = digest[digest.length - 1] & 0xF;
      var binary: int = ((digest[offset] & 0x7f) << 24) | ((digest[offset + 1] & 0xff) << 16) | ((digest[offset + 2] & 0xff) << 8) | (digest[offset + 3] & 0xff);
    
      var otp: int = binary % DIGITS_POWER[_digits];
      result = otp.toString();
    
      while (result.length < _digits) {
        result = "0" + result;
      }
      return result;
    }
  
    /**
     * Get the number of digits the generated code will use for the current OTP object
     * @return int - the digits
     */
    public function getDigits (): int {
      return _digits;
    }
  
    /**
     * Get the secret key for the current OTP object
     * @return String - the OTP secret
     */
    public function getSecret (): String {
      return _secret.toString();
    }
  
    /**
     * Return the OTP code for a given counter
     * @param counter - the counter integer to use
     * @return String - the OTP code
     */
    public function at (counter: int): String {
      return generateOTP(counter);
    }
  }
}
