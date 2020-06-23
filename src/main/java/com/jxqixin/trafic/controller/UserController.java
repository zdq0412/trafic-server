package com.jxqixin.trafic.controller;

import com.jxqixin.trafic.constant.RedisConstant;
import com.jxqixin.trafic.constant.Result;
import com.jxqixin.trafic.dto.UserDto;
import com.jxqixin.trafic.model.JsonResult;
import com.jxqixin.trafic.model.User;
import com.jxqixin.trafic.service.IUserService;
import com.jxqixin.trafic.util.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
/**
 * 用户管理
 */
@RestController
@RequestMapping("user")
public class UserController extends CommonController{
    @Autowired
    private IUserService userService;
    @Value("${defaultPassword}")
    private String defaultPassword;
    @Autowired
    private RedisUtil redisUtil;
    /**
     * 修改密码
     * @param oldPassword
     * @param newPassword
     * @param username
     * @return
     */
    @PostMapping("modifyPassword")
    public JsonResult modifyPassword(String oldPassword, String newPassword, String username){
        User user = userService.queryUserByUsername(username);
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        if(!passwordEncoder.matches(oldPassword,user.getPassword())){
            Result result = Result.FAIL;
            result.setMessage("原密码错误!");
            return new JsonResult(Result.FAIL);
        }
        user.setPassword(passwordEncoder.encode(newPassword));
        userService.updateObj(user);
        return new JsonResult(Result.SUCCESS);
    }

  /*  *//**
     * 用户登录
     * @param username
     * @param password
     * @return
     *//*
    @PostMapping("login")
    public JsonResult login(String username,String password){
        User user = userService.login(username,password);
        if(user == null){
            return new JsonResult(false,"");
        }
        String token = redisUtil.generateToken();
        redisUtil.setExpire(token,username, RedisConstant.EXPIRE_MINUTES);
        return new JsonResult(true,"登录成功!",token);
    }*/
    /**
     * 根据条件查找用户信息
     * @param userDto
     * @return
     */
    @GetMapping("queryUsers")
    public ModelMap queryUsers(UserDto userDto) {
        Page<User> page = userService.findByPage(userDto);
        return pageModelMap(page);
    }
    /**
     * 根据条件查找用户信息
     * @return
     */
    @GetMapping("showUsers")
    public ModelMap showUsers(UserDto userDto) {
        Page<User> page = userService.findByPageWithoutAdmin(userDto);
        return pageModelMap(page);
    }
    /**
     * 批量删除
     * @param ids
     * @return
     */
    @RequestMapping("deleteByIds")
    public ModelMap deleteByIds(String ids){
        if(StringUtils.isEmpty(ids)){
            return failureModelMap("没有要删除的用户!");
        }
        ids = StringUtils.delete(ids,"]");
        ids = StringUtils.delete(ids,"[");
        ids = StringUtils.delete(ids,"\"");
        if(StringUtils.isEmpty(ids)){
            return failureModelMap("没有要删除的用户!");
        }
        try {
            userService.deleteBatch(ids.split(","));
        }catch (RuntimeException e){
            failureModelMap(e.getMessage());
        }
        return successModelMap("删除成功!");
    }
    /**
     * 根据id删除简历
     * @param id
     * @return
     */
    @GetMapping("deleteById/{id}")
    public ModelMap deleteById(@PathVariable String id) {
        try {
            userService.deleteById(id);
        }catch (RuntimeException e){
            return failureModelMap(e.getMessage());
        }
        return successModelMap("删除成功!");
    }
    /**
     * 验证用户名是否可用
     * @param username
     * @return
     */
    @GetMapping("checkUsername/{username}")
    public ModelMap checkUsername(@PathVariable String username){
        User user = userService.queryUserByUsername(username);
        if(user!=null){
            return failureModelMap("");
        }else{
            return successModelMap("");
        }
    }
    /**
     * 添加用户
     * @param user
     * @return
     */
    @GetMapping("addUser")
    public ModelMap addUser(User user){
        User u = userService.queryUserByUsername(user.getUsername());
        if(u!=null){
            return failureModelMap("用户添加失败: "+ user.getUsername()+"已被使用!");
        }
        user.setPassword(new BCryptPasswordEncoder().encode(defaultPassword));
        user.setCreateDate(new Date());
        userService.addObj(user);
        return successModelMap("新增用户成功!");
    }
    /**
     * 修改用户
     * @param user
     * @return
     */
    @GetMapping("modifyUser")
    public ModelMap modifyUser(User user){
        User u = userService.queryUserByUsername(user.getUsername());
        u.setRealname(user.getRealname());
        u.setTel(user.getTel());
        u.setNote(user.getNote());
        u.setRole(user.getRole());
        userService.addObj(u);
        return successModelMap("修改用户成功!");
    }
    /**
     * 根据用户名查找
     * @param username
     * @return
     */
    @RequestMapping("queryByUsername/{username}")
    public User queryByUsername(@PathVariable String username){
        return userService.queryUserByUsername(username);
    }
    /**
     * 密码重置
     * @return
     */
    @GetMapping("resetPassword")
    public ModelMap resetPassword(String id){
        User user = userService.queryObjById(id);
        user.setPassword(new BCryptPasswordEncoder().encode(defaultPassword));
        userService.updateObj(user);
        return successModelMap("");
    }
}
