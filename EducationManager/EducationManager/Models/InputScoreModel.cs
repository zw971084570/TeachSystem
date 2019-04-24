using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EducationManager.Models
{
    public class InputScoreModel
    {
        public int stu_num { get; set; }//学号
        public string stu_name { get; set; }//姓名
        public int cs_id { get; set; }//课程编号
        public string cs_name { get; set; }//课程编号
        public int sc_usuallyScore { get; set; }//平时成绩
        public int sc_endScore { get; set; }//期末成绩
        public int sc_sumScore{ get; set; }//总成绩
        public int sc_remark { get; set; }//注释
        public int sc_poportion { get; set; }//期末成绩所占百分比
    }
}