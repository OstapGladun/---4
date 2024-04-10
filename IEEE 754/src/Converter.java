public class Converter {    
    public static void main(String[] args) {
        double decToConvert = -12.75;
        System.out.println(decToConvert + " у системі IEEE754: " + fromDecimalToIEEE754(decToConvert));
        String hexToConvert = "438EA000";
        System.out.println(hexToConvert + " у десятковій системі: " + fromIEEE754ToDecimal(hexToConvert));
    }

    public static String fromDecimalToIEEE754(double dec) {
        if (dec == 0)
            return "00000000000000000000000000000000";

        String sign = "0";
        if(dec < 1)
            sign = "1";
        dec = Math.abs(dec);

        String mantissaFullPart = fromDecimalToBinary((long) Math.floor(dec)); //ціла частина
        String mantissaFractPart = fromDecimalFractionToBinary(dec - Math.floor(dec)); //дробова

        String mantissaBin = mantissaFullPart + mantissaFractPart;
        mantissaBin = mantissaBin.substring(1);
        while (mantissaBin.length() < 23)
            mantissaBin += "0";

        int exponentDec = mantissaFullPart.length()-1 + 127;
        String exponentBin = fromDecimalToBinary(exponentDec);

        String ieee754 = sign + exponentBin + mantissaBin;
        ieee754 = fromBinaryToHexadecimal(ieee754);
        return ieee754;
    }

    public static double fromIEEE754ToDecimal(String hex) {
        String bin = fromHexadecimalToBinary(hex);
        char sign = bin.charAt(0);
        String exponentBin = bin.substring(1,9);
        String mantissaBin = "1" + bin.substring(9);

        int exponentDec = fromBinaryToDecimal(exponentBin) - 127;
        int pointLocation = exponentDec; //після якого біта стоїть кома в мантисі

        String mantissaBeforePointBin = mantissaBin.substring(0, pointLocation+1);
        String mantissaAfterPointBin = mantissaBin.substring(pointLocation+1);

        int mantissaBeforePointDec = fromBinaryToDecimal(mantissaBeforePointBin);
        double mantissaAfterPointDec = fromBinaryToDecimalFraction(mantissaAfterPointBin);

        double dec = mantissaBeforePointDec + mantissaAfterPointDec;
        if(sign == '1')
            dec *= -1;
        return dec;
    }

    private static String fromDecimalToBinary(long dec){
        String bin = "";
        while (dec > 0)
        {
            bin = (dec % 2) + bin;
            dec /= 2;
        }
        return bin;
    }

    //для дробової частини числа
    private static String fromDecimalFractionToBinary(double dec){
        String bin = "";
        while (dec > 0) {
            dec *= 2;
            if (dec >= 1) {
                bin += "1";
                dec -= 1;
            }
            else {
                bin += "0";
            }
        }
        return bin;
    }

    private static int fromBinaryToDecimal(String bin){
        int dec = 0;
        for (int i = 0; i <  bin.length(); i++) {
            int n = bin.charAt(i) - '0';
            dec += (int) (n * Math.pow(2, bin.length() - i - 1));
        }
        return dec;
    }

    //для дробової частини числа
    private static double fromBinaryToDecimalFraction(String bin){
        double dec = 0;
        for (int i = 0; i < bin.length(); i++) {
            int n = bin.charAt(i) - '0';
            dec += n * Math.pow(2, -(i+1));
        }
        return dec;
    }

    private static String fromHexadecimalToBinary(String hex){
        StringBuilder bin = new StringBuilder();
        for (int i = 0; i < hex.length(); i++) {
            bin.append(getFourBits(hex.charAt(i)));
        }
        return bin.toString();
    }

    private static String fromBinaryToHexadecimal(String bin){
        StringBuilder hex = new StringBuilder();
        for (int i = 0; i < bin.length()-4; i+=4) {
            String fourBits = bin.substring(i, i+4);
            hex.append(getHexCharacter(fromBinaryToDecimal(fourBits)));
        }
        return hex.toString();
    }

    //з 1 шістнадцятковий символа в 4 біти
    private static String getFourBits(char hex){
        String bin = fromDecimalToBinary(getDecNumber(hex));
        while (bin.length() < 4)
            bin = "0" + bin;
        return bin;
    }

    private static long getDecNumber(char hex){
        switch (Character.toUpperCase(hex)){
            case 'A':
                return 10;
            case 'B':
                return 11;
            case 'C':
                return 12;
            case 'D':
                return 13;
            case 'E':
                return 14;
            case 'F':
                return 15;
            default:
                return hex - '0';
        }
    }

    private static String getHexCharacter(int dec){
        switch (dec){
            case 10:
                return "A";
            case 11:
                return "B";
            case 12:
                return "C";
            case 13:
                return "D";
            case 14:
                return "E";
            case 15:
                return "F";
            default:
                return String.valueOf(dec);
        }
    }
}