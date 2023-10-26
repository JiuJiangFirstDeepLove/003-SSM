package com.soft.page.service;

import java.util.List;

import com.soft.admin.dao.*;
import com.soft.admin.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soft.admin.entity.SblogType;
import com.soft.common.util.DateUtil;
import com.soft.common.util.Md5;
import com.soft.common.util.StringUtil;
import com.soft.common.util.Transcode;

import javax.servlet.http.HttpServletRequest;

@Service
public class IndexManager {
	
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
	 * @param sblog
	 * @return List<Sblog>
	 * @Title: listSblogs
	 * @Description: 查询帖子信息
	 */
	public List<Sblog> listSblogs(Sblog sblog, int[] sum) {
		if (sum != null) {
			sum[0] = sblogDao.listSblogsCount(sblog);
		}
		List<Sblog> sblogs = sblogDao.listSblogs(sblog);
		if (sblogs != null) {
			for (Sblog _sblog : sblogs) {
				SblogReply sblogReply = new SblogReply();
				sblogReply.setStart(-1);
				sblogReply.setSblog_id(_sblog.getSblog_id());
				List<SblogReply> replys = sblogReplyDao.listSblogReplys(sblogReply);
				if (replys != null) {
					_sblog.setReplys(replys);
				}
			}
		}
		return sblogs;
	}
	
	/**
	 * @param sblog
	 * @return Sblog
	 * @Title: querySblog
	 * @Description: 查询帖子
	 */
	public Sblog querySblog(Sblog sblog) {
		Sblog _sblog = sblogDao.getSblog(sblog);
		SblogReply sblogReply = new SblogReply();
		sblogReply.setStart(-1);
		sblogReply.setSblog_id(_sblog.getSblog_id());
		sblogReply.setSblog_reply(-1);
		List<SblogReply> replys = sblogReplyDao.listSblogReplys(sblogReply);
		if (replys != null && replys.size()>0) {
			for (SblogReply reply : replys) {
				SblogReply sblogReply2 = new SblogReply();
				sblogReply2.setStart(-1);
				sblogReply2.setSblog_reply(reply.getSblog_reply_id());
				List<SblogReply> replys2 = sblogReplyDao.listSblogReplys(sblogReply2);
				if (replys2!=null){
					reply.setReplys(replys2);
				}
			}
			_sblog.setReplys(replys);
		}
		return _sblog;
	}
	
	/**
	 * @param sblog
	 * @return void
	 * @Title: addSblog
	 * @Description: 添加帖子
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
	 * @param sblog
	 * @return void
	 * @Title: updateSblogClick
	 * @Description: 更新帖子点击量
	 */
	public void updateSblogClick(Sblog sblog) {
		sblog.setSblog_click(sblog.getSblog_click() + 1);
		sblogDao.updateSblog(sblog);
	}
	
	/**
	 * @param sblogReply
	 * @return void
	 * @Title: addSblogReply
	 * @Description: 添加回复
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
	 * @Title: delSblogs
	 * @Description: 删除帖子信息
	 */
	public void delSblogs(Sblog sblog) {
		sblogDao.delSblogs(sblog.getIds().split(","));
	}
	
	/**
	 * @param sblogReply
	 * @return void
	 * @Title: delSblogReplys
	 * @Description: 删除帖子回复信息
	 */
	public void delSblogReplys(SblogReply sblogReply) {
		sblogReplyDao.delSblogReplys(sblogReply.getIds().split(","));
	}
	
	/**
	 * @param praise
	 * @return Praise
	 * @Title: queryPraise
	 * @Description: 查询点赞
	 */
	public Praise queryPraise(Praise praise) {
		Praise _praise = praiseDao.getPraise(praise);
		return _praise;
	}
	
	/**
	 * @param praise
	 * @return void
	 * @Title: addPraise
	 * @Description: 添加点赞
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
	
	/**
	 * @param focus
	 * @return Focus
	 * @Title: queryFocus
	 * @Description: 查询关注
	 */
	public Focus queryFocus(Focus focus) {
		Focus _focus = focusDao.getFocus(focus);
		return _focus;
	}
	
