using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;
using Newtonsoft.Json;

namespace EducationManager.Controllers
{
    public class menuController : Controller
    {
        //
        // GET: /menu/

        public ActionResult MenuList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                List<menuInfo> list = (from a in db.menuInfo select a).ToList();
                if (list.Count() > 0)
                {
                    return View(list);
                }
                else
                {
                    return View();
                }
            }
        }
        /// <summary>
        /// 搜索查询
        /// </summary>
        /// <param name="name">功能名称</param>
        /// <returns></returns>
        //public ActionResult SearchInfo(string name)
        //{
        //    try
        //    {
        //        if (Session["id"] == null)
        //        {
        //            return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
        //        }
        //        List<menuInfo> list = new List<menuInfo>();
        //        using (DBDataContext db = new DBDataContext())
        //        {
        //            list = (from a in db.menuInfo where a.mn_name.Contains(name.Trim()) select a).ToList();
        //        }

        //        string contentstr = "<table class='table table-hover'> <caption>菜单信息</caption> <tr> <th>编号</th><th>菜单名称</th><th>菜单级别</th><th class='hidden-xs'>链接地址</th><th class='hidden-xs'>备注</th><th class='hidden-xs'>操作</th></tr>";
        //        if (list.Count <= 0)
        //        {
        //            contentstr += "<td colspan='6' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
        //        }
        //        foreach (menuInfo item in list)
        //        {
        //            string jb = "一级菜单";
        //            if (item.mn_pId != null)
        //            {
        //                jb = "二级菜单";
        //            }
        //            contentstr += "<tr><td>" + item.mn_id + "</td><td>" + item.mn_name + "</td><td>" + jb + "</td><td class='hidden-xs'>" + item.mn_url + "</td><td class='hidden-xs'>" + item.mn_remark + "</td><td class='hidden-xs'><a data-toggle='modal' class='btn btn-primary' style=' height:30px; padding:2px 12px;' href='/functions/FunctionsInfo/" + item.mn_id + "' data-target='#editmodal'>查看详情</a> <a data-toggle='modal' class='btn btn-primary' style=' height:30px; padding:2px 12px;background-color:#666666; border-color:#666666;' href='/functions/Delete/" + item.mn_id + "' data-target='#delmodal'>删除</a></td>";
        //        }
        //        contentstr += "</table>";

        //        return Content(contentstr);
        //    }
        //    catch
        //    {
        //        return View();
        //    }
        //}
        public ActionResult SearchInfo1(string name)
        {
            string json = null;
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                List<menuInfo> list = new List<menuInfo>();
                DBDataContext db = new DBDataContext();
                list = (from a in db.menuInfo where a.mn_name.Contains(name.Trim()) select a).ToList();
                json = JsonConvert.SerializeObject(list);                
                return Json(json);
            }
            catch
            {
                return Json(json);
            }
        }

        //
        // GET: /menu/Create

        /// <summary>
        /// 功能页面
        /// </summary>
        /// <returns></returns>
        public ActionResult AddInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            IEnumerable<SelectListItem> itemlist = db.menuInfo.Where(a => a.mn_pId == null).Select(a => new SelectListItem()
            {
                Text = a.mn_name,
                Value = a.mn_id.ToString()
            });
            ViewData["mn"] = itemlist;
            return View();
        }

        /// <summary>
        /// 功能实现
        /// </summary>
        /// <param name="collection">功能信息</param>
        /// <returns></returns>
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
                    menuInfo mn = new menuInfo();
                    mn.mn_pId = null;
                    mn.mn_url = null;
                    //如果不是父级菜单就设置菜单的父级菜单和链接地址
                    if (collection["mn"] != null && collection["mn"] != "")
                    {
                        mn.mn_pId = Convert.ToInt32(collection["mn"]);
                        mn.mn_url = collection["mn_url"];
                    }
                    mn.mn_name = collection["mn_name"];
                    mn.mn_remark = collection["mn_remark"];
                    db.menuInfo.InsertOnSubmit(mn);
                    db.SubmitChanges();
                }
                return RedirectToAction("MenuList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /functions/Edit/5
        /// <summary>
        /// 详情页面
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns></returns>
        public ActionResult MenuInfo(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
                menuInfo mn = (from a in db.menuInfo where a.mn_id == id select a).First();
                IEnumerable<SelectListItem> itemlist = db.menuInfo.Where(a => a.mn_pId == null).Select(a => new SelectListItem()
                {
                    Text = a.mn_name,
                    Value = a.mn_id.ToString()
                });
                
                foreach (var item in itemlist)
                {
                    if (mn.mn_pId.ToString() == item.Value)
                    {
                        item.Selected = true;
                    }
                }
                ViewData["mn"] = itemlist;
                return View(mn);
        }

        //
        // POST: /menu/Edit/5

        //
        // POST: /functions/Edit/5
        /// <summary>
        /// 修改功能
        /// </summary>
        /// <param name="id">功能编号</param>
        /// <param name="collection">功能内容</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult MenuInfo(int id, FormCollection collection)
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
                    menuInfo mn = (from a in db.menuInfo where a.mn_id == id select a).First();
                    mn.mn_url = null;
                    mn.mn_pId = null;
                    if (collection["mn_pId"] != null && collection["mn_pId"] != "")
                    {
                        mn.mn_url = collection["mn_url"];
                        mn.mn_pId =Convert.ToInt32(collection["mn_pId"]);
                    }
                    mn.mn_name = collection["mn_name"];                
                    mn.mn_remark = collection["mn_remark"];
                    db.SubmitChanges();
                }
                return RedirectToAction("MenuList");
            }
            catch
            {
                return View();
            }
        }


        /// <summary>
        /// 删除页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                menuInfo mn = (from a in db.menuInfo where a.mn_id == id select a).First();
                return View(mn);
            }
        }
        /// <summary>
        /// 实现删除的功能
        /// </summary>
        /// <param name="id"></param>
        /// <param name="collection"></param>
        /// <returns></returns>
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
                    menuInfo mn = (from a in db.menuInfo where a.mn_id == id select a).First();
                    db.menuInfo.DeleteOnSubmit(mn);
                    db.SubmitChanges();
                }
                return RedirectToAction("MenuList");
            }
            catch
            {
                return View();
            }
        }
    }
}
