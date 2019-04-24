using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;

namespace EducationManager.Controllers
{
    public class scoreController : Controller
    {


        // GET: /score/
        /// <summary>
        /// 教师录入成绩首页（显示院系、专业、班级、课程、教师）
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<teacher> list = (from a in db.teacher where a.th_id ==Convert.ToInt32(Session["id"]) select a).ToList();
            //获取教师所带的班级编号
            string str = list.First().th_classes;
            string[] strs = str.Split(',');
            //循环遍历教师教的所有班级信息
            classes cl = new classes();//定义一个班级对象
            List<ScoreModel> sclist = new List<ScoreModel>();
            foreach (var item in strs)
            {

                //查询班级信息
                cl = (from a in db.classes where a.cl_id == Convert.ToInt32(item) select a).First();
                string spcsid = cl.specialty.sp_csids;
                string[] spcsids = spcsid.Split(',');
                foreach (string sd in spcsids)
                {
                    //查找专业对应的课程
                    course cs = (from a in db.course where a.cs_id == Convert.ToInt32(sd) select a).First();
                    ScoreModel sc = new ScoreModel();
                    sc.cl_id = cl.cl_id;//将班级编号追加到新的实体类中
                    sc.cl_name = cl.cl_name;//班级名称
                    sc.sp_id = cl.specialty.sp_id;//专业编号
                    sc.sp_name = cl.specialty.sp_name;//专业名称
                    sc.cs_id = cs.cs_id;
                    sc.cs_name = cs.cs_name;
                     List<score> slist = (from a in db.score where a.student.stu_clid == Convert.ToInt32(item) && a.sc_csid == Convert.ToInt32(sd) select a).ToList();
                     if (slist.Count() > 0)
                     {
                         sc.IsInput = "录入完毕";
                     }
                     else
                     {
                         sc.IsInput = "未完成录入";
                     }                    
                    sclist.Add(sc);//将sc的信息追加到list集合中
                }
            }
            ViewData["sc"] = sclist;
            return View(list);
        }
        /// <summary>
        /// 搜索查询
        /// </summary>
        /// <param name="stunum">学号</param>
        /// <param name="csname">课程名称</param>
        /// <returns></returns>
        public ActionResult SearchInfo(string csname)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            if (csname == null)
            {
                csname = "";
            }
            List<score> list = (from a in db.score where a.sc_stuNum == Convert.ToInt32(Session["id"]) && a.course.cs_name.Contains(csname.Trim()) select a).ToList();
            string contentstr = "<table class='table table-hover'> <caption>查看成绩</caption> <tr><th>课程编号</th><th>学号</th><th>姓名</th><th>专业</th><th>总成绩</th><th>是否挂科</th></tr>";
                if (list.Count() <= 0)
                {
                    contentstr += "<td colspan='6' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
                }
                foreach (score item in list)
                {
                    string states="是";
                    if(item.sc_sumScore<60)
                    {
                        states="否";
                    }
                    contentstr += "<tr><td>" + item.sc_id + "</td><td>" + item.sc_stuNum + "</td><td>" + item.student.stu_name + "</td><td>" + item.course.cs_name + "</td><td>" + item.sc_sumScore + "</td><td>" + states+ "</td>";
                }
                contentstr += "</table>";
                return Content(contentstr);            
        }
        /// <summary>
        /// 搜索查询
        /// </summary>
        /// <param name="stunum">学号</param>
        /// <param name="csname">课程名称</param>
        /// <returns></returns>
        public ActionResult ASearchInfo(string stunum, string csname)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            if (stunum == null)
            {
                stunum = "";
            }
            if (csname == null)
            {
                csname = "";
            }
            List<score>  list = (from a in db.score where a.sc_stuNum.ToString().Contains(stunum.Trim()) && a.course.cs_name.Contains(csname.Trim()) select a).ToList();
            string contentstr = "<table class='table table-hover'> <caption>学生成绩</caption> <tr> <th class='hidden-xs'>成绩编号</th><th>学号</th><th>姓名</th><th>专业</th><th class='hidden-xs'>平时成绩</th><th class='hidden-xs'>期末成绩</th><th class='hidden-xs'>期末成绩所占百分比</th><th>总分</th><th class='hidden-xs'>备注</th></tr>";
            if (list.Count() <= 0)
            {
                contentstr += "<td colspan='9' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
            }
            foreach (score item in list)
            {
                string states = "是";
                if (item.sc_sumScore < 60)
                {
                    states = "否";
                }
                contentstr += "<tr><td class='hidden-xs'>" + item.sc_id + "</td><td>" + item.sc_stuNum + "</td><td>" + item.student.stu_name + "</td><td>" + item.course.cs_name + "</td><td class='hidden-xs'>" + item.sc_usuallyScore + "</td><td class='hidden-xs'>" + item.sc_endScore + "</td><td class='hidden-xs'>" + item.sc_poportion + "</td><td>" + item.sc_sumScore + "</td><td class='hidden-xs'>" + item.sc_remark + "</td>";
            }
            contentstr += "</table>";
            return Content(contentstr);
        }
        /// <summary>
        /// 查看分数详情
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Detail(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            score list = (from a in db.score where a.sc_id == id select a).First();
            return View(list);
        }
        /// <summary>
        /// 查看分数
        /// </summary>
        /// <returns></returns>
        public ActionResult ScoreList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<score> list = new List<score>();
            if (Session["role"].ToString() == "1")
            {
                return RedirectToAction("AdminScore");
            }
            else if (Session["role"].ToString() == "2")
            {
                return RedirectToAction("TeacherScore");
            }
            else if (Session["role"].ToString() == "3")
            {
                return RedirectToAction("StuScore");
            }
            return View(list);
        }
        /// <summary>
        /// 管理员查看列表
        /// </summary>
        /// <returns></returns>
        public ActionResult AdminScore()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<score> list = new List<score>();
            list = (from a in db.score select a).ToList();
            return View(list);
        }
        /// <summary>
        /// 教师查看成绩列表
        /// </summary>
        /// <returns></returns>
        public ActionResult TeacherScore()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<teacher> list = (from a in db.teacher where a.th_id == Convert.ToInt32(Session["id"]) select a).ToList();
            //获取教师所带的班级编号
            string str = list.First().th_classes;
            string[] strs = str.Split(',');
            //循环遍历教师教的所有班级信息
            classes cl = new classes();//定义一个班级对象
            List<ScoreModel> sclist = new List<ScoreModel>();
            foreach (var item in strs)
            {
                //查询班级信息
                cl = (from a in db.classes where a.cl_id == Convert.ToInt32(item) select a).First();
                string spcsid = cl.specialty.sp_csids;
                string[] spcsids = spcsid.Split(',');
                foreach (string sd in spcsids)
                {
                    //查找专业对应的课程
                    course cs = (from a in db.course where a.cs_id == Convert.ToInt32(sd) select a).First();
                    List<score> slist = (from a in db.score where a.student.stu_clid == Convert.ToInt32(item) && a.sc_csid == Convert.ToInt32(sd) select a).ToList();
                    if (slist.Count()>0)
                    {
                        ScoreModel sc = new ScoreModel();
                        sc.cl_id = cl.cl_id;//将班级编号追加到新的实体类中
                        sc.cl_name = cl.cl_name;//班级名称
                        sc.sp_id = cl.specialty.sp_id;//专业编号
                        sc.sp_name = cl.specialty.sp_name;//专业名称
                        sc.cs_id = cs.cs_id;
                        sc.cs_name = cs.cs_name;
                        sclist.Add(sc);//将sc的信息追加到list集合中
                    }
                }
            }
            ViewData["sc"] = sclist;
            return View(list);
        }
        public ActionResult TeacherScoreInfo(int id, int cid)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<student> list = (from a in db.student where a.stu_clid == id select a).ToList();
            List<score> listsc =new List<score>();
            foreach (student item in list)
            {
                List<score> sclist=(from a in db.score where a.sc_stuNum==item.stu_num && a.sc_csid==cid select a).ToList();
                if (sclist.Count()>0)
                {
                    listsc.Add(sclist.First());
                }
            }
            return View(listsc);
        }
        /// <summary>
        /// 学生查看成绩列表
        /// </summary>
        /// <returns></returns>
        public ActionResult StuScore()
        {
            if (Session["id"] == null)
            {   
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<score> list = new List<score>();
            list = (from a in db.score where a.sc_stuNum == Convert.ToInt32(Session["id"]) select a).ToList();
            return View(list);
        }


        public ActionResult InputInfo(int id, int cid)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<student> list = (from a in db.student where a.stu_clid == id select a).ToList();
            List<InputScoreModel> ismlist = new List<InputScoreModel>();
            foreach (student item in list)
            {
                InputScoreModel ism = new InputScoreModel();
                ism.cs_id = cid;
                ism.stu_num = item.stu_num;
                ism.stu_name = item.stu_name;
                course cs = (from a in db.course where a.cs_id == cid select a).First();
                ism.cs_name = cs.cs_name;
                ismlist.Add(ism);
            }
            ViewData["ism"] = ismlist;
            return View();
        }
        [HttpPost]
        public ActionResult InputInfo(FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                string[] sc_stuNum = collection["stu_num"].Split(',');//学号
                string[] sc_csid = collection["cs_id"].Split(',');//学号
                string[] sc_usuallyScore = collection["sc_usuallyScore"].Split(',');//平时成绩                
                string[] sc_endScore = collection["sc_endScore"].Split(',');//期末成绩
                string sc_poportion = collection["sc_poportion"];//期末成绩所占百分比
                string[] sc_sumScore = collection["sc_sumScore"].Split(',');//总成绩                            
                string[] sc_remark = collection["sc_remark"].Split(',');//学号                
                DBDataContext db = new DBDataContext();
                for (int i = 0; i < sc_stuNum.Count(); i++)
                {
                    score sc = new score();
                    sc.sc_stuNum = Convert.ToInt32(sc_stuNum[i]);
                    sc.sc_csid = Convert.ToInt32(sc_csid[i]);
                    sc.sc_usuallyScore = Convert.ToInt32(sc_usuallyScore[i]);
                    sc.sc_endScore = Convert.ToInt32(sc_endScore[i]);
                    sc.sc_poportion = Convert.ToInt32(sc_poportion);
                    sc.sc_sumScore = Convert.ToInt32(sc_sumScore[i]);
                    sc.sc_remark = sc_remark[i];
                    db.score.InsertOnSubmit(sc);
                    db.SubmitChanges();
                }
                return RedirectToAction("Index");
            }
            catch
            {
                return RedirectToAction("Index");
            }
        }
        //
        // GET: /score/Delete/5

        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            score sc = (from a in db.score where a.sc_id == id select a).First();
            return View(sc);
        }

        //
        // POST: /score/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add delete logic here
                using (DBDataContext db = new DBDataContext())
                {
                    score sc = (from a in db.score where a.sc_id == id select a).First();
                    db.score.DeleteOnSubmit(sc);
                    db.SubmitChanges();
                }

                return RedirectToAction("ScoreList");
            }
            catch
            {
                return View();
            }
        }
    }
}
