package cn.data.management.controller;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.data.management.entity.DataManage;
import cn.data.management.entity.User;
import cn.data.management.service.DataManageService;
import cn.data.management.service.UserService;
import cn.data.management.util.MyUtil;

@RequestMapping("login")
@Controller
public class LoginController {

	@Autowired
	private UserService userService;
	@Autowired
	private DataManageService dataManageService;

	@RequestMapping(value = "signin.do")
	public String signin(HttpServletRequest request) {
		/*
		 * HttpSession session = request.getSession(); User loginUser = (User)
		 * session.getAttribute("loginUser");
		 */
		return "index";
	}

	@RequestMapping(value = "login.do")
	public String login(HttpServletRequest request, @RequestParam(value = "username") String username,
			@RequestParam(value = "password") String password, Map<String, Object> map) {
		User user = new User();
		user.setUserName(username);
		user.setPassword(password);
		User loginUser = userService.getUser(user);
		if (loginUser == null) {
			map.put("message", "用户名密码不正确");
			return "index";
		}
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", loginUser);

		List<DataManage> dataList = dataManageService.queryAll();
		map.put("dataList", dataList);
		return "dataList";
	}

	@RequestMapping(value = "manageLogin.do")
	public String manageLogin(HttpServletRequest request, @RequestParam(value = "username") String username,
			@RequestParam(value = "password") String password, Map<String, Object> map) {
		if (StringUtils.isBlank(username) || !"admin".equals(username)) {
			map.put("message", "用户名或密码不正确");
			return "index";
		}
		User user = new User();
		user.setUserName(username);
		user.setPassword(password);
		user.setManageFlag("1");
		User loginUser = userService.getUser(user);
		if (loginUser == null) {
			map.put("message", "用户名或密码不正确");
			return "index";
		}
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", loginUser);
		List<DataManage> dataList = dataManageService.queryAll();
		map.put("dataList", dataList);
		return "dataList";
	}

	@RequestMapping(value = "goRegister.do")
	public String goRegister() {
		return "register";
	}

	@RequestMapping(value = "register.do")
	@ResponseBody
	public String register(User user) throws JsonProcessingException {
		Map<String, Object> resultMap = new HashMap<>();
		System.out.println(user);
		String userName = user.getUserName();
		String password = user.getPassword();
		String teamName = user.getTeamName();
		User queryUser = new User();
		queryUser.setUserName(userName);
		User queryOne = userService.queryOne(queryUser);
		if (StringUtils.isBlank(userName) || StringUtils.isBlank(password) || StringUtils.isBlank(teamName)) {
			resultMap.put("flag", false);
			resultMap.put("message", "填写的资料不完整");
		} else if (queryOne != null) {
			resultMap.put("flag", false);
			resultMap.put("message", "用户已存在");
		} else {
			user.setCreateTime(new Date());
			user.setUpdateTime(new Date());
			user.setManageFlag("0");
			userService.save(user);
			resultMap.put("flag", true);
		}

		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(resultMap);
	}

	@RequestMapping(value = "getTeamNames.do")
	@ResponseBody
	public String getTeamNames() throws JsonProcessingException {
		List<String> list = userService.queryDistintTeamNames();

		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(list);
	}

	@RequestMapping(value = "queryInfo.do")
	@ResponseBody
	public String queryInfo(@RequestParam(value = "id") Long id) throws JsonProcessingException {
		DataManage data = dataManageService.queryById(id);
		data.setViewCount(data.getViewCount() + 1);
		dataManageService.update(data);
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(data);
	}

	@RequestMapping(value = "goManagerLogin.do")
	public String goManagerLogin() {
		return "managerLogin";
	}

	@RequestMapping(value = "goUploadView.do")
	public String goUploadView() {

		return "uploadView";
	}

