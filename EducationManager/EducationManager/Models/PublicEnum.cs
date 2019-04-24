﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EducationManager.Models
{
    public class PublicEnum
    {
        /// <summary>
        /// 院系类别
        /// </summary>
        public enum departType
        {
            文科=1,
            理科=2
        }        
        /// <summary>
        /// 年级名称
        /// </summary>
        public enum gradeName
        {
            大一=1,
            大二=2,
            大三 = 3,
            大四 = 4,
        }
        /// <summary>
        /// 学期名称
        /// </summary>
        public enum semesterName
        {
            第一学期 = 1,
            第二学期 = 2,
            第三学期 = 3,
            第四学期 = 4,
            第五学期 = 5,
            第六学期 = 6,
            第七学期 = 7,
            第八学期 = 8
        }
        /// <summary>
        /// 性别
        /// </summary>
        public enum sex
        {
            男 = 1,
            女 = 2
        }
        /// <summary>
        /// 学历
        /// </summary>
        public enum education
        {
            中专=1,
            大专=2,
            本科=3,
            研究生=4,
            硕士=5
        }
        /// <summary>
        /// 政治面貌
        /// </summary>
        public enum politicalOutlook
        {
            无党派人士=1,
            团员 = 2,
            预备党员 = 3,
            党员 = 4,
        }
        /// <summary>
        /// 角色
        /// </summary>
        public enum role
        {
            系统管理员=1,
            普通教师=2
        }
        /// <summary>
        /// 职称
        /// </summary>
        public enum title
        {
            教授=1,
            副教授=2,
            讲师=3,
            助教=4,
            辅导员=5,
            班主任=6
        }
        /// <summary>
        /// 民族
        /// </summary>
        public enum nation
        {
            汉族=1,
            蒙古族=2,
            回族=3,
            藏族=4,
            维吾尔族=5,
            苗族=6,
            彝族=7,
            壮族=8,
            布依族=9,
            朝鲜族=10,
            满族=11,
            侗族=12,
            瑶族=13,
            白族=14,
            土家族=15,
            哈尼族=16,
            哈萨克族=17,
            傣族=18,
            黎族=19,
            僳僳族=20,
            佤族=21,
            畲族=22,
            高山族=23,
            拉祜族=24,
            水族=25,
            东乡族=26,
            纳西族=27,
            景颇族=28,
            柯尔克孜族=29,
            土族=30,
            达斡尔族=31,
            仫佬族=32,
            羌族=33,
            布朗族=34,
            撒拉族=35,
            毛南族=36,
            仡佬族=37,
            锡伯族=38,
            阿昌族=39,
            普米族=40,
            塔吉克族=41,
            怒族=42,
            乌孜别克族=43,
            俄罗斯族=44,
            鄂温克族=45,
            德昂族=46,
            保安族=47,
            裕固族=48,
            京族=49,
            塔塔尔族=50,
            独龙族=51,
            鄂伦春族=52,
            赫哲族=53,
            门巴族=54,
            珞巴族=55,
            基诺族=56
        }
        /// <summary>
        /// 角色
        /// </summary>
        public enum roles
        {
            管理员=1,
            普通教师=2,
            学生=3
        }
    }
}