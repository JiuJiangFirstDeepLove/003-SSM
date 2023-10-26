package com.soft.page.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.soft.admin.entity.User;
import com.soft.common.util.DateUtil;
import com.soft.common.util.JSONData;
import com.soft.page.service.IndexManager;
import com.soft.page.service.LoginIndexManager;

@Controller
public class LoginIndexAction {

	@Autowired
	LoginIndexManager loginIndexManager;
	@Autowired
	IndexManager indexManager;
	public IndexManager getIndexManager() {
		return indexManager;
	}
	public void setIndexManager(IndexManager indexManager) {
		this.indexManager = indexManager;
	}

	public LoginIndexManager getLoginIndexManager() {
		return loginIndexManager;
	}
	public void setLoginIndexManager(LoginIndexManager loginIndexManager) {
		this.loginIndexManager = loginIndexManager;
	}
	/**
	 * @Title: InSystem
	 * @Description: 用户登录
	 * @return String
	 */
	@RequestMapping(value="LoginInSystem.action",method=RequestMethod.POST)
	@ResponseBody
	public JSONData InSystem(User params,
			ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
		JSONData jsonData = new JSONData();
		try {
			//用户登录查询
			loginIndexManager.updateUserFlag();
			params.setUser_type(1);
			User admin = loginIndexManager.getUser(params);
			if (admin!=null) {
				httpSession.setAttribute("userFront", admin);
			}else {
				jsonData.setErrorReason("用户名或密码错误");
				return jsonData;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrorReason("登录异常，请稍后重试");
			return jsonData;
		}
		
		return jsonData;
	}
	
	/**
	 * @Title: OutSystem
	 * @Description: 退出登录
	 * @return String
	 */
	@RequestMapping(value="LoginOutSystem.action")
	@ResponseBody
	public JSONData OutSystem(HttpSession httpSession){
		JSONData jsonData = new JSONData();
		try {
			//用户查询
			User user = (User)httpSession.getAttribute("userFront");
			if (user!=null) {
				//退出登录
				httpSession.removeAttribute("userFront");
				httpSession.invalidate();
			}
			
		} catch (Exception e) {
			jsonData.setErrorReason("退出异常，请稍后重试");
			return jsonData;
		}
		
		return jsonData;
	}
	
	/**
	 * @Title: RegSystem
	 * @Description: 用户注册
	 * @return String
	 */
	@RequestMapping(value="LoginRegSystem.action",method=RequestMethod.POST)
	@ResponseBody//把返回的数据转化成字符串
	public JSONData RegSystem(User params,
			ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
		JSONData jsonData = new JSONData();
		try {
			//验证码验证
//			String random = (String)httpSession.getAttribute("random");
//			if (!random.equals(params.getRandom())) {
//				jsonData.setErrorReason("验证码错误");
//				return jsonData;
//			}
			
			//查询用户名是否被占用
			User user = new User();
			user.setUser_name(params.getUser_name());
			User user_temp = loginIndexManager.getUser(user);
			if (user_temp!=null) {
				jsonData.setErrorReason("注册失败，用户名已被注册："+params.getUser_name());
				return jsonData;
			}
			
			//添加用户入库
			params.setUser_type(1);
			params.setReg_date(DateUtil.getCurDateTime());
			loginIndexManager.addUser(params);
			
		} catch (Exception e) {
			jsonData.setErrorReason("注册异常，请稍后重试");
			return jsonData;
		}
		
		return jsonData;
	}
	
}
