package com.bristua.flutter.ftshop.wxapi;

public class WXPayResult {

    /**
     * code : 0
     * msg : 统一下单成功
     * data : {"appid":"wx1d942a6d38bd07f0","partnerid":"1532513001","prepayid":"wx2002162997752955823f9ed40112532255","packages":"Sign=WXPay","noncestr":"dczw4jmyiqtoq492s9r3r305ngwf8jlj","timestamp":"1555697754","sign":"03E3334F817CE89A30559D811BA9251D"}
     */

    public int code;
    public String msg;
    public DataBean data;

    public static class DataBean {
        /**
         * appid : wx1d942a6d38bd07f0
         * partnerid : 1532513001
         * prepayid : wx2002162997752955823f9ed40112532255
         * packages : Sign=WXPay
         * noncestr : dczw4jmyiqtoq492s9r3r305ngwf8jlj
         * timestamp : 1555697754
         * sign : 03E3334F817CE89A30559D811BA9251D
         */

        public String appid;
        public String partnerid;
        public String prepayid;
        public String packages;
        public String noncestr;
        public String timestamp;
        public String sign;
    }
}
