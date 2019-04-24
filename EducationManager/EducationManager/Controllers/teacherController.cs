using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;

namespace EducationManager.Controllers
{
    public class teacherController : Controller
    {
        //
        // GET: /teacher/

        public ActionResult TeacherList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<teacher> list = (from a in db.teacher select a).ToList();           
            return View(list);
        }
        /// <summary>
        /// 搜索查询
        /// </summary>
        /// <param name="id">教师编号</param>
        /// <param name="name">教师姓名</param>
        /// <param name="cid">身份证号</param>
        /// <param name="title">职称</param>
        /// <returns></returns>
        public ActionResult SearchInfo(string id, string name, string cid, string title)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                if (id == null)
                {
                    id = "";
                }
                if (name == null)
                {
                    name = "";
                }               
                if (cid == null)
                {
                    cid = "";
                }
                DBDataContext db = new DBDataContext();
                IEnumerable<teacher> list = from a in db.teacher where a.th_name.Contains(name.Trim()) && a.th_id.ToString().Contains(id.Trim()) && a.th_cid.Contains(cid.Trim()) select a;
                
                if (title != "0")
                {
                    list = list.Where(a => a.th_title == title);
                }
                string contentstr = "<table class='table table-hover'> <caption>教师信息</caption> <tr> <th>教职工号</th><th>名称</th><th '>角色</th><th class='hidden-xs'>职称</th><th>电话</th><th>身份证号</th><th class='hidden-xs'>院校</th><th class='hidden-xs'>院系</th><th class='hidden-xs'>操作</th></tr>";
                if (list.Count() <= 0)
                {
                    contentstr += "<td colspan='21' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
                }
                foreach (var item in list)
                {
                    string role = "系统管理员";
                    if (item.th_role == 2)
                    {
                        role = "普通教师";
                    }
                    contentstr += "<tr><td>" + item.th_id + "</td><td>" + item.th_name + "</td><td>" + role + "</td><td  class='hidden-xs'>" + item.th_title + "</td><td>" + item.th_tel + "</td><td>" + item.th_cid + "</td><td  class='hidden-xs'>" + item.th_school + "</td><td  class='hidden-xs'>" + item.department.dp_name + "</td><td class='hidden-xs'><a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px;' href='/teacher/teacherInfo/" + item.th_id + "' data-target='#editmodal'>查看详情</a> <a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px; background-color: #666666;border-color: #666666;' href='/teacher/Delete/" + item.th_id + "' data-target='#delmodal'>删除</a></td>";
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
        // GET: /teacher/Create

        public ActionResult AddInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            //角色
            List<SelectListItem> rolelist = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.role)))
            {
                string names = Enum.GetName(typeof(PublicEnum.role), item);
                rolelist.Add(new SelectListItem() { Text = names, Value = item.ToString() });
            }
            ViewData["role"] = rolelist;

            //性别           
            List<SelectListItem> sexlist = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.sex)))
            {
                string names = Enum.GetName(typeof(PublicEnum.sex), item);
                sexlist.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["sex"] = sexlist;

            //学历
            List<SelectListItem> educationlist = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.education)))
            {
                string names = Enum.GetName(typeof(PublicEnum.education), item);
                educationlist.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["education"] = educationlist;

            //职称
            List<SelectListItem> titlelist = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.title)))
            {
                string names = Enum.GetName(typeof(PublicEnum.title), item);
                titlelist.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["title"] = titlelist;

            //民族
            List<SelectListItem> nationlist = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.nation)))
            {
                string names = Enum.GetName(typeof(PublicEnum.nation), item);
                nationlist.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["nation"] = nationlist;

            //政治面貌
            List<SelectListItem> politicalOutlookList = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.politicalOutlook)))
            {
                string names = Enum.GetName(typeof(PublicEnum.politicalOutlook), item);
                politicalOutlookList.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["politicalOutlook"] = politicalOutlookList;

            //所在院系
            DBDataContext db = new DBDataContext();
            IEnumerable<SelectListItem> dplist = db.department.ToList().Select(a => new SelectListItem()
            {
                Text = a.dp_name,
                Value = a.dp_id.ToString()
            });
            ViewData["dp"] = dplist;
            //班级
            List<classes> clist = (from a in db.classes select a).ToList();
            ViewData["clist"] = clist;

            return View();
        }

        //
        // POST: /teacher/Create

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
                    teacher t = new teacher();
                    t.th_password = "123456";
                    t.th_name = collection["th_name"];
                    t.th_role = Convert.ToInt32(collection["th_role"]);
                    t.th_sex = collection["th_sex"];
                    t.th_education = collection["th_education"];
                    t.th_title = collection["th_title"];
                    t.th_sSpecialty = collection["th_sSpecialty"];
                    t.th_nation = collection["th_nation"];
                    t.th_address = collection["th_address"];
                    t.th_tel = collection["th_tel"];
                    t.th_politicalOutlook = collection["th_politicalOutlook"];
                    t.th_cid = collection["th_cid"];
                    t.th_school = collection["th_school"];
                    t.th_dpid = Convert.ToInt32(collection["th_dpid"]);
                    t.th_nowAddress = collection["th_nowAddress"];
                    t.th_birth = Convert.ToDateTime(collection["th_birth"]);
                    t.th_joinTime = Convert.ToDateTime(collection["th_joinTime"]);
                    t.th_classes = collection["th_classes"];
                    t.th_remark = collection["th_remark"];
                    db.teacher.InsertOnSubmit(t);
                    db.SubmitChanges();
                }
                return RedirectToAction("TeacherList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /teacher/Edit/5

        public ActionResult TeacherInfo(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
                teacher t = (from a in db.teacher where a.th_id == id select a).First();
                //角色
                List<SelectListItem> rolelist = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.role)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.role), item);
                    if (t.th_role == item)
                    {
                        rolelist.Add(new SelectListItem() { Text = names, Value = item.ToString(), Selected = true });
                    }
                    else
                    {
                        rolelist.Add(new SelectListItem() { Text = names, Value = item.ToString() });
                    }
                }
                ViewData["role"] = rolelist;

                //性别           
                List<SelectListItem> sexlist = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.sex)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.sex), item);
                    if (t.th_sex == names)
                    {
                        sexlist.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        sexlist.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["sex"] = sexlist;

                //学历
                List<SelectListItem> educationlist = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.education)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.education), item);
                    if (t.th_education == names)
                    {
                        educationlist.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        educationlist.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["education"] = educationlist;

                //职称
                List<SelectListItem> titlelist = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.title)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.title), item);
                    if (t.th_title == names)
                    {
                        titlelist.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        titlelist.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["title"] = titlelist;

                //民族
                List<SelectListItem> nationlist = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.nation)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.nation), item);
                    if (t.th_name == names)
                    {
                        nationlist.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        nationlist.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["nation"] = nationlist;

                //政治面貌
                List<SelectListItem> politicalOutlookList = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.politicalOutlook)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.politicalOutlook), item);
                    if (t.th_politicalOutlook == names)
                    {
                        politicalOutlookList.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        politicalOutlookList.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["politicalOutlook"] = politicalOutlookList;

                //所在院系
                IEnumerable<SelectListItem> dplist = db.department.ToList().Select(a => new SelectListItem()
                {
                    Text = a.dp_name,
                    Value = a.dp_id.ToString()
                });
                foreach (var item in dplist)
                {
                    if (item.Value == t.th_dpid.ToString())
                    {
                        item.Selected = true;
                    }
                }
                ViewData["dp"] = dplist;


                //所带班级
                List<classes> clist = (from a in db.classes select a).ToList();
                ViewData["clist"] = clist;
                string[] strs=t.th_classes.Split(',');
                ViewData["str"] = strs;
                return View(t);

        }

        //
        // POST: /teacher/Edit/5

        [HttpPost]
        public ActionResult TeacherInfo(int id, FormCollection collection)
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
                    teacher t = (from a in db.teacher where a.th_id == id select a).First();
                    t.th_name = collection["th_name"];
                    t.th_role = Convert.ToInt32(collection["th_role"]);
                    t.th_sex = collection["th_sex"];
                    t.th_education = collection["th_education"];
                    t.th_title = collection["th_title"];
                    t.th_sSpecialty = collection["th_sSpecialty"];
                    t.th_nation = collection["th_nation"];
                    t.th_address = collection["th_address"];
                    t.th_tel = collection["th_tel"];
                    t.th_politicalOutlook = collection["th_politicalOutlook"];
                    t.th_cid = collection["th_cid"];
                    t.th_school = collection["th_school"];
                    t.th_dpid = Convert.ToInt32(collection["th_dpid"]);
                    t.th_nowAddress = collection["th_nowAddress"];
                    t.th_birth = Convert.ToDateTime(collection["th_birth"]);
                    t.th_joinTime = Convert.ToDateTime(collection["th_joinTime"]);
                    t.th_classes = collection["th_classes"];
                    t.th_remark = collection["th_remark"];
                    db.SubmitChanges();
                }
                return RedirectToAction("TeacherList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /teacher/Delete/5

        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                teacher t = (from a in db.teacher where a.th_id == id select a).First();
                return View(t);
            }
            return View();
        }

        //
        // POST: /teacher/Delete/5

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
                    teacher t = (from a in db.teacher where a.th_id == id select a).First();
                    db.teacher.DeleteOnSubmit(t);
                    db.SubmitChanges();
                }
                return RedirectToAction("TeacherList");
            }
            catch
            {
                return View();
            }
        }
    }
}
