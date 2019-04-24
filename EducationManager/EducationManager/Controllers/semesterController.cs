using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;
using System.Collections;

namespace EducationManager.Controllers
{
    public class semesterController : Controller
    {
        //
        // GET: /semester/

        public ActionResult semesterList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                List<semester> list = (from a in db.semester select a).ToList();
                List<SelectListItem> itemlist = new List<SelectListItem>();
                foreach (semester item in list)
                {
                    itemlist.Add(new SelectListItem() { Text = item.st_name, Value = item.st_id.ToString() });
                }
                ViewData["st"] = itemlist;
                return View(list);
            }
        }
        public ActionResult SearchInfo(string st)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                DBDataContext db = new DBDataContext();
                IEnumerable<semester> list = from a in db.semester select a;
                if (st != "")
                {
                    list = list.Where(a => a.st_id == Convert.ToInt32(st));
                }
                string contentstr = "<table class='table table-hover'><caption>学期信息</caption><tr> <th>学期编号</th><th>学期名称</th><th class='hidden-xs'>备注</th><th class='hidden-xs'>操作</th></tr>";
                if (list.Count() <= 0)
                {
                    contentstr += "<td colspan='4' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
                }
                foreach (semester item in list)
                {
                    contentstr += "<tr><td>" + item.st_id + "</td><td>" + item.st_name + "</td><td class='hidden-xs'>" + item.st_remark + "</td><td class='hidden-xs'><a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px;' href='/semester/semesterInfo/" + item.st_id + "' data-target='#editmodal'>查看详情</a> <a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px; background-color: #666666;border-color: #666666;' href='/semester/Delete/" + item.st_id + "' data-target='#delmodal'>删除</a></td>";
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
        // GET: /semester/Create

        public ActionResult AddInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            //添加学期下拉框内容
            List<SelectListItem> stlist = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.semesterName)))
            {
                string names = Enum.GetName(typeof(PublicEnum.semesterName), item);
                stlist.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["st"] = stlist;
            return View();
        }

        //
        // POST: /semester/Create

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
                    semester st = new semester();
                    st.st_name = collection["st_name"];
                    st.st_remark = collection["st_remark"];
                    db.semester.InsertOnSubmit(st);
                    db.SubmitChanges();
                }
                return RedirectToAction("semesterList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /semester/Edit/5

        public ActionResult semesterInfo(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                semester st = (from a in db.semester where a.st_id == id select a).First();

                //添加学期下拉框内容
                List<SelectListItem> stlist = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.semesterName)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.semesterName), item);
                    if (st.st_name == names)
                    {
                        stlist.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        stlist.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["st"] = stlist;
                return View(st);
            }

        }

        //
        // POST: /semester/Edit/5

        [HttpPost]
        public ActionResult semesterInfo(int id, FormCollection collection)
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
                    semester st = (from a in db.semester where a.st_id == id select a).First();
                    st.st_name = collection["st_name"];
                    st.st_remark = collection["st_remark"];
                    db.SubmitChanges();
                }
                return RedirectToAction("semesterList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /semester/Delete/5

        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                semester st = (from a in db.semester where a.st_id == id select a).First();
                return View(st);
            }
        }

        //
        // POST: /semester/Delete/5

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
                    semester st = (from a in db.semester where a.st_id == id select a).First();
                    db.semester.DeleteOnSubmit(st);
                    db.SubmitChanges();
                }
                return RedirectToAction("semesterList");
            }
            catch
            {
                return View();
            }
        }
    }
}
