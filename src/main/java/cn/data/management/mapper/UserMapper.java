package cn.data.management.mapper;

import java.util.List;

import com.github.abel533.mapper.Mapper;

import cn.data.management.entity.User;

public interface UserMapper extends Mapper<User> {

	List<String> queryDistintTeamNames();

}
