package {
  public interface OTPInterface {
    /**
     * Get the number of digits the generated code will use for the current OTP object
     * @return
     */
    function getDigits (): int;
    
    /**
     * Get the secret key for the current OTP object
     * @return
     */
    function getSecret (): String;
    
    /**
     * Return the OTP code for a given timestamp
     * @param timestamp - the time as a unix style integer
     * @return
     */
    function at (timestamp: int): String;
  }
}
