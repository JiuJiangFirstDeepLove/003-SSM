package com.soft.admin.service;

import com.soft.admin.dao.*;
import com.soft.admin.entity.*;
import com.soft.common.util.DateUtil;
import com.soft.common.util.Md5;
import com.soft.common.util.StringUtil;
import com.soft.common.util.Transcode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class AdminManager {
	
	//所有待注入Dao类
	@Autowired
	IUserDao userDao;
	@Autowired
	ISensitiveDao sensitiveDao;
	@Autowired
	ISblogTypeDao sblogTypeDao;
	@Autowired
	ISblogDao sblogDao;
	@Autowired
	ISblogReplyDao sblogReplyDao;
	@Autowired
	IVisitDao visitDao;
	@Autowired
	IPraiseDao praiseDao;
	@Autowired
	ICollectDao collectDao;
	@Autowired
	IFocusDao focusDao;
	
	/**
	 * @Title: listUsers
	 * @Description: 查询用户集合
	 * @param user
	 * @return List<User>
	 */
	public List<User> listUsers(User user, int[] sum) {
		if (sum != null) {
			sum[0] = userDao.listUsersCount(user);
		}
		List<User> users = userDao.listUsers(user);
		return users;
	}

	/**
	 * @Title: queryUser
	 * @Description: 用户单个查询
	 * @param user
	 * @return User
	 */
	public User queryUser(User user) {
		User _user = userDao.getUser(user);
		return _user;
	}

	/**
	 * @Title: addUser
	 * @Description: 添加用户
	 * @param user
	 * @return void
	 */
	public void addUser(User user) {
		//密码MD5加密
		if (!StringUtil.isEmptyString(user.getUser_pass())) {
			user.setUser_pass(Md5.makeMd5(user.getUser_pass()));
		}
		//默认头像
		if (StringUtil.isEmptyString(user.getUser_photo())) {
			user.setUser_photo("default.jpg");
		}
		user.setUser_flag(1);
		//添加用户
		userDao.addUser(user);
	}

	/**
	 * @Title: updateUser
	 * @Description: 更新用户信息
	 * @param user
	 * @return void
	 */
	public void updateUser(User user) {
		//密码MD5加密
		if (!StringUtil.isEmptyString(user.getUser_pass())) {
			user.setUser_pass(Md5.makeMd5(user.getUser_pass()));
		}
		userDao.updateUser(user);
	}
	
	public void updateUserFlag() {
		userDao.updateUserFlag();
	}

	/**
	 * @Title: delUsers
	 * @Description: 删除用户信息
	 * @param user
	 * @return void
	 */
	public void delUsers(User user) {
		userDao.delUsers(user.getIds().split(","));
	}
	
	/**
	 * @Title: listSblogTypes
	 * @Description: 论坛板块查询
	 * @param sblogType
	 * @return List<SblogType>
	 */
	public List<SblogType> listSblogTypes(SblogType sblogType, int[] sum) {
		if (sum != null) {
			sum[0] = sblogTypeDao.listSblogTypesCount(sblogType);
		}
		List<SblogType> sblogTypes = sblogTypeDao.listSblogTypes(sblogType);
		return sblogTypes;
	}

	/**
	 * @Title: querySblogType
	 * @Description: 论坛板块查询
	 * @param sblogType
	 * @return SblogType
	 */
	public SblogType querySblogType(SblogType sblogType) {
		SblogType _sblogType = sblogTypeDao.getSblogType(sblogType);
		return _sblogType;
	}

	/**
	 * @Title: addSblogType
	 * @Description: 添加论坛板块
	 * @param sblogType
	 * @return void
	 */
	public void addSblogType(SblogType sblogType) {
		sblogTypeDao.addSblogType(sblogType);
		
	}

	/**
	 * @Title: updateSblogType
	 * @Description: 更新论坛板块信息
	 * @param sblogType
	 * @return void
	 */
	public void updateSblogType(SblogType sblogType) {
		sblogTypeDao.updateSblogType(sblogType);
	}
	
	/**
	 * @Title: delSblogType
	 * @Description: 删除论坛板块信息
	 * @param sblogType
	 * @return void
	 */
	public void delSblogTypes(SblogType sblogType) {
		sblogTypeDao.delSblogTypes(sblogType.getIds().split(","));
	}
	
	/**
	 * @Title: listSensitives
	 * @Description: 违禁词查询
	 * @param sensitive
	 * @return List<Sensitive>
	 */
	public List<Sensitive> listSensitives(Sensitive sensitive, int[] sum) {
		if (sum != null) {
			sum[0] = sensitiveDao.listSensitivesCount(sensitive);
		}
		List<Sensitive> sensitives = sensitiveDao.listSensitives(sensitive);
		return sensitives;
	}

	/**
	 * @Title: querySensitive
	 * @Description: 违禁词查询
	 * @param sensitive
	 * @return Sensitive
	 */
	public Sensitive querySensitive(Sensitive sensitive) {
		Sensitive _sensitive = sensitiveDao.getSensitive(sensitive);
		return _sensitive;
	}

	/**
	 * @Title: addSensitive
	 * @Description: 添加违禁词
	 * @param sensitive
	 * @return void
	 */
	public void addSensitive(Sensitive sensitive) {
		sensitiveDao.addSensitive(sensitive);
		
	}

	/**
	 * @Title: updateSensitive
	 * @Description: 更新违禁词信息
	 * @param sensitive
	 * @return void
	 */
	public void updateSensitive(Sensitive sensitive) {
		sensitiveDao.updateSensitive(sensitive);
	}
	
	/**
	 * @Title: delSensitive
	 * @Description: 删除违禁词信息
	 * @param sensitive
	 * @return void
	 */
	public void delSensitives(Sensitive sensitive) {
		sensitiveDao.delSensitives(sensitive.getIds().split(","));
	}
	
	/**
	 * @Title: listVisits
	 * @Description: 访问信息查询
	 * @param visit
	 * @return List<Visit>
	 */
	public List<Visit> listVisits(Visit visit, int[] sum) {
		if (sum != null) {
			sum[0] = visitDao.listVisitsCount(visit);
		}
		List<Visit> visits = visitDao.listVisits(visit);
		return visits;
	}

	/**
	 * @Title: queryVisit
	 * @Description: 访问信息查询
	 * @param visit
	 * @return Visit
	 */
	public Visit queryVisit(Visit visit) {
		Visit _visit = visitDao.getVisit(visit);
		return _visit;
	}

	/**
	 * @Title: addVisit
	 * @Description: 添加访问信息
	 * @param request
	 * @return void
	 */
    public String getRemortIP(HttpServletRequest request) {
        if (request.getHeader("x-forwarded-for") == null) {
            return request.getRemoteAddr();
        }
        return request.getHeader("x-forwarded-for");
        
    }
	public void addVisit(HttpServletRequest request) {
	    String visit_ip = getRemortIP(request);
	    Visit visit = new Visit();
        visit.setVisit_ip(visit_ip);
	    List<Visit> visits = visitDao.listVisits(visit);
	    boolean addFlag = false;
	    if (visits!=null && visits.size()>0){
	        Visit _visit = visits.get(0);
	        if (_visit.getVisit_date().contains(DateUtil.getCurDate())){
	            long time1 = DateUtil.getDate(_visit.getVisit_date()).getTime();
	            long time2 = DateUtil.getCurrentDate().getTime();
	            //相同的ip每隔半小时记录一次
	            if (time2 - time1 >= 1000*60*30){
                    addFlag = true;
                }
            }else{
                addFlag = true;
            }
        }else{
            addFlag = true;
        }
	    if(addFlag){
            visit.setVisit_date(DateUtil.getCurDateTime());
            visitDao.addVisit(visit);
        }
		
	}

	/**
	 * @Title: updateVisit
	 * @Description: 更新访问信息信息
	 * @param visit
	 * @return void
	 */
	public void updateVisit(Visit visit) {
		visitDao.updateVisit(visit);
	}
	
	/**
	 * @Title: delVisit
	 * @Description: 删除访问信息信息
	 * @param visit
	 * @return void
	 */
	public void delVisits(Visit visit) {
		visitDao.delVisits(visit.getIds().split(","));
	}
	
	/**
	 * @Title: listSblogs
	 * @Description: 查询帖子信息
	 * @param sblog
	 * @return List<Sblog>
	 */
	public List<Sblog>  listSblogs(Sblog sblog, int[] sum){
		if (sum!=null) {
			sum[0] = sblogDao.listSblogsCount(sblog);
		}
		List<Sblog> sblogs = sblogDao.listSblogs(sblog);
		if (sblogs!=null){
			for (Sblog _sblog : sblogs) {
				SblogReply sblogReply = new SblogReply();
				sblogReply.setStart(-1);
				sblogReply.setSblog_id(_sblog.getSblog_id());
				List<SblogReply> replys = sblogReplyDao.listSblogReplys(sblogReply);
				if (replys!=null) {
					_sblog.setReplys(replys);
				}
			}
		}
		return sblogs;
	}

	/**
	 * @Title: querySblog
	 * @Description: 查询帖子
	 * @param sblog
	 * @return Sblog
	 */
	public Sblog querySblog(Sblog sblog) {
		Sblog _sblog = sblogDao.getSblog(sblog);
		SblogReply sblogReply = new SblogReply();
		sblogReply.setStart(-1);
		sblogReply.setSblog_id(_sblog.getSblog_id());
		List<SblogReply> replys = sblogReplyDao.listSblogReplys(sblogReply);
		if (replys!=null) {
			_sblog.setReplys(replys);
		}
		return _sblog;
	}

	/**
	 * @Title: addSblog
	 * @Description: 添加帖子
	 * @param sblog
	 * @return void
	 */
	public void addSblog(Sblog sblog) {
		//添加帖子
		if (!StringUtil.isEmptyString(sblog.getSblog_content())) {
			Sensitive sensitive = sensitiveDao.getSensitive(new Sensitive());
			String sblog_content = sensitive.filterContent(sblog.getSblog_content());
			sblog.setSblog_content(Transcode.htmlEncode(sblog_content));
		}
		sblog.setSblog_date(DateUtil.getCurDateTime());
		sblog.setSblog_kind(1);
		sblogDao.addSblog(sblog);
	}

	/**
	 * @Title: addSblogReply
	 * @Description: 添加回复
	 * @param sblogReply
	 * @return void
	 */
	public void addSblogReply(SblogReply sblogReply) {
		//添加回复
		if (!StringUtil.isEmptyString(sblogReply.getReply_content())) {
			Sensitive sensitive = sensitiveDao.getSensitive(new Sensitive());
			String reply_content = sensitive.filterContent(sblogReply.getReply_content());
			sblogReply.setReply_content(Transcode.htmlEncode(reply_content));
		}
		sblogReply.setReply_date(DateUtil.getCurDateTime());
		sblogReplyDao.addSblogReply(sblogReply);
	}
	
	/**
	 * @param sblog
	 * @return void
	 * @Title: updateSblog
	 * @Description: 更新帖子信息
	 */
	public void updateSblog(Sblog sblog) {
		sblogDao.updateSblog(sblog);
	}
	
	/**
	 * @Title: delSblogs
	 * @Description: 删除帖子信息
	 * @param sblog
	 * @return void
	 */
	public void  delSblogs(Sblog sblog){
		sblogDao.delSblogs(sblog.getIds().split(","));
	}
	/**
	 * @Title: delSblogReplys
	 * @Description: 删除帖子回复信息
	 * @param sblogReply
	 * @return void
	 */
	public void  delSblogReplys(SblogReply sblogReply){
		sblogReplyDao.delSblogReplys(sblogReply.getIds().split(","));
	}
	
	/**
	 * @Title: queryPraise
	 * @Description: 查询点赞
	 * @param praise
	 * @return Praise
	 */
	public Praise queryPraise(Praise praise) {
		Praise _praise = praiseDao.getPraise(praise);
		return _praise;
	}

	/**
	 * @Title: addPraise
	 * @Description: 添加点赞
	 * @param praise
	 * @return void
	 */
	public void addPraise(Praise praise) {
		//添加点赞
		praiseDao.addPraise(praise);
		Sblog sblog = new Sblog();
		sblog.setSblog_id(praise.getSblog_id());
		sblog = sblogDao.getSblog(sblog);
		sblog.setSblog_praise(sblog.getSblog_praise() + 1);
		sblogDao.updateSblog(sblog);
	}
	
}
