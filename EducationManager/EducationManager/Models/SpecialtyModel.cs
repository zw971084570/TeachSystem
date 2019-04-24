using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EducationManager.Models
{
    public class SpecialtyModel
    {

        public int sp_id { get; set; }//专业编号
        public string sp_name { get; set; }//专业名称
        public string sp_remark { get; set; }//备注
        public string dp_name { get; set; }//所属系别
        public string gd_name { get; set; }//所属班级
    }
}