using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EducationManager.Models
{
    public class ScoreModel
    {
        public int cl_id { get; set; }//班级编号
        public string cl_name { get; set; }//班级名称
        public int sp_id { get; set; }//专业编号
        public string sp_name { get; set; }//专业名称
        public int cs_id { get; set; }//课程编号
        public string cs_name { get; set; }//课程名称
        public int stu_num { get; set; }//学生编号
        public string stu_name { get; set; }//学生姓名
        public int th_id { get; set; }//教师编号
        public string th_name { get; set; }//教师姓名
        public string IsInput { get; set; }//是否已录入完毕

    }
}