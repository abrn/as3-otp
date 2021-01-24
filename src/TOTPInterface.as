package {
  public interface TOTPInterface {
    /**
     * Create a new TOTP object
     * @param secret - the secret to use (will be generated if null)
     * @param period - the period in seconds for the TOTP code to be valid
     * @param digits - the amount of digits to use in the generated code
     */
    function create (secret: String = null, period: int = 30, digits: int = 6): void;
    
    /**
     * Return the TOTP code at the current time
     * @return String - the TOTP code
     */
    function now (): String;
    
    /**
     * Return the TOTP code for a given counter
     * @param timestamp - the timestamp to generate the code for
     * @return String - the TOTP code
     */
    function at (timestamp: int): String;
    
    /**
     * Get the number of digits the generated code will use for the current TOTP object
     * @return int - the amount of digits
     */
    function getDigits (): int;
    
    /**
     * Get the secret key for the current TOTP object
     * @return String - the secret key in string format
     */
    function getSecret (): String;
    
    /**
     * Get the unix time for a current TOTP code generation
     * @return int - the unix timestamp
     */
    function getTime (): int;
  }
}
