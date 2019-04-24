using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;

namespace EducationManager.Controllers
{
    public class courseController : Controller
    {
        //
        // GET: /course/

        public ActionResult CourseList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<course> list = (from a in db.course select a).ToList();
            //绑定学期信息
            List<semester> stlist = (from a in db.semester select a).ToList();
            List<SelectListItem> itemlist = new List<SelectListItem>();
            foreach (semester item in stlist)
            {
                itemlist.Add(new SelectListItem() { Text = item.st_name, Value = item.st_id.ToString() });
            }
            ViewData["st"] = itemlist;
            return View(list);
        }
        /// <summary>
        /// 搜索查询
        /// </summary>
        /// <param name="name">课程名称</param>
        /// <param name="st">学期</param>
        /// <returns></returns>
        public ActionResult SearchInfo(string name, string st)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                if (name == null)
                {
                    name = "";
                }
                DBDataContext db = new DBDataContext();
                IEnumerable<course> list = from a in db.course where a.cs_name.Contains(name.Trim()) select a;
                if (st != "")
                {
                    list = list.Where(a => a.cs_stid == Convert.ToInt32(st));
                }
                string contentstr = "<table class='table table-hover'> <caption>课程信息</caption> <tr> <th>课程编号</th><th>课程名称</th><th>学期</th><th class='hidden-xs'>备注</th><th class='hidden-xs'>操作</th></tr>";
                if (list.Count() <= 0)
                {
                    contentstr += "<td colspan='11' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
                }
                foreach (course item in list)
                {
                    contentstr += "<tr><td>" + item.cs_id + "</td><td>" + item.cs_name + "</td><td>" + item.semester.st_name + "</td><td class='hidden-xs'>" + item.cs_remark + "</td><td class='hidden-xs'><a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px;' href='/course/courseInfo/" + item.cs_id + "' data-target='#editmodal'>查看详情</a> <a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px; background-color: #666666;border-color: #666666;' href='/course/Delete/" + item.cs_id + "' data-target='#delmodal'>删除</a></td>";
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
        // GET: /course/Create

        public ActionResult AddInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            IEnumerable<SelectListItem> list = db.semester.ToList().Select(a => new SelectListItem()
            {
                Text = a.st_name,
                Value = a.st_id.ToString()
            });
            ViewData["st"] = list;
            return View();
        }

        //
        // POST: /course/Create

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
                using (DBDataContext db = new DBDataContext())
                {
                    course cs = new course();
                    cs.cs_name = collection["cs_name"];
                    cs.cs_stid = Convert.ToInt32(collection["cs_stid"]);
                    cs.cs_remark = collection["cs_remark"];
                    db.course.InsertOnSubmit(cs);
                    db.SubmitChanges();
                }
                return RedirectToAction("CourseList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /course/Edit/5

        public ActionResult CourseInfo(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                course cs = (from a in db.course where a.cs_id == id select a).First();
                IEnumerable<SelectListItem> list = db.semester.ToList().Select(a => new SelectListItem()
                {
                    Text = a.st_name,
                    Value = a.st_id.ToString()
                });
                foreach (var item in list)
                {
                    if (item.Value == cs.cs_stid.ToString())
                    {
                        item.Selected = true;
                    }
                }
                ViewData["st"] = list;
                return View(cs);
            }

        }

        //
        // POST: /course/Edit/5

        [HttpPost]
        public ActionResult CourseInfo(int id, FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add update logic here
                using (DBDataContext db = new DBDataContext())
                {
                    course cs = (from a in db.course where a.cs_id == id select a).First();
                    cs.cs_name = collection["cs_name"];
                    cs.cs_stid = Convert.ToInt32(collection["cs_stid"]);
                    cs.cs_remark = collection["cs_remark"];
                    db.SubmitChanges();
                }
                return RedirectToAction("CourseList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /course/Delete/5

        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                course cs = (from a in db.course where a.cs_id == id select a).First();
                return View(cs);
            }

        }

        //
        // POST: /course/Delete/5

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
                    course cs = (from a in db.course where a.cs_id == id select a).First();
                    db.course.DeleteOnSubmit(cs);
                    db.SubmitChanges();
                }
                return RedirectToAction("CourseList");
            }
            catch
            {
                return View();
            }
        }
    }
}
