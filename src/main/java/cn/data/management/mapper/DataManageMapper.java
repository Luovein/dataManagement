package cn.data.management.mapper;

import java.util.List;
import java.util.Map;

import com.github.abel533.mapper.Mapper;

import cn.data.management.entity.DataManage;

public interface DataManageMapper extends Mapper<DataManage> {

	List<DataManage> queryListByTypeAndContext(Map<String, Object> map);

}
