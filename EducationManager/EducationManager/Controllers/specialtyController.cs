using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;

namespace EducationManager.Controllers
{
    public class specialtyController : Controller
    {

        //
        // GET: /specialty/
        /// <summary>
        /// 专业列表页
        /// </summary>
        /// <returns></returns>
        public ActionResult SpecialtyList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<specialty> list = new List<specialty>();
            list = (from a in db.specialty select a).ToList();
            //年级绑定
            List<grade> gdlist = (from a in db.grade select a).ToList();
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
            return View(list);
        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="name">专业名称</param>
        /// <param name="dp">dp</param>
        /// <param name="gd">gd</param>
        /// <returns></returns>
        public ActionResult SearchInfo(string name, string dp, string gd)
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
                IEnumerable<specialty> isp = from a in db.specialty where a.sp_name.Contains(name.Trim()) select a;
                if (dp != "")
                {
                    isp = isp.Where(a => a.sp_dpid == Convert.ToInt32(dp));
                }
                if (gd != "")
                {
                    isp = isp.Where(a => a.sp_gdid == Convert.ToInt32(gd));
                }
                string contentstr = "<table class='table table-hover'> <caption>专业信息</caption><tr> <th>专业编号</th><th>专业名称</th><th>院系名称</th><th>年级</th><th class='hidden-xs'>备注</th><th class='hidden-xs'>操作</th></tr>";
                if (isp.Count() <= 0)
                {
                    contentstr += "<td colspan='6' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
                }
                foreach (specialty item in isp)
                {
                    contentstr += "<tr><td>" + item.sp_id + "</td><td>" + item.sp_name + "</td><td>" + item.department.dp_name + "</td><td>" + item.grade.gd_name + "</td><td class='hidden-xs'>" + item.sp_remark + "</td><td class='hidden-xs'><a data-toggle='modal'class='btn btn-primary' style=' height:30px; padding:2px 12px;' href='/specialty/specialtyInfo/" + item.sp_id + "' data-target='#editmodal'>查看详情</a> <a data-toggle='modal' class='btn btn-primary' style=' height:30px; padding:2px 12px; background-color:#666666; border-color:#666666;' href='/specialty/Delete/" + item.sp_id + "' data-target='#delmodal'>删除</a></td>";
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
        // GET: /specialty/Create

        public ActionResult AddInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                //绑定院系信息
                IEnumerable<SelectListItem> listitemdp = db.department.ToList().Select(a => new SelectListItem()
                {
                    Text = a.dp_name,
                    Value = a.dp_id.ToString()
                });
                ViewData["dpm"] = listitemdp;

                //绑定年级信息
                IEnumerable<SelectListItem> gdlist = db.grade.ToList().Select(a => new SelectListItem()
                {
                    Text = a.gd_name,
                    Value = a.gd_id.ToString()
                });
                ViewData["gd"] = gdlist;

                //绑定专业课程信息
                List<course> clist = (from a in db.course select a).ToList();
                ViewData["clist"] = clist;
            }
            return View();
        }

        //
        // POST: /specialty/Create

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
                    specialty sp = new specialty();
                    sp.sp_name = collection["sp_name"];
                    sp.sp_remark = collection["sp_remark"];
                    sp.sp_gdid = Convert.ToInt32(collection["sp_gdid"]);
                    sp.sp_dpid = Convert.ToInt32(collection["sp_dpid"]);
                    sp.sp_csids = collection["sp_csids"];
                    db.specialty.InsertOnSubmit(sp);
                    db.SubmitChanges();
                }
                return RedirectToAction("specialtyList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /specialty/Edit/5

        public ActionResult SpecialtyInfo(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            specialty sp = new specialty();
            using (DBDataContext db = new DBDataContext())
            {
                sp = (from a in db.specialty where a.sp_id == id select a).First();
                string[] strs = sp.sp_csids.Split(',');
                ViewData["strs"] = strs;
                //绑定院系信息

                IEnumerable<SelectListItem> listitemdp = db.department.ToList().Select(a => new SelectListItem()
                {
                    Text = a.dp_name,
                    Value = a.dp_id.ToString()
                });
                foreach (var item in listitemdp)
                {
                    if (sp.sp_dpid == Convert.ToInt32(item.Value))
                    {
                        item.Selected = true;
                    }
                }
                ViewData["dpm"] = listitemdp;

                //绑定年级信息
                IEnumerable<SelectListItem> gdlist = db.grade.ToList().Select(a => new SelectListItem()
                {
                    Text = a.gd_name,
                    Value = a.gd_id.ToString()
                });
                foreach (var item in gdlist)
                {
                    if (sp.sp_gdid == Convert.ToInt32(item.Value))
                    {
                        item.Selected = true;
                    }
                }
                ViewData["gd"] = gdlist;

                //绑定专业课程信息
                List<course> clist = (from a in db.course select a).ToList();
                ViewData["clist"] = clist;


            }
            return View(sp);
        }

        //
        // POST: /specialty/Edit/5

        [HttpPost]
        public ActionResult SpecialtyInfo(int id, FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add update logic here
                specialty sp = new specialty();
                using (DBDataContext db = new DBDataContext())
                {
                    sp = (from a in db.specialty where a.sp_id == id select a).First();
                    IEnumerable<SelectListItem> listitemdp = db.department.ToList().Select(a => new SelectListItem()
                    {
                        Text = a.dp_name,
                        Value = a.dp_id.ToString()
                    });
                    foreach (var item in listitemdp)
                    {
                        if (sp.sp_dpid == Convert.ToInt32(item.Value))
                        {
                            item.Selected = true;
                        }
                    }
                    ViewData["dpm"] = listitemdp;

                    //绑定年级信息
                    IEnumerable<SelectListItem> gdlist = db.grade.ToList().Select(a => new SelectListItem()
                    {
                        Text = a.gd_name,
                        Value = a.gd_id.ToString()
                    });
                    foreach (var item in gdlist)
                    {
                        if (sp.sp_gdid == Convert.ToInt32(item.Value))
                        {
                            item.Selected = true;
                        }
                    }
                    ViewData["gd"] = gdlist;
                    sp.sp_name = collection["sp_name"];
                    sp.sp_remark = collection["sp_remark"];
                    sp.sp_dpid = Convert.ToInt32(collection["sp_dpid"]);
                    sp.sp_gdid = Convert.ToInt32(collection["sp_gdid"]);
                    sp.sp_csids = collection["sp_csids"];
                    db.SubmitChanges();
                }
                return RedirectToAction("specialtyList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /specialty/Delete/5

        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            specialty sp = new specialty();
            using (DBDataContext db = new DBDataContext())
            {
                sp = (from a in db.specialty where a.sp_id == id select a).First();
            }
            return View(sp);
        }

        //
        // POST: /specialty/Delete/5

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
                specialty sp = new specialty();
                using (DBDataContext db = new DBDataContext())
                {
                    sp = (from a in db.specialty where a.sp_id == id select a).First();
                    db.specialty.DeleteOnSubmit(sp);
                    db.SubmitChanges();
                }
                return RedirectToAction("specialtyList");
            }
            catch
            {
                return View();
            }
        }
    }
}