	@RequestMapping(value = "logout.do")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", null);
		return "index";
	}

	@RequestMapping(value = "goDataList.do")
	public String goDataList(@RequestParam(value = "serchType", required = false) String serchType,
			@RequestParam(value = "serchContext", required = false) String serchContext, Map<String, Object> map) {
		List<DataManage> dataList = null;
		if (StringUtils.isBlank(serchContext)) {
			dataList = dataManageService.queryAll();
		} else {
			dataList = dataManageService.queryListByTypeAndContext(serchType, serchContext);
		}
		map.put("dataList", dataList);
		return "dataList";
	}

	@RequestMapping(value = "goUpdateView.do")
	public String goUpdateView(@RequestParam(value = "id") Long id, Map<String, Object> map) {
		DataManage dataManage = dataManageService.queryById(id);
		map.put("dataManage", dataManage);
		return "updateDataView";
	}

	@RequestMapping(value = "deleteDataInfo.do")
	@ResponseBody
	public String deleteDataInfo(HttpServletRequest request, @RequestParam(value = "id") Long id)
			throws JsonProcessingException {
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		Map<String, Object> map = new HashMap<String, Object>();

		DataManage dataManage = dataManageService.queryById(id);
		if ("1".equals(loginUser.getManageFlag()) || dataManage.getUploadBy().equals(loginUser.getUserName())) {
			dataManageService.deleteById(id);
			map.put("success", true);
			map.put("message", "成功删除");
		} else {
			map.put("success", false);
			map.put("message", "删除失败,用户无权限");
		}
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
	}

	@RequestMapping(value = "updateDataInfo.do")
	public String updateDataInfo(HttpServletRequest request, DataManage dataManage,
			@RequestParam(value = "file", required = false) CommonsMultipartFile file, Map<String, Object> map)
			throws JsonProcessingException {
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		DataManage hisData = dataManageService.queryById(dataManage.getId());
		if ("1".equals(loginUser.getManageFlag()) || dataManage.getUploadBy().equals(loginUser.getUserName())) {

			String path = session.getServletContext().getRealPath("/uploadFile/");
			path = path + System.currentTimeMillis();
			File newFile = new File(path);
			// 通过CommonsMultipartFile的方法直接写文件（注意这个时候）
			try {
				file.transferTo(newFile);
				BeanUtils.copyProperties(hisData, dataManage);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			hisData.setFileName(file.getOriginalFilename());
			hisData.setUrl(path);
			hisData.setCreateTime(new Date());
			hisData.setIp(request.getRemoteAddr());
			hisData.setUploadBy(loginUser.getUserName());
			hisData.setViewCount(0L);
			hisData.setUpdateTime(new Date());
			dataManageService.update(hisData);

			List<DataManage> dataList = dataManageService.queryAll();
			map.put("dataList", dataList);
			return "dataList";
		}
		map.put("id", dataManage.getId());
		return "updateDataView";
	}

	@RequestMapping(value = "createData.do")
	public String createData(HttpServletRequest request,
			@RequestParam(value = "file", required = false) CommonsMultipartFile file, DataManage dataManage,
			Map<String, Object> map) throws IllegalStateException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		String path = session.getServletContext().getRealPath("/uploadFile/");
		path = path + System.currentTimeMillis();
		File newFile = new File(path);
		// 通过CommonsMultipartFile的方法直接写文件（注意这个时候）
		file.transferTo(newFile);

		dataManage.setFileName(file.getOriginalFilename());
		dataManage.setUrl(path);
		dataManage.setCreateTime(new Date());
		dataManage.setIp(request.getRemoteAddr());
		dataManage.setUploadBy(loginUser.getUserName());
		dataManage.setViewCount(0L);
		dataManage.setUpdateTime(new Date());
		dataManageService.save(dataManage);

		List<DataManage> dataList = dataManageService.queryAll();
		map.put("dataList", dataList);
		return "dataList";
	}

	@RequestMapping(value = "download.do")
	public ResponseEntity<byte[]> download(@RequestParam(value = "id") Long id) throws IOException {
		DataManage dataManage = dataManageService.queryById(id);
		File file = new File(dataManage.getUrl());
		return MyUtil.buildResponseEntity(file, dataManage.getFileName());
	}
}
