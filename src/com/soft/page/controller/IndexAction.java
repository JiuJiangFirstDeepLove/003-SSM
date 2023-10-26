package com.soft.page.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.soft.admin.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.soft.admin.entity.SblogType;
import com.soft.common.util.JSONData;
import com.soft.common.util.Md5;
import com.soft.common.util.PaperUtil;
import com.soft.page.service.IndexManager;

@Controller
public class IndexAction{

	@Autowired
	IndexManager indexManager;

	String tip;
	
	/**
	 * @Title: index
	 * @Description: 首页
	 * @return String
	 */
	@RequestMapping(value="page_index.action",method=RequestMethod.GET)//注解，响应方法
	public String index(HttpServletRequest request, HttpSession httpSession, ModelMap model){
		//精华帖
		Sblog sblog = new Sblog();
		sblog.setStart(0);
		sblog.setLimit(8);
		sblog.setTop_flag(1);
		sblog.setSblog_kind(2);
		List<Sblog> sblogs = indexManager.listSblogs(sblog,null);
		model.addAttribute("sblogs", sblogs);
		
		//热帖榜
		sblog.setSblog_kind(0);
		sblog.setTop_flag(1);
		List<Sblog> sblogs2 = indexManager.listSblogs(sblog, null);
		model.addAttribute("sblogs2", sblogs2);
		
		//新帖榜
		sblog.setSblog_kind(0);
		sblog.setTop_flag(2);
		List<Sblog> sblogs3 = indexManager.listSblogs(sblog, null);
		model.addAttribute("sblogs3", sblogs3);
		
		//我的关注帖子
		User userFront = (User)httpSession.getAttribute("userFront");
		if (userFront!=null){
			Sblog sblog2 = new Sblog();
			sblog2.setStart(0);
			sblog2.setLimit(8);
			sblog2.setUser_focus(userFront.getUser_id());
			List<Sblog> sblogs4 = indexManager.listSblogs(sblog2, null);
			model.addAttribute("sblogs4", sblogs4);
		}
		
		//记录访问IP
		indexManager.addVisit(request);
		
		return "default"; 
	}
	
