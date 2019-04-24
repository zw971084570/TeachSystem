using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;

namespace EducationManager.Controllers
{
    public class gradeController : Controller
    {
        //
        // GET: /grade/

        public ActionResult GradeList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            List<grade> list=new List<grade>();
            using (DBDataContext db = new DBDataContext())
            {
                list = (from a in db.grade select a).ToList();
            }
            return View(list);
        }
         /// <summary>
        /// 查询
        /// </summary>
        /// <param name="collection"></param>
        /// <returns></returns>

        public ActionResult SearchInfo(string name)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                List<grade> list = new List<grade>();
                using (DBDataContext db = new DBDataContext())
                {
                        list = (from a in db.grade where a.gd_name.Contains(name.Trim()) select a).ToList();
                }
                string contentstr = "<table class='table table-hover'> <caption>年级信息</caption><tr> <th>年级编号</th><th>年级名称</th><th class='hidden-xs'>备注</th><th class='hidden-xs'>操作</th></tr>";
                if (list.Count <= 0)
                {
                    contentstr += "<td colspan='4' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
                }
                foreach (grade item in list)
                {
                    contentstr += "<tr><td>" + item.gd_id + "</td><td>" + item.gd_name + "</td><td class='hidden-xs'>" + item.gd_remark + "</td><td class='hidden-xs'><a data-toggle='modal' class='btn btn-primary' style=' height:30px; padding:2px 12px;' href='/grade/GradeInfo/" + item.gd_id + "' data-target='#editmodal'>查看详情</a> <a data-toggle='modal' class='btn btn-primary' style=' height:30px; padding:2px 12px;background-color:#666666; border-color:#666666;' href='/grade/Delete/" + item.gd_id + "' data-target='#delmodal'>删除</a></td>";
                }
                contentstr += "</table>";
                return Content(contentstr);
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /grade/Create

        public ActionResult AddInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            List<SelectListItem> list=new List<SelectListItem>();
            //循环遍历枚举值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.gradeName)))
            {
                string names = Enum.GetName(typeof(PublicEnum.gradeName), item);
                list.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["grades"] = list;
            return View();
        }

        //
        // POST: /grade/Create

        [HttpPost]
        public ActionResult AddInfo(FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add insert logic here
                grade gd = new grade();
                using (DBDataContext db = new DBDataContext())
                {
                    gd.gd_name = collection["gd_name"];
                    gd.gd_remark = collection["gd_remark"];
                    db.grade.InsertOnSubmit(gd);
                    db.SubmitChanges();
                }
                return RedirectToAction("gradeList");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /grade/Edit/5
        /// <summary>
        /// 班级详情页面/编辑班级信息页面
        /// </summary>
        /// <param name="id">班级编号</param>
        /// <returns></returns>
        public ActionResult GradeInfo(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            grade gd = new grade();
            using (DBDataContext db = new DBDataContext())
            {
                gd = (from a in db.grade where a.gd_id==id select a).First();
                List<SelectListItem> list = new List<SelectListItem>();
                //循环遍历枚举值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.gradeName)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.gradeName), item);
                    if (gd.gd_name == names)
                    {
                        list.Add(new SelectListItem() { Text = names, Value = names,Selected=true });
                    }
                    else
                    {
                        list.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["grades"] = list;
            }
            return View(gd);
        }

        //
        // POST: /grade/Edit/5
        /// <summary>
        ///  班级详情功能/编辑班级信息功能
        /// </summary>
        /// <param name="id">班级编号</param>
        /// <param name="collection">班级信息</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GradeInfo(int id, FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add update logic here
                grade gd = new grade();
                using (DBDataContext db = new DBDataContext())
                {
                    gd = (from a in db.grade where a.gd_id==id select a).First();
                    gd.gd_name = collection["gd_name"];
                    gd.gd_remark = collection["gd_remark"];
                    db.SubmitChanges();
                }
                return RedirectToAction("gradeList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /grade/Delete/5
 
        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            grade gd = new grade();
            using (DBDataContext db = new DBDataContext())
            {
                gd = (from a in db.grade where a.gd_id == id select a).First();
            }
            return View(gd);
        }

        //
        // POST: /grade/Delete/5

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
                grade gd = new grade();
                using (DBDataContext db = new DBDataContext())
                {
                    gd = (from a in db.grade where a.gd_id == id select a).First();
                    db.grade.DeleteOnSubmit(gd);
                    db.SubmitChanges();
                }
                return RedirectToAction("gradeList");
            }
            catch
            {
                return View();
            }
        }
    }
}
