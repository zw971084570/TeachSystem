using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;

namespace EducationManager.Controllers
{
    public class departmentController : Controller
    {
        //
        // GET: /department/
        /// <summary>
        /// 院系列表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult DepartmentList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            List<department> list = new List<department>();
            using (DBDataContext db = new DBDataContext())
            {
                list = (from a in db.department select a).ToList();
            }
            return View(list);
        }
        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="collection"></param>
        /// <returns></returns>
        public ActionResult SearchInfo(string name,string type)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                List<department> list = new List<department>();
                using (DBDataContext db = new DBDataContext())
                {
                    list = (from a in db.department where a.dp_name.Contains(name.Trim()) select a).ToList();
                    if (type != "0")
                    {
                        list = (from a in db.department where a.dp_name.Contains(name.Trim()) && a.dp_type == type select a).ToList();
                    }
                }
                string contentstr = "  <table class='table table-hover'><caption>院系信息</caption> <tr> <th>院系编号</th><th>院系名称</th><th class='hidden-xs'>院系类型(文理科)</th><th class='hidden-xs'>院系创办时间</th><th>院系负责人</th><th>所在校区</th><th class='hidden-xs'>操作</th></tr>";
                if (list.Count <= 0)
                {
                    contentstr += "<td colspan='8' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
                }
                foreach (department item in list)
                {
                    contentstr += "<tr><td>" + item.dp_id + "</td><td>" + item.dp_name + "</td><td class='hidden-xs'>" + item.dp_type + "</td><td class='hidden-xs'>" + item.dp_cretateTime + "</td><td>" + item.dp_leader + "</td><td>" + item.dp_campus + "</td><td class='hidden-xs'><a data-toggle='modal' class='btn btn-primary' style=' height:30px; padding:2px 12px;' href='/department/departmentInfo/" + item.dp_id + "' data-target='#editmodal'>查看详情</a> <a data-toggle='modal' class='btn btn-primary' style=' height:30px; padding:2px 12px;background-color:#666666; border-color:#666666;' href='/department/Delete/" + item.dp_id + "' data-target='#delmodal'>删除</a></td>";
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
        // GET: /department/Create
        /// <summary>
        /// 添加院系信息页面
        /// </summary>
        /// <returns></returns>
        public ActionResult AddInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            //院系列别读取并绑定--文科/理科
            List<SelectListItem> list = new List<SelectListItem>();
            //循环遍历枚举对象中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.departType)))
            {
                string names = Enum.GetName(typeof(PublicEnum.departType), item);
                list.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["type"] = list;
            return View();
        }

        //
        // POST: /department/Create
        /// <summary>
        /// 添加院系信息功能
        /// </summary>
        /// <returns>院系信息</returns>
        [HttpPost]
        public ActionResult AddInfo(FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                using (DBDataContext db = new DBDataContext())
                {
                    department dp = new department();
                    dp.dp_name = collection["dp_name"];//院系名字
                    dp.dp_type = collection["dp_type"];//院系类型 文科/理科
                    dp.dp_cretateTime = Convert.ToDateTime(collection["dp_cretateTime"]);//院系创办时间
                    dp.dp_leader = collection["dp_leader"];//院系领导
                    dp.dp_campus = collection["dp_campus"];//院系隶属校区  新校区/老校区/南校区/北校区等等
                    dp.dp_remark = collection["dp_remark"];//备注
                    db.department.InsertOnSubmit(dp);//提交添加院系信息
                    db.SubmitChanges();//提交更新数据
                }

                return RedirectToAction("departmentList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /department/Edit/5

        public ActionResult DepartmentInfo(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            department dp = new department();
            using (DBDataContext db = new DBDataContext())
            {
                dp = (from a in db.department where a.dp_id == id select a).First();
                List<SelectListItem> list = new List<SelectListItem>();
                //循环遍历枚举对象中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.departType)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.departType), item);
                    if (names == dp.dp_type)
                    {
                        list.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        list.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["type"] = list;
            }
            return View(dp);
        }

        //
        // POST: /department/Edit/5

        [HttpPost]
        public ActionResult DepartmentInfo(int id, FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add update logic here
                department dp = new department();
                using (DBDataContext db = new DBDataContext())
                {
                    dp = (from a in db.department where a.dp_id == id select a).First();
                    dp.dp_name = collection["dp_name"];
                    dp.dp_type = collection["dp_type"];
                    dp.dp_cretateTime = Convert.ToDateTime(collection["dp_cretateTime"]);
                    dp.dp_leader = collection["dp_leader"];
                    dp.dp_campus = collection["dp_campus"];
                    dp.dp_remark = collection["dp_remark"];
                    db.SubmitChanges();
                }
                return RedirectToAction("departmentList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /department/Delete/5

        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            department dp = new department();
            using (DBDataContext db = new DBDataContext())
            {
                dp = (from a in db.department where a.dp_id == id select a).First();
            }
            return View(dp);
        }

        //
        // POST: /department/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                department dp = new department();
                using (DBDataContext db = new DBDataContext())
                {
                    dp = (from a in db.department where a.dp_id == id select a).First();
                    db.department.DeleteOnSubmit(dp);
                    db.SubmitChanges();
                }
                return RedirectToAction("departmentList");
            }
            catch
            {
                return View();
            }
        }
    }
}
