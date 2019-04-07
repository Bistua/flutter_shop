package com.bristua.flutter.ftshop.exception;

import android.support.annotation.Nullable;

/**
 * 虚拟机异常
 * @author richsjeson
 */
public class VMachineException extends  Exception{

   public VMachineException(@Nullable String pMesg){

       super(pMesg);
   }
}
