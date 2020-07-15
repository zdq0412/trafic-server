package com.jxqixin.trafic.controller;

import com.jxqixin.trafic.constant.Result;
import com.jxqixin.trafic.dto.EmployeeDto;
import com.jxqixin.trafic.dto.NameDto;
import com.jxqixin.trafic.model.Employee;
import com.jxqixin.trafic.model.JsonResult;
import com.jxqixin.trafic.model.User;
import com.jxqixin.trafic.service.IEmployeeService;
import com.jxqixin.trafic.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * 企业员工控制器
 */
@RestController
public class EmployeeController extends CommonController{
    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private IUserService userService;
    /**
     * 查询所有企业员工
     * @return
     */
    @GetMapping("/employee/employees")
    public JsonResult<List<Employee>> queryAllEmployee(){
        List<Employee> list = employeeService.findAll();
        return new JsonResult<>(Result.SUCCESS,list);
    }
    /**
     * 分页查询企业员工
     * @param nameDto
     * @return
     */
    @GetMapping("/employee/employeesByPage")
    public ModelMap queryEmployees(NameDto nameDto){
        Page page = employeeService.findEmployees(nameDto);
        return pageModelMap(page);
    }
    /**
     * 新增企业员工
     * @param employeeDto
     * @return
     */
    @PostMapping("/employee/addEmployee")
    public JsonResult addEmployee(EmployeeDto employeeDto, @RequestParam("file") MultipartFile file, HttpServletRequest request){
        User user = userService.queryUserByUsername(getCurrentUsername(request));
        String urlMapping = "";
        Result result = Result.SUCCESS;
        try {
            String dir = (user.getOrg()==null?"":(user.getOrg().getName()+"/")) + "photo";
            File savedFile = upload(dir,file);
            if(savedFile!=null) {
                urlMapping = getUrlMapping().substring(1).replace("*", "") + dir + "/" + savedFile.getName();
            }
            employeeDto.setPhoto(urlMapping);
            employeeDto.setRealPath(savedFile.getAbsolutePath());
            employeeService.addEmployee(employeeDto,user.getOrg());
        } catch (RuntimeException | IOException e) {
            e.printStackTrace();
            result = Result.FAIL;
            result.setMessage(e.getMessage());
        }
        return new JsonResult(result,urlMapping);
    }
    /**
     * 新增企业员工，不上传头像
     * @param employeeDto
     * @return
     */
    @PostMapping("/employee/addEmployeeNoPhoto")
    public JsonResult addEmployeeNoPhoto(EmployeeDto employeeDto, HttpServletRequest request){
        User user = userService.queryUserByUsername(getCurrentUsername(request));
        Result result = Result.SUCCESS;
        try {
            employeeService.addEmployee(employeeDto,user.getOrg());
        } catch (RuntimeException e) {
            e.printStackTrace();
            result = Result.FAIL;
            result.setMessage(e.getMessage());
        }
        return new JsonResult(result);
    }
    /**
     * 编辑企业员工
     * @param employeeDto
     * @return
     */
    @PostMapping("/employee/updateEmployee")
    public JsonResult updateEmployee(EmployeeDto employeeDto, @RequestParam("file") MultipartFile file, HttpServletRequest request){
        User user = userService.queryUserByUsername(getCurrentUsername(request));
        String urlMapping = "";
        Result result = Result.SUCCESS;
        try {
            String dir = (user.getOrg()==null?"":(user.getOrg().getName()+"/")) + "photo";
            File savedFile = upload(dir,file);
            if(savedFile!=null) {
                urlMapping = getUrlMapping().substring(1).replace("*", "") + dir + "/" + savedFile.getName();
            }
            employeeDto.setPhoto(urlMapping);
            employeeDto.setRealPath(savedFile.getAbsolutePath());
            employeeService.updateEmployee(employeeDto);
        } catch (RuntimeException | IOException e) {
            e.printStackTrace();
            result = Result.FAIL;
            result.setMessage(e.getMessage());
        }
        return new JsonResult(result);
    }
    /**
     * 编辑企业员工,不修改头像
     * @param employeeDto
     * @return
     */
    @PostMapping("/employee/updateEmployeeNoPhoto")
    public JsonResult updateEmployeeNoPhoto(EmployeeDto employeeDto, HttpServletRequest request){
        User user = userService.queryUserByUsername(getCurrentUsername(request));
        Result result = Result.SUCCESS;
        try {
            employeeService.updateEmployee(employeeDto);
        } catch (RuntimeException  e) {
            e.printStackTrace();
            result = Result.FAIL;
            result.setMessage(e.getMessage());
        }
        return new JsonResult(result);
    }
    /**
     * 根据ID删除企业员工
     * @param id
     * @return
     */
    @DeleteMapping("/employee/employee/{id}")
    public JsonResult deleteById(@PathVariable(name="id") String id){
        employeeService.deleteEmployee(id);
        return new JsonResult(Result.SUCCESS);
    }
}