	/**
	 * @param focus
	 * @return void
	 * @Title: addFocus
	 * @Description: 添加关注
	 */
	public void addFocus(Focus focus) {
		//添加关注
		focus.setFocus_date(DateUtil.getCurDateTime());
		focusDao.addFocus(focus);
		User user = new User();
		user.setUser_id(focus.getSblog_user());
		user = userDao.getUser(user);
		user.setUser_fss(user.getUser_fss() + 1);
		userDao.updateUser(user);
	}
	
	/**
	 * @param focus
	 * @return void
	 * @Title: cancelFocus
	 * @Description: 取消关注
	 */
	public void cancelFocus(Focus focus) {
		//添加关注
		focus = focusDao.getFocus(focus);
		if (focus!=null){
			User user = new User();
			user.setUser_id(focus.getUser_id());
			user = userDao.getUser(user);
			user.setUser_fss(Math.max(user.getUser_fss() - 1, 0));
			userDao.updateUser(user);
		}
	}
	
	/**
	 * @Title: listCollects
	 * @Description: 用户收藏查询
	 * @param collect
	 * @return List<Collect>
	 */
	public List<Collect> listCollects(Collect collect, int[] sum) {
		if (sum != null) {
			sum[0] = collectDao.listCollectsCount(collect);
		}
		List<Collect> collects = collectDao.listCollects(collect);

		return collects;
	}

	/**
	 * @Title: queryCollect
	 * @Description: 用户收藏查询
	 * @param collect
	 * @return Collect
	 */
	public Collect queryCollect(Collect collect) {
		Collect _collect = collectDao.getCollect(collect);
		return _collect;
	}

	/**
	 * @Title: addCollect
	 * @Description: 添加用户收藏
	 * @param collect
	 * @return void
	 */
	public void addCollect(Collect collect) {
		collect.setCollect_date(DateUtil.getCurDateTime());
		collectDao.addCollect(collect);
	}

	/**
	 * @Title: updateCollect
	 * @Description: 更新用户收藏信息
	 * @param collect
	 * @return void
	 */
	public void updateCollect(Collect collect) {
		collectDao.updateCollect(collect);
	}

	/**
	 * @Title: delCollect
	 * @Description: 删除用户收藏信息
	 * @param collect
	 * @return void
	 */
	public void delCollects(Collect collect) {
		collectDao.delCollects(collect.getIds().split(","));
	}
	
	/**
	 * @param visit
	 * @return List<Visit>
	 * @Title: listVisits
	 * @Description: 访问信息查询
	 */
	public List<Visit> listVisits(Visit visit, int[] sum) {
		if (sum != null) {
			sum[0] = visitDao.listVisitsCount(visit);
		}
		List<Visit> visits = visitDao.listVisits(visit);
		return visits;
	}
	
	/**
	 * @param visit
	 * @return Visit
	 * @Title: queryVisit
	 * @Description: 访问信息查询
	 */
	public Visit queryVisit(Visit visit) {
		Visit _visit = visitDao.getVisit(visit);
		return _visit;
	}
	
	/**
	 * @param request
	 * @return void
	 * @Title: addVisit
	 * @Description: 添加访问信息
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
		if (visits != null && visits.size() > 0) {
			Visit _visit = visits.get(0);
			if (_visit.getVisit_date().contains(DateUtil.getCurDate())) {
				long time1 = DateUtil.getDate(_visit.getVisit_date()).getTime();
				long time2 = DateUtil.getCurrentDate().getTime();
				//相同的ip每隔半小时记录一次
				if (time2 - time1 >= 1000 * 60 * 30) {
					addFlag = true;
				}
			} else {
				addFlag = true;
			}
		} else {
			addFlag = true;
		}
		if (addFlag) {
			visit.setVisit_date(DateUtil.getCurDateTime());
			visitDao.addVisit(visit);
		}
		
	}
	
	/**
	 * @param visit
	 * @return void
	 * @Title: updateVisit
	 * @Description: 更新访问信息信息
	 */
	public void updateVisit(Visit visit) {
		visitDao.updateVisit(visit);
	}
	
	/**
	 * @param visit
	 * @return void
	 * @Title: delVisit
	 * @Description: 删除访问信息信息
	 */
	public void delVisits(Visit visit) {
		visitDao.delVisits(visit.getIds().split(","));
	}
}
