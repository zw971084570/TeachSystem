using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;

namespace EducationManager.Controllers
{
    public class powersController : Controller
    {
        //
        // GET: /powers/

        public ActionResult PowersManager(int id=1)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            //查询显示当前所有的权限
            IEnumerable<menuInfo> list = from a in db.menuInfo select a;
            ViewData["mn"] = list;

            //循环遍历当前角色现有权限
            List<powers> pwlist = (from a in db.powers where a.pr_roles == id select a).ToList();
            List<string> strs = new List<string>();
            foreach (var item in pwlist)
            {
                strs.Add(item.pr_muId.ToString());
            }
            ViewData["pw"] = strs;

            //绑定角色
            List<SelectListItem> lista = new List<SelectListItem>();            
            //循环遍历枚举对象中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.roles)))
            {
                string names = Enum.GetName(typeof(PublicEnum.roles), item);
                if (item == id)
                {
                    lista.Add(new SelectListItem() { Text = names, Value = item.ToString(), Selected = true });
                }
                else
                {
                    lista.Add(new SelectListItem() { Text = names, Value = item.ToString() });
                }
            }
            ViewData["pr_roles"] = lista;
            return View();
        }

        //
        // POST: /powers/Create

        [HttpPost]
        public ActionResult PowersManager(FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add insert logic here                
                string fcstr = collection["fc"];
                DBDataContext db = new DBDataContext();
                List<powers> list = (from a in db.powers where a.pr_roles == Convert.ToInt32(collection["pr_roles"]) select a).ToList();
                if (list.Count() > 0)
                {
                    db.powers.DeleteAllOnSubmit(list);
                    db.SubmitChanges();
                }
                if (fcstr != null)
                {
                    string[] fcs = fcstr.Split(',');
                    
                    foreach (string item in fcs)
                    {
                        powers pw = new powers();
                        pw.pr_roles = Convert.ToInt32(collection["pr_roles"]);
                        pw.pr_muId = Convert.ToInt32(item);
                        db.powers.InsertOnSubmit(pw);
                        db.SubmitChanges();
                    }
                }
                return Content("<script >alert('权限分配成功！');window.location.href='PowersManager';</script >");
            }
            catch
            {
                return View();
            }
        }
    }
}
