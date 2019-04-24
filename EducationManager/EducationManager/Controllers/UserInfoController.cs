using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;

namespace EducationManager.Controllers
{
    public class UserInfoController : Controller
    {
        /// <summary>
        /// 教师登陆页面
        /// </summary>
        /// <returns></returns>
        public ActionResult LoginOn()
        {
            DBDataContext db = new DBDataContext();
            
            List<webInfo> list = (from a in db.webInfo select a).ToList();
            ViewData["copys"] = null;
            if (list.Count()>0)
            {
                ViewData["copys"] = list;
                webInfo wi = list.First();
                ViewData["desc"] = wi.web_desc;//描述
                ViewData["key"] = wi.web_keywords;//关键字
                ViewData["address"] = wi.web_address;//地址
                ViewData["post"] = wi.web_postcode;//邮编
                ViewData["copy"] = wi.web_copyright;//版权
                ViewData["tel"] = wi.web_tel;//联系电话
            }
            return View();
        }

        //实现教师登陆功能
        [HttpPost]
        public ActionResult LoginOn(FormCollection collection)
        {
            try
            {
                using (DBDataContext db = new DBDataContext())
                {
                    //教师和管理员登录
                    if (collection["th_role"].ToString() != "3")
                    {
                        List<teacher> list = (from a in db.teacher where a.th_id.ToString() == collection["th_id"] && a.th_password == collection["th_password"] && a.th_role ==Convert.ToInt32(collection["th_role"]) select a).ToList();
                        if (list.Count > 0)
                        {
                            Session["id"] = list.First().th_id;//教师编号
                            Session["name"] = list.First().th_name;//教师姓名
                            Session["role"] = list.First().th_role;//角色
                            return RedirectToAction("../EducationManager/Index");
                        }
                        else
                        {
                            return Content("<script >alert('用户名、密码或角色有误！');history.go(-1);</script >", "text/html");
                        }
                    }
                    else//学生登录
                    {
                        List<student> list = (from a in db.student where a.stu_num.ToString() == collection["th_id"] && a.stu_password == collection["th_password"] select a).ToList();
                        if (list.Count > 0)
                        {
                            Session["id"] = list.First().stu_num;
                            Session["name"] = list.First().stu_name;
                            Session["role"] = "3";
                            return RedirectToAction("../EducationManager/Index");
                        }
                        else
                        {
                            return Content("<script >alert('用户名、密码或角色有误！');history.go(-1);</script >", "text/html");
                        }
                    }
                }
            }
            catch
            {
                return View();
            }
        }
        /// <summary>
        /// 退出
        /// </summary>
        /// <returns></returns>
        public ActionResult LoginOut()
        {
            Session["id"]=null;
            Session["role"]=null;
            Session["name"]=null;
            return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
        }
        /// <summary>
        /// 修改密码
        /// </summary>
        /// <returns></returns>
        public ActionResult ChangePwd()
        {
            DBDataContext db = new DBDataContext();
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            ChangePwdModel chp = new ChangePwdModel();
            if (Session["role"].ToString() != "3")
            {
                teacher t = (from a in db.teacher where a.th_id == Convert.ToInt32(Session["id"]) select a).First();
                chp.id = t.th_id;
                chp.name = t.th_name;
                chp.password = t.th_password;
            }
            else
            {
                student s = (from a in db.student where a.stu_num == Convert.ToInt32(Session["id"]) select a).First();
                chp.id = s.stu_num;
                chp.name = s.stu_name;
                chp.password = s.stu_password;
            }
            return View(chp);
        }
        [HttpPost]
        public ActionResult ChangePwd(FormCollection collection)
        {
            DBDataContext db = new DBDataContext();
            
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }            
            ChangePwdModel chp = new ChangePwdModel();
            if (Session["role"].ToString() != "3")
            {
                teacher t = (from a in db.teacher where a.th_id == Convert.ToInt32(Session["id"]) select a).First();
                t.th_password = collection["password"];
                db.SubmitChanges();
                return Content("<script>alert('修改成功');window.location.href='ChangePwd';</script>");
            }
            else
            {
                student s = (from a in db.student where a.stu_num == Convert.ToInt32(Session["id"]) select a).First();
                s.stu_password = collection["password"];
                db.SubmitChanges();
                return Content("<script>alert('修改成功');window.location.href='ChangePwd';</script>");
            }
        }
        public ActionResult UserCenters()
        {
            if(Session["id"]==null)//如果session为空则跳转登陆页面
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            if (Session["role"].ToString() != "3")
            {
                return RedirectToAction("TeacherCenter");
            }
            else
            {
                return RedirectToAction("StuCenter");
            }
        }
        public ActionResult TeacherCenter()
        {
            DBDataContext db = new DBDataContext();
            teacher t = (from a in db.teacher where a.th_id == Convert.ToInt32(Session["id"]) select a).First();
            List<classes> clist = (from a in db.classes select a).ToList();
            ViewData["clist"] = clist;
            string[] strs = t.th_classes.Split(',');
            ViewData["str"] = strs;
            return View(t);
        }
        public ActionResult StuCenter()
        {
            DBDataContext db = new DBDataContext();
            student s = (from a in db.student where a.stu_num == Convert.ToInt32(Session["id"]) select a).First();
            return View(s);
        }
    }
}