	/**
	 * @Title: listSblogTypes
	 * @Description: 查询论坛板块
	 * @return String
	 */
	@RequestMapping(value="page_listSblogTypes.action")
	public String listSblogTypes(SblogType paramsSblogType,PaperUtil paperUtil,
			ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
		try {
			if (paramsSblogType==null) {
				paramsSblogType = new SblogType();
			}
			if (paperUtil==null) {
				paperUtil = new PaperUtil();
			}
			//设置分页信息
			paperUtil.setPagination(paramsSblogType);
			//paramsSblogType.setStart(-1);
			//总的条数
			int[] sum={0};
			//查询论坛板块列表
			List<SblogType> sblogTypes = indexManager.listSblogTypes(paramsSblogType,sum); 
			model.addAttribute("sblogTypes", sblogTypes);
			model.addAttribute("paramsSblogType", paramsSblogType);
			paperUtil.setTotalCount(sum[0]);
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "sblogType";
	}
	
	/**
	 * @Title: listSblogs
	 * @Description: 查询帖子,在此界面不显示全局搜索框
	 * @return String
	 */
	@RequestMapping(value="page_listSblogs.action")
	public String listSblogs(Sblog paramsSblog,PaperUtil paperUtil,
			ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
		try {
			if (paramsSblog==null) {
				paramsSblog = new Sblog();
			}
			if (paperUtil==null) {
				paperUtil = new PaperUtil();
			}
			//设置分页信息
			paperUtil.setPagination(paramsSblog);
			//总的条数
			int[] sum={0};
			//查询帖子列表
			List<Sblog> sblogs = indexManager.listSblogs(paramsSblog,sum); 
			model.addAttribute("sblogs", sblogs);
			model.addAttribute("paramsSblog", paramsSblog);
			paperUtil.setTotalCount(sum[0]);
			
			//查询帖子分类
			SblogType sblogType = new SblogType();
			sblogType.setStart(-1);
			List<SblogType> sblogTypes = indexManager.listSblogTypes(sblogType, null);
			if (sblogTypes ==null) {
				sblogTypes = new ArrayList<SblogType>();
			}
			model.addAttribute("sblogTypes", sblogTypes);
			
			model.addAttribute("search_no", true);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "sblog";
	}
	
	/**
	 * @return String
	 * @Title: listSblogsFocus
	 * @Description: 查询关注帖子, 在此界面不显示全局搜索框
	 */
	@RequestMapping(value = "page_listSblogsFocus.action")
	public String listSblogsFocus(Sblog paramsSblog, PaperUtil paperUtil,
							 ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) {
		try {
			if (paramsSblog == null) {
				paramsSblog = new Sblog();
			}
			if (paperUtil == null) {
				paperUtil = new PaperUtil();
			}
			//设置分页信息
			paperUtil.setPagination(paramsSblog);
			//总的条数
			int[] sum = {0};
			//限制为关注
			User userFront = (User) httpSession.getAttribute("userFront");
			paramsSblog.setUser_focus(userFront.getUser_id());
			//查询帖子列表
			List<Sblog> sblogs = indexManager.listSblogs(paramsSblog, sum);
			model.addAttribute("sblogs", sblogs);
			model.addAttribute("paramsSblog", paramsSblog);
			paperUtil.setTotalCount(sum[0]);
			
			//查询帖子分类
			SblogType sblogType = new SblogType();
			sblogType.setStart(-1);
			List<SblogType> sblogTypes = indexManager.listSblogTypes(sblogType, null);
			if (sblogTypes == null) {
				sblogTypes = new ArrayList<SblogType>();
			}
			model.addAttribute("sblogTypes", sblogTypes);
			
			model.addAttribute("search_no", true);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "sblogFocus";
	}
	
	/**
	 * @Title: querySblog
	 * @Description: 查询帖子
	 * @return String
	 */
	@RequestMapping(value="page_querySblog.action",method=RequestMethod.GET)
	public String querySblog(Sblog paramsSblog,
			ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
		try {
			 //得到帖子
			Sblog sblog = indexManager.querySblog(paramsSblog);
			//更新点击量
			indexManager.updateSblogClick(sblog);
			model.addAttribute("sblog", sblog);
			
			//判断用户是否关注
			User userFront = (User) httpSession.getAttribute("userFront");
			if (userFront!=null){
				Focus focus = new Focus();
				focus.setUser_id(userFront.getUser_id());
				focus.setSblog_user(sblog.getUser_id());
				focus = indexManager.queryFocus(focus);
				model.addAttribute("focus", focus);
			}

		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "sblogDetail";
	}
	
	 /**
     * @Title: addPraise
     * @Description: 新增点赞
     * @return String
     */
    @RequestMapping(value="page_addPraise.action")
    @ResponseBody
    public JSONData addPraise(Praise paramsPraise,PaperUtil paperUtil,
                             ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
        JSONData jsonData = new JSONData();
        try {
        	//判断点赞
        	Praise praise = new Praise();
        	praise.setUser_id(paramsPraise.getUser_id());
        	praise.setSblog_id(paramsPraise.getSblog_id());
        	praise.setPraise_type(paramsPraise.getPraise_type());
        	praise = indexManager.queryPraise(praise);
        	if (praise!=null) {
                jsonData.setErrorReason("您已经点赞过了，无需重复点赞！");
                return jsonData;
			}
            //新增点赞
        	indexManager.addPraise(paramsPraise);

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrorReason("新增点赞失败！");
            return jsonData;
        }

        return jsonData;
    }
	
	/**
	 * @return String
	 * @Title: addCollect
	 * @Description: 新增收藏
	 */
	@RequestMapping(value = "page_addCollect.action")
	@ResponseBody
	public JSONData addCollect(Collect paramsCollect, PaperUtil paperUtil,
							   ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) {
		JSONData jsonData = new JSONData();
		try {
			//收藏验证
			Collect collect = indexManager.queryCollect(paramsCollect);
			if (collect == null) {
				//新增收藏
				indexManager.addCollect(paramsCollect);
			} else {
				jsonData.setErrorReason("您已经收藏过了！");
				return jsonData;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrorReason("收藏失败");
			return jsonData;
		}
		
		return jsonData;
	}
	
	/**
	 * @return String
	 * @Title: addFocus
	 * @Description: 新增关注
	 */
	@RequestMapping(value = "page_addFocus.action")
	@ResponseBody
	public JSONData addFocus(Focus paramsFocus, PaperUtil paperUtil,
							   ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) {
		JSONData jsonData = new JSONData();
		try {
			//关注验证
			Focus focus = indexManager.queryFocus(paramsFocus);
			if (focus == null) {
				//新增关注
				indexManager.addFocus(paramsFocus);
			} else {
				jsonData.setErrorReason("您已经关注过了！");
				return jsonData;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrorReason("关注失败");
			return jsonData;
		}
		
		return jsonData;
	}
	
	/**
	 * @return String
	 * @Title: cancelFocus
	 * @Description: 取消关注
	 */
	@RequestMapping(value = "page_cancelFocus.action")
	@ResponseBody
	public JSONData cancelFocus(Focus paramsFocus, PaperUtil paperUtil,
							 ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) {
		JSONData jsonData = new JSONData();
		try {
			//取消关注
			indexManager.cancelFocus(paramsFocus);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrorReason("取消关注失败");
			return jsonData;
		}
		
		return jsonData;
	}
	
	/**
	 * @return String
	 * @Title: addSblogShow
	 * @Description: 查询帖子, 在此界面不显示全局搜索框
	 */
	@RequestMapping(value = "page_addSblogShow.action")
	public String addSblogShow(PaperUtil paperUtil,
							 ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) {
		try {
			//查询帖子分类
			SblogType sblogType = new SblogType();
			sblogType.setStart(-1);
			List<SblogType> sblogTypes = indexManager.listSblogTypes(sblogType, null);
			if (sblogTypes == null) {
				sblogTypes = new ArrayList<SblogType>();
			}
			model.addAttribute("sblogTypes", sblogTypes);
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "sblogAdd";
	}
	
	 /**
     * @Title: addSblog
     * @Description: 新增帖子
     * @return String
     */
    @RequestMapping(value="page_addSblog.action")
    @ResponseBody
    public JSONData addSblog(Sblog paramsSblog,PaperUtil paperUtil,
                             ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
        JSONData jsonData = new JSONData();
        try {
            //新增帖子
        	indexManager.addSblog(paramsSblog);

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrorReason("新增帖子失败！");
            return jsonData;
        }

        return jsonData;
    }

    /**
     * @Title: addSblogReply
     * @Description: 回复留言
     * @return String
     */
    @RequestMapping(value="page_addSblogReply.action")
    @ResponseBody
    public JSONData addSblogReply(SblogReply paramsSblogReply,PaperUtil paperUtil,
                                  ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
        JSONData jsonData = new JSONData();
        try {
            //回复留言
        	indexManager.addSblogReply(paramsSblogReply);

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrorReason("回复留言失败！");
            return jsonData;
        }

        return jsonData;
    }

    /**
     * @Title: delSblogs
     * @Description: 删除帖子信息
     * @return String
     */
    @RequestMapping(value="page_delSblogs.action")
    @ResponseBody
    public JSONData delSblogs(Sblog paramsSblog){
        JSONData jsonData = new JSONData();
        try {
            //删除帖子信息
        	indexManager.delSblogs(paramsSblog);

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrorReason("后台服务器异常");
            return jsonData;
        }
        return jsonData;
    }

    /**
     * @Title: delSblogReplys
     * @Description: 删除留言回复信息
     * @return String
     */
    @RequestMapping(value="page_delSblogReplys.action")
    @ResponseBody
    public JSONData delSblogReplys(SblogReply paramsSblogReply){
        JSONData jsonData = new JSONData();
        try {
            //删除留言回复信息
        	indexManager.delSblogReplys(paramsSblogReply);

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrorReason("后台服务器异常");
            return jsonData;
        }
        return jsonData;
    }
    
	/**
	 * @Title: saveAdmin
	 * @Description: 保存修改个人信息
	 * @return String
	 */
	@RequestMapping(value="page_saveUserFront.action",method=RequestMethod.POST)
	@ResponseBody
	public JSONData saveUserFront(User paramsUser,
			ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
		JSONData jsonData = new JSONData();
		try {
			 //保存修改个人信息
			indexManager.updateUser(paramsUser);
			//更新session
			User admin = new User();
			admin.setUser_id(paramsUser.getUser_id());
			admin = indexManager.queryUser(admin);
			httpSession.setAttribute("userFront", admin);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrorReason("后台服务器异常");
			return jsonData;
		}
		return jsonData;
	}
	
	/**
	 * @Title: saveUserFrontPass
	 * @Description: 保存修改个人密码
	 * @return String
	 */
	@RequestMapping(value="page_saveUserFrontPass.action",method=RequestMethod.POST)
	@ResponseBody
//@RequestMapping实现页面跳转，直接跳转到相应的页面  2：@RequestMapping和@ResponseBody并把数据展示在原来页面，页面不变，返回的是数据
	public JSONData saveUserFrontPass(User paramsUser,
			ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
		JSONData jsonData = new JSONData();
		try {
			User userFront = (User)httpSession.getAttribute("userFront");
			if (!userFront.getUser_pass().equals(Md5.makeMd5(paramsUser.getUser_passOld()))) {
				jsonData.setErrorReason("修改异常，原密码错误");
				return jsonData;
			}
			 //保存修改个人信息
			indexManager.updateUser(paramsUser);
			//更新session
			if (userFront!=null) {
				userFront.setUser_pass(paramsUser.getUser_pass());
				httpSession.setAttribute("userFront", userFront);
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrorReason("后台服务器异常");
			return jsonData;
		}
		return jsonData;
	}
	
	/**
	 * @Title: listMyCollects
	 * @Description: 查询我的帖子收藏
	 * @return String
	 */
	@RequestMapping(value="page_listMyCollects.action")
	public String listMyCollects(Collect paramsCollect,PaperUtil paperUtil,
			ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
		try {
			if (paramsCollect==null) {
				paramsCollect = new Collect();
			}
			//获取用户,用户只能查询自己的帖子收藏
			User userFront = (User)httpSession.getAttribute("userFront");
			paramsCollect.setUser_id(userFront.getUser_id());
			//设置分页信息
			//paperUtil.setLimit(7);
			paperUtil.setPagination(paramsCollect);
			//总的条数
			int[] sum={0};
			//查询帖子收藏
			List<Collect> collects = indexManager.listCollects(paramsCollect,sum); 
			model.addAttribute("collects", collects);
			paperUtil.setTotalCount(sum[0]);
			model.addAttribute("paramsCollect", paramsCollect);
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "collectShow";
	}
	
	/**
	 * @Title: delCollects
	 * @Description: 删除帖子收藏
	 * @return String
	 */
	@RequestMapping(value="page_delCollects.action")
	@ResponseBody
	public JSONData delCollects(Collect paramsCollect,PaperUtil paperUtil,
			ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession httpSession){
		JSONData jsonData = new JSONData();
		try {
			 //删除帖子收藏
			indexManager.delCollects(paramsCollect);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrorReason("后台服务器繁忙！");
			return jsonData;
		}
		
		return jsonData;
	}
	
	/**
	 * @return String
	 * @Title: listMySblogs
	 * @Description: 查询我的帖子
	 */
	@RequestMapping(value = "page_listMySblogs.action")
	public String listMySblogs(Sblog paramsSblog, PaperUtil paperUtil,
							   ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) {
		try {
			if (paramsSblog == null) {
				paramsSblog = new Sblog();
			}
			//获取用户,用户只能查询自己的帖子
			User userFront = (User) httpSession.getAttribute("userFront");
			paramsSblog.setUser_id(userFront.getUser_id());
			//设置分页信息
			//paperUtil.setLimit(7);
			paperUtil.setPagination(paramsSblog);
			//总的条数
			int[] sum = {0};
			//查询帖子
			List<Sblog> sblogs = indexManager.listSblogs(paramsSblog, sum);
			model.addAttribute("sblogs", sblogs);
			paperUtil.setTotalCount(sum[0]);
			model.addAttribute("paramsSblog", paramsSblog);
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "sblogShow";
	}
	
	/**
	 * @Title: reg
	 * @Description: 跳转注册页面
	 * @return String
	 */
	@RequestMapping(value="page_reg.action")
	public String reg(){
		return "reg";
	}
	
	/**
	 * @Title: myInfo
	 * @Description: 跳转个人信息页面
	 * @return String
	 */
	@RequestMapping(value="page_myInfo.action")
	public String myInfo(){
		return "myInfo";
	}
	
	/**
	 * @Title: myPwd
	 * @Description: 跳转个人密码页面
	 * @return String
	 */
	@RequestMapping(value="page_myPwd.action")
	public String myPwd(){
		return "myPwd";
	}
}
