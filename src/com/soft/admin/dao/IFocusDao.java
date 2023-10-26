package com.soft.admin.dao;

import com.soft.admin.entity.Focus;

import java.util.List;

public interface IFocusDao {

	public abstract int addFocus(Focus focus);

	public abstract int delFocus(String focus_id);

	public abstract int delFocuss(String[] focus_ids);

	public abstract int updateFocus(Focus focus);

	public abstract Focus getFocus(Focus focus);

	public abstract List<Focus>  listFocuss(Focus focus);

	public abstract int listFocussCount(Focus focus);

}
