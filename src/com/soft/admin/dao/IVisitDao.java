package com.soft.admin.dao;

import java.util.List;
import com.soft.admin.entity.Visit;

public interface IVisitDao {

	public abstract int addVisit(Visit visit);

	public abstract int delVisit(String visit_id);

	public abstract int delVisits(String[] visit_ids);

	public abstract int updateVisit(Visit visit);

	public abstract int updateVisitAll(Visit visit);

	public abstract Visit getVisit(Visit visit);

	public abstract List<Visit>  listVisits(Visit visit);

	public abstract int listVisitsCount(Visit visit);

}
