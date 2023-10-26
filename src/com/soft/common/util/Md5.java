package com.soft.common.util;
import org.apache.commons.codec.digest.DigestUtils;
/**
 * 字符串加密工具类
 * @author cc
 *
 */
public class Md5 {
	
	/**
	 * 密码加密，特性是只能正向加密，不能反解，用户没输入一次就加密一次，比如admin，先输入用户名，到数据库中查对应用户名的密码是多少，查到后放到程序中，跟输入的密码加密之后的进行比对，一样则会登录成功
	 * @param password
	 * @return
	 */
	public static String makeMd5(String password){
		if (password==null || "".equals(password)) {
			return password;
		}
		return DigestUtils.md5Hex(password);
	}
	
	public static void main(String[] args){
        System.out.println(makeMd5("111111"));//96e79218965eb72c92a549dd5a330112
    }
}
