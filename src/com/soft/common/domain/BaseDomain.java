package com.soft.common.domain;

import java.io.Serializable;

public abstract class BaseDomain implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3308831596689250063L;

	private int start;
	
	private int limit = 20;

	private int end;
	
	/**
     * 排序字段（例sp.spCode）.
     */
    private String sort;

    /**
     * 正序|反序（例ASC）.
     */
    private String order;
    
    /**
     * 正序|反序（例ASC）.
     */
    private String dir;
    
    
    public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}
	
	public String getOrder()
	{
		return order;
	}

	public void setOrder(String order)
	{
		this.order = order;
	}

	public String getSort()
	{
		return sort;
	}

	public void setSort(String sort)
	{
		this.sort = sort;
	}

	public void setDir(String dir) {
		this.dir = dir;
	}

	public String getDir() {
		return dir;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}
    
    
}
