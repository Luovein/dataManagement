package cn.data.management.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.mapper.Mapper;

import cn.data.management.entity.DataManage;
import cn.data.management.mapper.DataManageMapper;

@Service
public class DataManageService extends BaseService<DataManage> {

	@Autowired
	private DataManageMapper dataManageMapper;

	@Override
	public Mapper<DataManage> getMapper() {
		return dataManageMapper;
	}

	public List<DataManage> queryListByTypeAndContext(String serchType, String serchContext) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("serchType", serchType);
		map.put("serchContext", serchContext);
		return dataManageMapper.queryListByTypeAndContext(map);
	}

}
