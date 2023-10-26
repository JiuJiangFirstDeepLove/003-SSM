package com.soft.admin.dao;

import com.soft.admin.entity.Sensitive;

import java.util.List;

public interface ISensitiveDao {

	public abstract int addSensitive(Sensitive sensitive);

	public abstract int delSensitive(String sensitive_id);

	public abstract int delSensitives(String[] sensitive_ids);

	public abstract int updateSensitive(Sensitive sensitive);

	public abstract int updateSensitiveAll(Sensitive sensitive);

	public abstract Sensitive getSensitive(Sensitive sensitive);

	public abstract List<Sensitive>  listSensitives(Sensitive sensitive);

	public abstract int listSensitivesCount(Sensitive sensitive);

}
