using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace EducationManager.Models
{
    /// <summary>
    /// 学生登陆信息
    /// </summary>
    public class stuLoginModel
    {
        // 学生学号    
        [DisplayName("学号")]//在视图中显示的字段名称
        [Required(ErrorMessage = "学号不能为空")]//验证用户名是否放为空
        public int stu_num { get; set; }

        // 学生登陆密码       
        [DisplayName("密码")]//在视图中显示的字段名称
        [Required(ErrorMessage = "密码不能为空")]//验证用户名是否放为空
        public string stu_password { get; set; }
    }
    /// <summary>
    /// 教师登陆信息
    /// </summary>
    public class teacherLoginModel
    {
        //角色
        [DisplayName("角色")]//在视图中显示的字段名称
        public string th_role { get; set; }

        // 教师编号        
        [DisplayName("账号")]//在视图中显示的字段名称
        [Required(ErrorMessage = "账号不能为空")]//验证用户名是否放为空
        public int th_id { get; set; }

        // 教师登陆密码
        [DisplayName("密码")]//在视图中显示的字段名称
        [Required(ErrorMessage = "密码不能为空")]//验证用户名是否放为空
        public string th_password { get; set; }
    }
}