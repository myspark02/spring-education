package yju.wdb.domain;

import java.util.*;

public class SampleDTOList {
	
	private List<SampleDTO> list;
	
	public List<SampleDTO> getList() {
		return list;
	}

	public void setList(List<SampleDTO> list) {
		this.list = list;
	}
	
	public String toString() {
		if (list == null) return "Empty";
		StringBuffer sbuf = new StringBuffer();
		for (int i = 0; i < list.size(); i++) {
			sbuf.append(list.get(i)).append("\n");
		}
		return sbuf.toString();
	}

}
