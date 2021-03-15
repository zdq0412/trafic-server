package com.jxqixin.trafic.controller;
import com.jxqixin.trafic.constant.Result;
import com.jxqixin.trafic.dto.UploadFileDto;
import com.jxqixin.trafic.model.*;
import com.jxqixin.trafic.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.thymeleaf.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;

/**
 * 文件上传控制器
 */
@RestController
public class UploadController extends CommonController {
    @Autowired
    private IUserService userService;
    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private IResumeService resumeService;
    @Autowired
    private IIDCardService idCardService;
    @Autowired
    private IContractService contractService;
    @Autowired
    private IQualificationDocumentService qualificationDocumentService;
    @Autowired
    private IJobHistoryService jobHistoryService;
    @Autowired
    private IInductionTrainingService inductionTrainingService;
    @Autowired
    private ISafetyResponsibilityAgreementService safetyResponsibilityAgreementService;
    @Autowired
    private ITrainingExamineService trainingExamineService;
    @Autowired
    private IOtherDocumentService otherDocumentService;
    @Autowired
    private ISafetyProductionCostPlanDetailService safetyProductionCostPlanDetailService;
    @Autowired
    private IDeviceService deviceService;
    @Autowired
    private IDeviceMaintainService deviceMaintainService;
    @Autowired
    private IEmergencyPlanBakService emergencyPlanBakService;
    @Autowired
    private IPreplanDrillRecordService preplanDrillRecordService;
    @Autowired
    private IDeviceArchiveService deviceArchiveService;
    /**
     * 上传人员档案
     * @return
     */
    @PostMapping("/employeeDocumentUpload")
    public JsonResult employeeDocumentUpload(@RequestParam("file") MultipartFile file, UploadFileDto uploadFileDto, HttpServletRequest request){
        Result result = Result.SUCCESS;
        String urlMapping = "";
        commonUpload(request,uploadFileDto,file,result,urlMapping);
        return new JsonResult(result,urlMapping);
    }
    /**
     * 上传应急预案备案文件
     * @return
     */
    @PostMapping("/emergencyPlanBakUpload")
    public JsonResult emergencyPlanBakUpload(@RequestParam("file") MultipartFile file, UploadFileDto uploadFileDto, HttpServletRequest request){
        Result result = Result.SUCCESS;
        String urlMapping = "";
        commonUpload(request,uploadFileDto,file,result,urlMapping);
        return new JsonResult(result,urlMapping);
    }

    private void commonUpload(HttpServletRequest request,UploadFileDto uploadFileDto, MultipartFile file ,Result result,String urlMapping){
        User user = userService.queryUserByUsername(getCurrentUsername(request));
        try {
            String dir = (user.getOrg()==null?"":(user.getOrg().getName()+"/")) + uploadFileDto.getType();
            File savedFile = upload(dir, file);
            if (savedFile != null) {
                urlMapping = getUrlMapping().substring(1).replace("*", "") + dir + "/" + savedFile.getName();
            }
            updateUrlAndRealPath(urlMapping,savedFile.getAbsolutePath(),uploadFileDto);
        } catch (RuntimeException | IOException e) {
            e.printStackTrace();
            result = Result.FAIL;
            result.setMessage(e.getMessage());
        }
    }

