package com.soft.admin.dao;

import java.util.List;
import com.soft.admin.entity.SblogType;

public interface ISblogTypeDao {

	public abstract int addSblogType(SblogType sblogType);

	public abstract int delSblogType(String sblog_type_id);

	public abstract int delSblogTypes(String[] sblog_type_ids);

	public abstract int updateSblogType(SblogType sblogType);

	public abstract int updateSblogTypeAll(SblogType sblogType);

	public abstract SblogType getSblogType(SblogType sblogType);

	public abstract List<SblogType>  listSblogTypes(SblogType sblogType);

	public abstract int listSblogTypesCount(SblogType sblogType);

}
