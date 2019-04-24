using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;

namespace EducationManager.Controllers
{
    public class classController : Controller
    {
        
        //
        // GET: /class/

        public ActionResult ClassList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<classes> list = (from a in db.classes select a).ToList();
            //年级绑定
            List<grade> gdlist = (from a in db.grade select a).Distinct().ToList();
            List<SelectListItem> gditem = new List<SelectListItem>();
            foreach (var item in gdlist)
            {
                gditem.Add(new SelectListItem() { Text = item.gd_name, Value = item.gd_id.ToString() });
            }
            ViewData["gd"] = gditem;
            //院系绑定
            List<department> dplist = (from a in db.department select a).ToList();
            List<SelectListItem> dpitem = new List<SelectListItem>();
            foreach (var item in dplist)
            {
                dpitem.Add(new SelectListItem() { Text = item.dp_name, Value = item.dp_id.ToString() });
            }
            ViewData["dp"] = dpitem;

            //专业绑定
            List<specialty> splist = (from a in db.specialty select a).ToList();
            List<SelectListItem> spitem = new List<SelectListItem>();
            foreach (var item in splist)
            {
                spitem.Add(new SelectListItem() { Text = item.sp_name, Value = item.sp_id.ToString() });
            }
            ViewData["sp"] = spitem;
            return View(list);
        }
        /// <summary>
        /// 搜索
        /// </summary>
        /// <param name="name">班级名称</param>
        /// <param name="dp">院系</param>
        /// <param name="gd">年级</param>
        /// <param name="RoomName">教室名称</param>
        /// <returns></returns>
        public ActionResult SearchInfo(string name, string dp,string sp,string gd, string RoomName)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
              DBDataContext db = new DBDataContext();
                if (name == null)
                {
                    name = "";
                }
                if (RoomName == null)
                {
                    RoomName = "";
                }
                IEnumerable<classes> icles = from a in db.classes where a.cl_name.Contains(name.Trim()) && a.cl_room.Contains(RoomName.Trim()) select a;
                                  
                if (dp != "")
                {
                    icles = icles.Where(a => a.specialty.department.dp_id == Convert.ToInt32(dp)).ToList();
                }
                if (sp != "")
                {
                    icles = icles.Where(a => a.cl_spid == Convert.ToInt32(sp));
                }
                if (gd != "")
                {
                    icles = icles.Where(a => a.specialty.grade.gd_id == Convert.ToInt32(gd));
                }
                string contentstr = "<table class='table table-hover'><caption>班级信息</caption> <tr> <th class='hidden-xs'>班级编号</th><th>班级名称</th><th class='hidden-xs'>院系</th><th>专业</th><th>年级</th><th>教室</th><th class='hidden-xs'>备注</th><th class='hidden-xs'>操作</th></tr>";
                if (icles.Count() <= 0)
                {
                    contentstr += "<td colspan='8' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
                }
                foreach (classes item in icles)
                {
                    contentstr += "<tr><td class='hidden-xs'>" + item.cl_id + "</td><td>" + item.cl_name + "</td><td class='hidden-xs'>" + item.specialty.department.dp_name + "</td><td>" + item.specialty.sp_name + "</td><td>" + item.specialty.grade.gd_name + "</td><td>" + item.cl_room + "</td><td class='hidden-xs'>" + item.cl_remark + "</td><td class='hidden-xs'><a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px;' href='/class/ClassInfo/" + item.cl_id + "' data-target='#editmodal'>查看详情</a> <a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px; background-color: #666666;border-color: #666666;' href='/class/Delete/" + item.cl_id + "' data-target='#delmodal'>删除</a></td>";
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
        // GET: /class/Create

        public ActionResult AddInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db=new DBDataContext();
            IEnumerable<SelectListItem> splist = db.specialty.ToList().Select(a => new SelectListItem()
            {
                Text = a.sp_name,
                Value = a.sp_id.ToString()
            });
            ViewData["sp"] = splist;
            return View();
        }

        //
        // POST: /class/Create

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
                    classes cl = new classes();
                    cl.cl_name = collection["cl_name"];
                    cl.cl_spid =Convert.ToInt32(collection["cl_spid"]);
                    cl.cl_room = collection["cl_room"];
                    cl.cl_remark = collection["cl_remark"];
                    db.classes.InsertOnSubmit(cl);
                    db.SubmitChanges();
                }
                return RedirectToAction("ClassList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /class/Edit/5

        public ActionResult ClassInfo(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
              
                classes cl = (from a in db.classes where a.cl_id == id select a).First();
                //绑定专业名称信息
                IEnumerable<SelectListItem> splist = db.specialty.ToList().Select(a => new SelectListItem()
                {
                    Text = a.sp_name,
                    Value = a.sp_id.ToString()
                });
                foreach (var item in splist)
                {
                    if (item.Value == cl.cl_spid.ToString())
                    {
                        item.Selected = true;
                    }
                }
                ViewData["sp"] = splist;
                return View(cl);
            }
           
        }

        //
        // POST: /class/Edit/5

        [HttpPost]
        public ActionResult ClassInfo(int id, FormCollection collection)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            try
            {
                // TODO: Add update logic here
                using (DBDataContext db = new DBDataContext())
                {
                    classes cl = (from a in db.classes where a.cl_id == id select a).First();
                    cl.cl_name = collection["cl_name"];
                    cl.cl_spid = Convert.ToInt32(collection["cl_spid"]);
                    cl.cl_room = collection["cl_room"];
                    cl.cl_remark = collection["cl_remark"];
                    db.SubmitChanges();
                }
                return RedirectToAction("ClassList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /class/Delete/5

        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                classes cl = (from a in db.classes where a.cl_id == id select a).First();
                return View(cl);
            }
        }

        //
        // POST: /class/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            try
            {
                // TODO: Add delete logic here

                using (DBDataContext db = new DBDataContext())
                {
                    classes cl = (from a in db.classes where a.cl_id == id select a).First();
                    db.classes.DeleteOnSubmit(cl);
                    db.SubmitChanges();
                }
                return RedirectToAction("ClassList");
            }
            catch
            {
                return View();
            }
        }
    }
}