    /**
     * 上传安全投入台账
     * @return
     */
    @PostMapping("/safetyAccountUpload")
    public JsonResult safetyAccountUpload(@RequestParam("file") MultipartFile file, UploadFileDto uploadFileDto, HttpServletRequest request){
        User user = userService.queryUserByUsername(getCurrentUsername(request));
        String urlMapping = "";
        Result result = Result.SUCCESS;
        try {
            String dir = (user.getOrg()==null?"":(user.getOrg().getName()+"/")) + "safetyAccount";
            File savedFile = upload(dir, file);
            if (savedFile != null) {
                urlMapping = getUrlMapping().substring(1).replace("*", "") + dir + "/" + savedFile.getName();
            }

            SafetyProductionCostPlanDetail  detail = safetyProductionCostPlanDetailService.queryObjById(uploadFileDto.getId());
            if(!StringUtils.isEmpty(detail.getRealPath())){
                deleteTemplateFile(detail.getRealPath());
            }
            detail.setUrl(urlMapping);
            detail.setRealPath(savedFile.getAbsolutePath());

            safetyProductionCostPlanDetailService.updateObj(detail);
        } catch (RuntimeException | IOException e) {
            e.printStackTrace();
            result = Result.FAIL;
            result.setMessage(e.getMessage());
        }
        return new JsonResult(result,urlMapping);
    }
    /**
     * 更新模板的访问路径和真实存储路径
     */
    private void updateUrlAndRealPath(String url,String realPath,UploadFileDto uploadFileDto){
        switch (uploadFileDto.getType()){
            case "archive":{
                Employee employee = employeeService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(employee.getArchivesRealPath())){
                    deleteTemplateFile(employee.getArchivesRealPath());
                }
                employee.setArchives(url);
                employee.setArchivesRealPath(realPath);
                employeeService.updateObj(employee);
                break;
            }
            case "resume":{
                Resume resume = resumeService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(resume.getRealPath())){
                    deleteTemplateFile(resume.getRealPath());
                }
                resume.setUrl(url);
                resume.setRealPath(realPath);
                resumeService.updateObj(resume);
                break;
            }
            case "idcard":{
               IDCard idCard = idCardService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(idCard.getRealPath())){
                    deleteTemplateFile(idCard.getRealPath());
                }
                idCard.setUrl(url);
                idCard.setRealPath(realPath);
                idCardService.updateObj(idCard);
                break;
            }
            case "contract":{
                Contract contract = contractService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(contract.getRealPath())){
                    deleteTemplateFile(contract.getRealPath());
                }
                contract.setUrl(url);
                contract.setRealPath(realPath);
                contractService.updateObj(contract);
                break;
            }
            case "qualificationDocument":{
                QualificationDocument qualificationDocument = qualificationDocumentService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(qualificationDocument.getRealPath())){
                    deleteTemplateFile(qualificationDocument.getRealPath());
                }
                qualificationDocument.setUrl(url);
                qualificationDocument.setRealPath(realPath);
                qualificationDocumentService.updateObj(qualificationDocument);
                break;
            }
            case "jobHistory":{
                JobHistory jobHistory = jobHistoryService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(jobHistory.getRealPath())){
                    deleteTemplateFile(jobHistory.getRealPath());
                }
                jobHistory.setUrl(url);
                jobHistory.setRealPath(realPath);
                jobHistoryService.updateObj(jobHistory);
                break;
            }
            case "inductionTraining":{
                InductionTraining inductionTraining = inductionTrainingService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(inductionTraining.getRealPath())){
                    deleteTemplateFile(inductionTraining.getRealPath());
                }
                inductionTraining.setUrl(url);
                inductionTraining.setRealPath(realPath);
                inductionTrainingService.updateObj(inductionTraining);
                break;
            }
            case "safetyResponsibilityAgreement":{
                SafetyResponsibilityAgreement safetyResponsibilityAgreement = safetyResponsibilityAgreementService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(safetyResponsibilityAgreement.getRealPath())){
                    deleteTemplateFile(safetyResponsibilityAgreement.getRealPath());
                }
                safetyResponsibilityAgreement.setUrl(url);
                safetyResponsibilityAgreement.setRealPath(realPath);
                safetyResponsibilityAgreementService.updateObj(safetyResponsibilityAgreement);
                break;
            }
            case "trainingExamine":{
                TrainingExamine trainingExamine = trainingExamineService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(trainingExamine.getRealPath())){
                    deleteTemplateFile(trainingExamine.getRealPath());
                }
                trainingExamine.setUrl(url);
                trainingExamine.setRealPath(realPath);
                trainingExamineService.updateObj(trainingExamine);
                break;
            }
            case "otherDocument":{
                OtherDocument otherDocument = otherDocumentService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(otherDocument.getRealPath())){
                    deleteTemplateFile(otherDocument.getRealPath());
                }
                otherDocument.setUrl(url);
                otherDocument.setRealPath(realPath);
                otherDocumentService.updateObj(otherDocument);
                break;
            }
            //上传设备文件
            case "device":{
                Device device = deviceService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(device.getRealPath())){
                    deleteTemplateFile(device.getRealPath());
                }
                device.setUrl(url);
                device.setRealPath(realPath);
                deviceService.updateObj(device);
                break;
            }
            //上传设备保养维修检修文件
            case "deviceMaintain":{
                DeviceMaintain deviceMaintain = deviceMaintainService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(deviceMaintain.getRealPath())){
                    deleteTemplateFile(deviceMaintain.getRealPath());
                }
                deviceMaintain.setUrl(url);
                deviceMaintain.setRealPath(realPath);
                deviceMaintainService.updateObj(deviceMaintain);
                break;
            }
            //上传设备档案文件
            case "deviceArchive":{
                DeviceArchive deviceArchive = deviceArchiveService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(deviceArchive.getRealPath())){
                    deleteTemplateFile(deviceArchive.getRealPath());
                }
                deviceArchive.setUrl(url);
                deviceArchive.setRealPath(realPath);
                deviceArchiveService.updateObj(deviceArchive);
                break;
            }
            //应急预案文件
            case "emergencyPlanBak":{
                EmergencyPlanBak emergencyPlanBak = emergencyPlanBakService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(emergencyPlanBak.getPrePlanRealPath())){
                    deleteTemplateFile(emergencyPlanBak.getPrePlanRealPath());
                }
                emergencyPlanBak.setPrePlanUrl(url);
                emergencyPlanBak.setPrePlanRealPath(realPath);
                emergencyPlanBak.setPrePlanUploadDate(new Date());
                emergencyPlanBakService.updateObj(emergencyPlanBak);
                break;
            }
            //应急备案文件
            case "planBak":{
                EmergencyPlanBak emergencyPlanBak = emergencyPlanBakService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(emergencyPlanBak.getKeepOnRecordRealPath())){
                    deleteTemplateFile(emergencyPlanBak.getKeepOnRecordRealPath());
                }
                emergencyPlanBak.setKeepOnRecordUrl(url);
                emergencyPlanBak.setKeepOnRecordRealPath(realPath);
                emergencyPlanBak.setKeepOnRecordUploadDate(new Date());
                emergencyPlanBakService.updateObj(emergencyPlanBak);
                break;
            }
            //应急预案演练文件
            case "preplanDrillRecord":{
                PreplanDrillRecord preplanDrillRecord = preplanDrillRecordService.queryObjById(uploadFileDto.getId());
                if(!StringUtils.isEmpty(preplanDrillRecord.getRealPath())){
                    deleteTemplateFile(preplanDrillRecord.getRealPath());
                }
                preplanDrillRecord.setUrl(url);
                preplanDrillRecord.setRealPath(realPath);
                preplanDrillRecordService.updateObj(preplanDrillRecord);
                break;
            }
        }
    }
    /**
     * 删除已存在的模板文件
     * @param realPath
     */
    private void deleteTemplateFile(String realPath) {
        File file = new File(realPath);
        if(file.exists()){
            file.delete();
        }
    }
}
