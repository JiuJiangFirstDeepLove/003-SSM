package com.soft.admin.dao;

import java.util.List;
import com.soft.admin.entity.Praise;

public interface IPraiseDao {

	public abstract int addPraise(Praise praise);

	public abstract int delPraise(String praise_id);

	public abstract int delPraises(String[] praise_ids);

	public abstract int updatePraise(Praise praise);

	public abstract int updatePraiseAll(Praise praise);

	public abstract Praise getPraise(Praise praise);

	public abstract List<Praise>  listPraises(Praise praise);

	public abstract int listPraisesCount(Praise praise);

}
